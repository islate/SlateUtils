//
//  UIImage+INRoundedCornerShadow.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (INRoundedCornerShadow)

+ (UIImage *)createRoundedRectImage:(UIImage *)image size:(CGSize)size cornerRadius:(NSInteger)radius;
+ (UIImage *)imageWithRoundedCorners:(UIImage *)inputImage cornerHeight:(float)ch cornerWidth:(float)cw;
+ (UIImage *)roundedCornerImageRect:(CGRect)rect width:(float)cw;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize ratio:(double)r offset:(CGPoint)offset;
+ (UIImage *)imageWithUIView:(UIView *)view;

@end
