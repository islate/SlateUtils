//
//  NSString+UnitConverter.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import "NSString+UnitConverter.h"

@implementation NSString (UnitConverter)

+ (NSString *)stringByConvertUnsignedLongLongNumber:(unsigned long long)number withBlock:(NSString *(^)(NSArray *array))block withBehaviors:(NSArray *)behaviors
{
    NSUInteger      count = [behaviors count];
    NSMutableArray  *mutableBehaviors = [behaviors mutableCopy];
    
    for (NSUInteger i = count - 2; i < NSUIntegerMax; i--)
    {
        [mutableBehaviors replaceObjectAtIndex:i
                                    withObject:[NSNumber numberWithFloat:
                                                [[mutableBehaviors objectAtIndex:i + 1] unsignedLongLongValue] * [[mutableBehaviors objectAtIndex:i] unsignedLongLongValue]]];
    }
    
    unsigned long long  mod = number;
    NSMutableArray      *array = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < count; i++)
    {
        unsigned long long  currentUnit = [[mutableBehaviors objectAtIndex:i] unsignedLongLongValue];
        float               currentUnitNumber = (float)mod / currentUnit;
        [array addObject:[NSNumber numberWithFloat:currentUnitNumber]];
        mod = mod % currentUnit;
    }
    
    [array addObject:[NSNumber numberWithUnsignedLongLong:mod]];
    return block(array);
}

+ (NSString *)convertStorageSizeToString:(unsigned long long)size
{
    static NSNumberFormatter *formatter = nil;
    static NSArray *sizeArray = nil;
    static NSArray *units = nil;
    if (!formatter) {
        formatter = [[NSNumberFormatter alloc] init];
        [formatter setPositiveFormat:@"#,##0.00"];
    }
    if (!units) {
        units = [NSArray arrayWithObjects:@"TB", @"GB", @"MB", @"KB", nil];
    }
    if (!sizeArray) {
        sizeArray = [NSArray arrayWithObjects:
                     [NSNumber numberWithUnsignedLongLong:1024],
                     [NSNumber numberWithUnsignedLongLong:1024],
                     [NSNumber numberWithUnsignedLongLong:1024],
                     [NSNumber numberWithUnsignedLongLong:1024], nil];
    }
    
    NSString *(^block)(NSArray *) = ^NSString *(NSArray *array) {
        NSUInteger i = 0;
        for (NSNumber *number in array) {
            if ([number floatValue] < 1.0f) {
                if (i == [units count] - 1) {
                    return [NSString stringWithFormat:@"%@%@", [formatter stringFromNumber:number], [units objectAtIndex:i]];
                }
                i++;
                continue;
            }
            return [NSString stringWithFormat:@"%@%@", [formatter stringFromNumber:number], [units objectAtIndex:i]];
        }
        return nil;
    };
    return [NSString stringByConvertUnsignedLongLongNumber:size withBlock:block withBehaviors:sizeArray];
}

@end
