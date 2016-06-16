//
//  NSString+aes.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "NSString+aes.h"

#import "NSData+aes.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (aes)

- (NSString *)AES128EncryptWithKey:(NSString *)key
{
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES128EncryptWithKey:key];
    
    NSString *encryptedString = [encryptedData base64Encoding];
    
    return encryptedString;
}

- (NSString *)AES128DecryptWithKey:(NSString *)key
{
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    NSData *plainData = [encryptedData AES128DecryptWithKey:key];
    
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    
    return plainString;
}

- (NSData *)DESDecryptWithKey:(NSString *)key
{
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [encryptedData bytes],
                                          [encryptedData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSData* plainData = nil;
    if (cryptStatus == kCCSuccess) {
        plainData = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
    }
    return plainData;
}

@end
