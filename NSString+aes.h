//
//  NSString+aes.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (aes)

- (NSString *)AES128EncryptWithKey:(NSString *)key;
- (NSString *)AES128DecryptWithKey:(NSString *)key;
- (NSData *)DESDecryptWithKey:(NSString *)key;

@end
