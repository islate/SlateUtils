//
//  NSArray+Shuffle.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)

- (NSMutableArray *)shuffle
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    
    NSMutableArray *copy = [self mutableCopy];
    
    while ([copy count] > 0)
    {
        int index = arc4random() % [copy count];
        id  obj = [copy objectAtIndex:index];
        [array addObject:obj];
        [copy removeObjectAtIndex:index];
    }
    
    return array;
}

@end
