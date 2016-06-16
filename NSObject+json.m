//
//  NSObject+json.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "NSObject+json.h"

@implementation NSObject (json)

- (NSString *)JSONString
{
    @try {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    @catch (NSException *exception) {
    }
    return nil;
}

@end
