//
//  UIFont+FontSizeAutoSelect.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
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
