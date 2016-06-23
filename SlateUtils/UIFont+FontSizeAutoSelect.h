//
//  UIFont+FontSizeAutoSelect.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (FontSizeAutoSelect)

+ (UIFont *)fontSizeAutoSelect:(NSString *)string
                       useFont:(UIFont *)font
                   maxFontSize:(CGFloat)max
                  miniFontSize:(CGFloat)min
             constrainedToSize:(CGSize)size
                 lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
