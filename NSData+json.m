//
//  NSData+json.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import "NSData+json.h"

@implementation NSData (json)

- (id)JSONObject
{
    if (self.length == 0)
    {
        return nil;
    }
    
    @try {
        return [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:nil];
    }
    @catch (NSException *exception) {
    }
    return nil;
}

@end
