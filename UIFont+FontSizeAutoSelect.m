//
//  UIFont+FontSizeAutoSelect.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "UIFont+FontSizeAutoSelect.h"

@implementation UIFont (FontSizeAutoSelect)

+ (UIFont *)fontSizeAutoSelect  :(NSString *)string
            useFont             :(UIFont *)font
            maxFontSize         :(CGFloat)max
            miniFontSize        :(CGFloat)min
            constrainedToSize   :(CGSize)size
            lineBreakMode       :(NSLineBreakMode)lineBreakMode
{
    // auto select a fixed font size
    font = [UIFont fontWithName:font.fontName size:max];
    CGSize bigSize = CGSizeMake(size.width, size.height + 999.0);
    
    for (CGFloat f = max; f >= min; f -= 0.25)
    {
        font = [UIFont fontWithName:font.fontName size:f];
        
        CGSize textSize = CGSizeZero;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        CGRect boundingRect = [string boundingRectWithSize:bigSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
        textSize = boundingRect.size;
        
        if (textSize.height <= size.height)
        {
            break;
        }
    }
    
    return font;
}

@end
