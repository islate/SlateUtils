//
//  ImageHelpers.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import <UIKit/UIKit.h>

float GetScaleForProportionalResize(CGSize theSize, CGSize intoSize, bool onlyScaleDown, bool maximize);

CGContextRef CreateCGBitmapContextForSize(CGSize theSize, CGColorSpaceRef optionalColorSpace, CGBitmapInfo optionalInfo);

CGImageRef CreateCGImageFromUIImageScaled(UIImage *inImage, CGFloat scaleFactor);

UIImage *UImageFromPathScaledToSize(NSString *path, CGSize toSize);

UIImage *CreateImageFromImage(UIImage *image, CGFloat scaleFactor);
