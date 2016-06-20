//
//  NSDate+relative.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import "NSDate+relative.h"

@implementation NSDate (relative)

- (NSString *)relativeDescription
{
    NSDate  *now = [NSDate date];
    int     diff = (int)([now timeIntervalSince1970] - [self timeIntervalSince1970]);
    
    if (diff < 60)
    {
        if (diff < 10)
        {
            return @"just now";
        }
        else
        {
            return [NSString stringWithFormat:@"%d seconds ago", diff];
        }
    }
    else
    {
        if ((diff > 60) && (diff < 3600))
        {
            int minutes = diff / 60;
            return [NSString stringWithFormat:@"%d minutes ago", minutes];
        }
        else
        {
            if ((diff > 3600) && (diff < 86400))
            {
                int hours = diff / 3600;
                int minutes = (diff % 3600) / 60;
                
                if (hours > 1)
                {
                    return [NSString stringWithFormat:@"%d hours %d minutes ago", hours, minutes];
                }
                else
                {
                    return [NSString stringWithFormat:@"%d hour %d minutes ago", hours, minutes];
                }
            }
            else
            {
                if ((diff > 86400) && (diff < 2678400))
                {
                    int days = diff / 86400;
                    int hours = (diff % 86400) / 3600;
                    
                    if (days > 1)
                    {
                        if (hours > 1)
                        {
                            return [NSString stringWithFormat:@"%d days %d hours ago", days, hours];
                        }
                        else
                        {
                            return [NSString stringWithFormat:@"%d days %d hour ago", days, hours];
                        }
                    }
                    else
                    {
                        if (hours > 1)
                        {
                            return [NSString stringWithFormat:@"%d day %d hours ago", days, hours];
                        }
                        else
                        {
                            return [NSString stringWithFormat:@"%d day %d hour ago", days, hours];
                        }
                    }
                }
                else
                {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateStyle:NSDateFormatterMediumStyle];
                    NSString *formatted = [formatter stringFromDate:self];
                    return formatted;
                }
            }
        }
    }
}

- (NSString *)timeAgo
{
    NSDate  *now = [NSDate date];
    double  deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double  deltaMinutes = deltaSeconds / 60.0f;
    
    if (deltaMinutes < 60)
    {
        return [NSString stringWithFormat:@"%dm", (int)deltaMinutes];
    }
    else if (deltaMinutes < (24 * 60))
    {
        return [NSString stringWithFormat:@"%dh", (int)(deltaMinutes / 60)];
    }
    else
    {
        return [NSString stringWithFormat:@"%dd", (int)(deltaMinutes / 60 / 24)];
    }
}

- (NSString *)timeAgoInChinese
{
    NSDate  *now = [NSDate date];
    double  deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double  deltaMinutes = deltaSeconds / 60.0f;
    
    if (deltaMinutes < 60)
    {
        return [NSString stringWithFormat:@"%d 分钟前", (int)deltaMinutes];
    }
    else if (deltaMinutes < (24 * 60))
    {
        return [NSString stringWithFormat:@"%d 小时前", (int)(deltaMinutes / 60)];
    }
    else if (deltaMinutes < (24 * 60 * 30))
    {
        return [NSString stringWithFormat:@"%d 天前", (int)(deltaMinutes / 60 / 24)];
    }
    else
    {
        return [NSString stringWithFormat:@"%d 个月前", (int)(deltaMinutes / 60 / 24 / 30)];
    }
}

@end
