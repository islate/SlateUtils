//
//  NSString+UnitConverter.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UnitConverter)
/*
 ===============HOW TO USE================
 Example:
 =========================================
 
 NSString *(^block)(NSArray *) = ^NSString *(NSArray *array) {
 NSArray *units = [NSArray arrayWithObjects:@"W", @"D", @"H", @"M", @"S", nil];
 NSString *rtnStr = @"";
 NSUInteger i = 0;
 for (NSNumber *number in array) {
 float unitNumber = [number floatValue];
 if (unitNumber < 1.0f) {
 if (i == [units count] - 1 && [rtnStr length] == 0) {
 return [NSString stringWithFormat:@"%d%@", (NSInteger)floorf(unitNumber), [units objectAtIndex:i]];
 }
 i++;
 continue;
 }
 rtnStr = [NSString stringWithFormat:@"%@%d%@", rtnStr, (NSInteger)floorf(unitNumber), [units objectAtIndex:i]];
 i++;
 }
 return rtnStr;
 };
 
 NSArray *array = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedLongLong:7],
 [NSNumber numberWithUnsignedLongLong:24],
 [NSNumber numberWithUnsignedLongLong:60],
 [NSNumber numberWithUnsignedLongLong:60], nil];
 NSLog(@"%@", [NSString stringByConvertUnsignedLongLongNumber:3620 withBlock:block withBehaviors:array]);
 NSLog(@"%@", [NSString stringByConvertUnsignedLongLongNumber:3601 withBlock:block withBehaviors:array]);
 NSLog(@"%@", [NSString stringByConvertUnsignedLongLongNumber:86400 withBlock:block withBehaviors:array]);
 NSLog(@"%@", [NSString stringByConvertUnsignedLongLongNumber:86464 withBlock:block withBehaviors:array]);
 NSLog(@"%@", [NSString stringByConvertUnsignedLongLongNumber:691200 withBlock:block withBehaviors:array]);
 NSLog(@"%@", [NSString stringByConvertUnsignedLongLongNumber:36 withBlock:block withBehaviors:array]);
 
 >>>>>>>>> Output:
 1H20S
 1H1S
 1D
 1D1M4S
 1W1D
 36S
 */

+ (NSString *)stringByConvertUnsignedLongLongNumber:(unsigned long long)number withBlock:(NSString *(^)(NSArray *array))block withBehaviors:(NSArray *)behaviors;

+ (NSString *)convertStorageSizeToString:(unsigned long long)size;

@end
