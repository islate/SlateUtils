//
//  NSObject+RTPerform.h
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RTPerform)

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg1 withObject:(id)arg2 waitUntilDone:(BOOL)wait;

- (void)performSelectorInBackground:(SEL)aSelector withObject:(id)arg1 withObject:(id)arg2;

- (void)performSelectorOnMainThread:(SEL)aSelector waitUntilDone:(BOOL)wait withObjects:(id)arg, ...;

- (void)performSelectorInBackground:(SEL)aSelector withObjects:(id)arg, ...;

- (void)performSelector:(SEL)aSelector afterDelay:(NSTimeInterval)delay withObject:(id)arg, ...;

+ (NSInvocation *)  invocationWithTarget:(id)target
                    selector            :(SEL)aSelector
                    retainArguments     :(BOOL)retainArguments
                    arguments           :(void *)args, ...;

@end
