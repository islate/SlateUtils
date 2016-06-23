//
//  NSURL+mediatype.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (mediatype)

- (BOOL)isVideo;
- (BOOL)isImage;
- (BOOL)isPDF;

@end
