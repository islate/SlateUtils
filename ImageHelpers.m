//
//  ImageHelpers.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "ImageHelpers.h"

#define kDefaultCGBitmapInfo (kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host)
#define kDefaultCGBitmapInfoNoAlpha (kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Host)

const double kRadPerDeg = 0.0174532925199433;           // pi / 180

// 获取RGB
CGColorSpaceRef GetDeviceRGBColorSpace()
{
    static CGColorSpaceRef deviceRGBSpace = NULL;
    
    if (deviceRGBSpace == NULL)
    {
        deviceRGBSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    return deviceRGBSpace;
}

float GetScaleForProportionalResize(CGSize theSize, CGSize intoSize, bool onlyScaleDown, bool maximize)
{
    float   sx = theSize.width;
    float   sy = theSize.height;
    float   dx = intoSize.width;
    float   dy = intoSize.height;
    float   scale = 1;
    
    if ((sx != 0) && (sy != 0))
    {
        dx = dx / sx;
        dy = dy / sy;
        
        // if maximize is true, take LARGER of the scales, else smaller
        if (maximize)
        {
            scale = (dx > dy) ? dx : dy;
        }
        else
        {
            scale = (dx < dy) ? dx : dy;
        }
        
        if ((scale > 1) && onlyScaleDown)    // reset scale
        {
            scale = 1;
        }
    }
    else
    {
        scale = 0;
    }
    
    return scale;
}

// 创建位图
CGContextRef CreateCGBitmapContextForSize(CGSize theSize,
                                          CGColorSpaceRef optionalColorSpace, CGBitmapInfo optionalInfo)
{
    CGColorSpaceRef colorSpace = (optionalColorSpace == NULL) ? GetDeviceRGBColorSpace() : optionalColorSpace;
    CGBitmapInfo    alphaInfo = ((int32_t)optionalInfo < 0) ? kDefaultCGBitmapInfo : optionalInfo;
    
    return CGBitmapContextCreate(NULL, (size_t)theSize.width, (size_t)theSize.height, 8, 0, colorSpace, alphaInfo);
}

CGImageRef CreateCGImageFromUIImageScaled(UIImage *image, CGFloat scaleFactor)
{
    CGImageRef          newImage = NULL;
    CGContextRef        bmContext = NULL;
    BOOL                mustTransform = YES;
    CGAffineTransform   transform = CGAffineTransformIdentity;
    UIImageOrientation  orientation = image.imageOrientation;
    
    CGImageRef srcCGImage = CGImageRetain(image.CGImage);                       // just in case ;)
    
    size_t  width = CGImageGetWidth(srcCGImage) * scaleFactor;
    size_t  height = CGImageGetHeight(srcCGImage) * scaleFactor;
    
    // These Orientations are rotated 0 or 180 degrees, so they retain the width/height of the image
    if ((orientation == UIImageOrientationUp) || (orientation == UIImageOrientationDown) || (orientation == UIImageOrientationUpMirrored) || (orientation == UIImageOrientationDownMirrored))
    {
        bmContext = CreateCGBitmapContextForSize(CGSizeMake(width, height), NULL, kDefaultCGBitmapInfo);
    }
    else    // The other Orientations are rotated ±90 degrees, so they swap width & height.
    {
        bmContext = CreateCGBitmapContextForSize(CGSizeMake(height, width), NULL, kDefaultCGBitmapInfo);
    }
    
    // CGContextSetInterpolationQuality( bmContext, kCGInterpolationLow );
    CGContextSetBlendMode(bmContext, kCGBlendModeCopy);
    
    switch (orientation)
    {
        case UIImageOrientationDown:        // 0th row is at the bottom, and 0th column is on the right - Rotate 180 degrees
            transform = CGAffineTransformMake(-1.0, 0.0, 0.0, -1.0, width, height);
            break;
            
        case UIImageOrientationLeft:        // 0th row is on the left, and 0th column is the bottom - Rotate -90 degrees
            transform = CGAffineTransformMake(0.0, 1.0, -1.0, 0.0, height, 0.0);
            break;
            
        case UIImageOrientationRight:       // 0th row is on the right, and 0th column is the top - Rotate 90 degrees
            transform = CGAffineTransformMake(0.0, -1.0, 1.0, 0.0, 0.0, width);
            break;
            
        case UIImageOrientationUpMirrored:  // 0th row is at the top, and 0th column is on the right - Flip Horizontal
            transform = CGAffineTransformMake(-1.0, 0.0, 0.0, 1.0, width, 0.0);
            break;
            
        case UIImageOrientationDownMirrored:    // 0th row is at the bottom, and 0th column is on the left - Flip Vertical
            transform = CGAffineTransformMake(1.0, 0.0, 0, -1.0, 0.0, height);
            break;
            
        case UIImageOrientationLeftMirrored:    // 0th row is on the left, and 0th column is the top - Rotate -90 degrees and Flip Vertical
            transform = CGAffineTransformMake(0.0, -1.0, -1.0, 0.0, height, width);
            break;
            
        case UIImageOrientationRightMirrored:   // 0th row is on the right, and 0th column is the bottom - Rotate 90 degrees and Flip Vertical
            transform = CGAffineTransformMake(0.0, 1.0, 1.0, 0.0, 0.0, 0.0);
            break;
            
        default:
            mustTransform = NO;
            break;
    }
    
    if (mustTransform)
    {
        CGContextConcatCTM(bmContext, transform);
    }
    
    CGContextDrawImage(bmContext, CGRectMake(0.0, 0.0, width, height), srcCGImage);
    CGImageRelease(srcCGImage);
    newImage = CGBitmapContextCreateImage(bmContext);
    CFRelease(bmContext);
    
    return newImage;
}

UIImage *UImageFromPathScaledToSize(NSString *path, CGSize toSize)
{
    UIImage *scaledImg = nil;
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];           // get the image
    
    if (img)
    {
        CGSize  imageSize = img.size;
        float   scale = GetScaleForProportionalResize(imageSize, toSize, true, false);
        
        CGImageRef cgImage = CreateCGImageFromUIImageScaled(img, scale);
        
        if (cgImage)
        {
            scaledImg = [UIImage imageWithCGImage:cgImage];     // autoreleased
            CGImageRelease(cgImage);
        }
    }
    
    return scaledImg;   // autoreleased
}

// 从图片创建图片
UIImage *CreateImageFromImage(UIImage *image, CGFloat scaleFactor)
{
    CGImageRef imageRef = image.CGImage;
    NSInteger originWidth = CGImageGetWidth(imageRef);
    NSInteger originHeight = CGImageGetHeight(imageRef);
    
    CGSize imageSize = CGSizeMake(originWidth * scaleFactor, originHeight * scaleFactor);
    
    CGContextRef context = CreateCGBitmapContextForSize(imageSize, NULL, kDefaultCGBitmapInfoNoAlpha );
    
    CGContextSetRGBFillColor(context, 0.0,0.0,0.0,0.0);
    CGContextFillRect(context,CGRectMake(0.0, 0.0, imageSize.width, imageSize.height));
    CGContextScaleCTM(context, scaleFactor, scaleFactor);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, originWidth, originHeight), imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    
    return newImage;
}
