//
//  NSString+urlencode.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (urlencode)

- (NSString *)urlencodeString:(NSStringEncoding)encoding;

- (NSString *)stringEscapedAsURI;
- (NSString *)stringEscapedAsURIComponent;
- (NSString *)stringUnescapedAsURI;
- (NSString *)stringUnescapedAsURIComponent;

@end
