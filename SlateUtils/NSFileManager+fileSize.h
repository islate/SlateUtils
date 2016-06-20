//
//  NSFileManager+fileSize.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (fileSize)

- (unsigned long long)fileSizeAtPath:(NSString *)filePath;

@end
