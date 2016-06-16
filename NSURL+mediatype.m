//
//  NSURL+mediatype.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "NSURL+mediatype.h"

@implementation NSURL (mediatype)

- (BOOL)isVideo
{
    NSString *pathExtension = [[self.absoluteString pathExtension] lowercaseString];
    if (!pathExtension)
    {
        return NO;
    }
    return ([@"m3u8|m4v|mov|mp4|avi|mpg|mpeg|3gp|ts" rangeOfString:pathExtension].location != NSNotFound);
}

- (BOOL)isImage
{
    NSString *pathExtension = [[self.absoluteString pathExtension] lowercaseString];
    if (!pathExtension)
    {
        return NO;
    }
    return ([@"png|jpg|gif|jpeg|webp" rangeOfString:pathExtension].location != NSNotFound);
}

- (BOOL)isPDF
{
    NSString *pathExtension = [[self.absoluteString pathExtension] lowercaseString];
    if (!pathExtension)
    {
        return NO;
    }
    return [pathExtension isEqualToString:@"pdf"];
}

@end
