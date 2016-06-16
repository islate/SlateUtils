//
//  NSString+sha.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SHA)

+ (NSString *)sha256:(NSString *)input;
- (NSString *)sha256;

+ (NSString *)sha1:(NSString *)input;
- (NSString *)sha1;

@end
