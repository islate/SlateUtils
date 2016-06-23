//
//  NSString+urlencode.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import "NSString+urlencode.h"

@implementation NSString (urlencode)

- (NSString *)urlencodeString:(NSStringEncoding)encoding
{
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self,
                                                                                  // NULL, (CFStringRef)@";/?:@&=$+{}<>,",
                                                                                  NULL, (CFStringRef)@";/?:@$+{}<>,",
                                                                                  CFStringConvertNSStringEncodingToEncoding(encoding)));
}

- (NSString *)stringEscapedAsURI {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, CFSTR(";,/?:@&=+$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.!~*'()#"), NULL, kCFStringEncodingUTF8)) ;
}

- (NSString *)stringEscapedAsURIComponent {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, CFSTR("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.!~*'()"), CFSTR("&"), kCFStringEncodingUTF8)) ;
}

- (NSString *)stringUnescapedAsURI {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)self, CFSTR(";,/?:@&=+$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.!~*'()#"), kCFStringEncodingUTF8)) ;
}

- (NSString *)stringUnescapedAsURIComponent {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)self, CFSTR("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.!~*'()"), kCFStringEncodingUTF8)) ;
}

@end
