//
//  NSData+md5.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "NSData+md5.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5)

- (NSString *)md5
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(self.bytes, self.length, result);
    
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [resultStr appendFormat:@"%02x", result[i]];
    }
    
    return resultStr;
}

@end
