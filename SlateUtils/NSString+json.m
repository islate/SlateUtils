//
//  NSString+json.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import "NSString+json.h"

#import "NSData+json.h"

@implementation NSString (json)

- (id)JSONObject
{
    if (self.length == 0)
    {
        return nil;
    }
    
    return [[self dataUsingEncoding:NSUTF8StringEncoding] JSONObject];
}

@end
