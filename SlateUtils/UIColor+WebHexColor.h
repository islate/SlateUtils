//
//  UIColor+WebHexColor.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WebHexColor)

+ (UIColor *)convertWebRGBColor:(NSString*)webHexColor;

@end
