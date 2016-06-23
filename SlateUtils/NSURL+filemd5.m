//
//  NSURL+filemd5.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import "NSURL+filemd5.h"

#import "NSData+md5.h"

@implementation NSURL (filemd5)

- (NSString *)fileContentMD5
{
    NSString *path = [self path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    return [data md5];
}

@end
