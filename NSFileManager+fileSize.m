//
//  NSFileManager+fileSize.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "NSFileManager+fileSize.h"

@implementation NSFileManager (fileSize)

- (unsigned long long)fileSizeAtPath:(NSString *)filePath
{
    if ([self fileExistsAtPath:filePath])
    {
        return [[self attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}

@end
