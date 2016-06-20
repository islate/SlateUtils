//
//  UIDevice+IdentifierAddition.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import "UIDevice+IdentifierAddition.h"

#include <sys/sysctl.h>

@implementation UIDevice (IdentifierAddition)

#pragma mark - 越狱判断

- (BOOL)jailbroken
{
    //If the app is running on the simulator
#if TARGET_IPHONE_SIMULATOR
    return NO;
    
    //If its running on an actual device
#else
    BOOL isJailbroken = NO;
    
    //This line checks for the existence of Cydia
    BOOL cydiaInstalled = [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"];
    BOOL canAccessBash = [[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"];
    
    if (canAccessBash || cydiaInstalled) {
        
        //Device is jailbroken
        isJailbroken = YES;
    }
    
    return isJailbroken;
#endif
}

#pragma mark - 设备型号

- (NSString *)hwMachine
{
    static NSString *hwMachine = nil;
    if (!hwMachine) {
        int mib[2];
        size_t len;
        char *p;
        
        mib[0] = CTL_HW;
        mib[1] = HW_MACHINE;
        sysctl(mib, 2, NULL, &len, NULL, 0);
        p = malloc(len);
        sysctl(mib, 2, p, &len, NULL, 0);
        
        hwMachine = [NSString stringWithCString:p encoding:NSUTF8StringEncoding];
        free(p);
    }
    return hwMachine;
}

- (BOOL)isiPad1
{
    static BOOL _isiPad1 = NO;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _isiPad1 = [[self hwMachine] isEqualToString:@"iPad1,1"];
    });
    return _isiPad1;
}

@end
