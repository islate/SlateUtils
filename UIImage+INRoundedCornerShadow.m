//
//  UIImage+INRoundedCornerShadow.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "UIImage+INRoundedCornerShadow.h"

@implementation UIImage (INRoundedCornerShadow)

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    
    if ((ovalWidth == 0) || (ovalHeight == 0))
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh / 2);
    CGContextAddArcToPoint(context, fw, fh, fw / 2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh / 2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw / 2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh / 2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (UIImage *)createRoundedRectImage:(UIImage *)image size:(CGSize)size cornerRadius:(NSInteger)radius
{
    int w = size.width;
    int h = size.height;
    
    UIImage         *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef    context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect          rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *imageReturn = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    
    return imageReturn;
}

+ (UIImage *)roundedCornerImageRect:(CGRect)rect width:(float)cw
{
    int h = rect.size.height;
    int w = rect.size.width;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef    context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect imgRect = rect;
    imgRect.origin.x = 0;
    imgRect.origin.y = 0;
    
    addRoundedRectToPath(context, imgRect, cw, cw);
    CGContextClosePath(context);
    CGContextClip(context);
    UIColor *c = [UIColor blackColor];
    [c set];
    CGContextFillRect(context, imgRect);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
    CGImageRelease(imageMasked);
    CGColorSpaceRelease(colorSpace);
    return img;
}

+ (UIImage *)imageWithRoundedCorners:(UIImage *)inputImage cornerHeight:(float)ch cornerWidth:(float)cw
{
    int h = inputImage.size.height;
    int w = inputImage.size.width;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef    context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect imgRect = CGRectMake(0, 0, w, h);
    addRoundedRectToPath(context, imgRect, cw, ch);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, imgRect, inputImage.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    float           shadowOffsetY = 1;
    CGContextRef    context2 = CGBitmapContextCreate(NULL, w + 2, h + shadowOffsetY + 1, 8, 4 * (w + 2), colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGColorRef      shadowColor = [[UIColor darkGrayColor] CGColor];
    CGContextSetShadowWithColor(context2, CGSizeMake(0, -shadowOffsetY), 2, shadowColor);
    imgRect = CGRectMake(1, shadowOffsetY + 1, w, h);
    CGContextDrawImage(context2, imgRect, imageMasked);
    CGImageRef imageShadowed = CGBitmapContextCreateImage(context2);
    
    UIImage *img = [UIImage imageWithCGImage:imageShadowed];
    
    CGContextRelease(context2);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageShadowed);
    CGImageRelease(imageMasked);
    
    return img;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize ratio:(double)r offset:(CGPoint)offset
{
    int h = newSize.height;
    int w = newSize.width;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef    context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextScaleCTM(context, r, r);
    
    CGRect rect = CGRectMake(offset.x, offset.y, image.size.width, image.size.height);
    CGContextDrawImage(context, rect, image.CGImage);
    CGImageRef imageTrimmed = CGBitmapContextCreateImage(context);
    
    UIImage *img = [UIImage imageWithCGImage:imageTrimmed];
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageTrimmed);
    CGContextRelease(context);
    
    return img;
}

#pragma mark -
#pragma mark TakeScreenShot
+ (UIImage *)imageWithUIView:(UIView *)view
{
    CGSize imageSize = [view bounds].size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    // Center the context around the window's anchor point
    CGContextTranslateCTM(context, CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    // Apply the window's transform about the anchor point
    CGContextConcatCTM(context, [view transform]);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context,
                          -[view bounds].size.width * [[view layer] anchorPoint].x,
                          -[view bounds].size.height * [[view layer] anchorPoint].y);
    
    // Render the layer hierarchy to the current context
    [[view layer] renderInContext:context];
    
    // Restore the context
    CGContextRestoreGState(context);
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
