//
//  UIColor+WebHexColor.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import "UIColor+WebHexColor.h"

@implementation UIColor (WebHexColor)

+ (UIColor *)convertWebRGBColor:(NSString *)webHexColor
{
    unsigned    hexInt = 0;
    NSScanner   *scanner = [NSScanner scannerWithString:[webHexColor stringByReplacingOccurrencesOfString:@"#" withString:@""]];
    
    [scanner scanHexInt:&hexInt];
    return [UIColor colorWithRed:((hexInt >> 16) & 0xFF) / 255.0 green:((hexInt >> 8) & 0xFF) / 255.0 blue:((hexInt) & 0xFF) / 255.0 alpha:1];
}

@end
