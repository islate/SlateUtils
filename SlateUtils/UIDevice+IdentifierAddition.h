//
//  UIDevice+IdentifierAddition.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (IdentifierAddition)

- (BOOL)jailbroken;
- (BOOL)isiPad1;
- (NSString *)hwMachine;

@end
