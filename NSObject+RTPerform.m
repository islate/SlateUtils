//
//  NSObject+RTPerform.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "NSObject+RTPerform.h"

@implementation NSObject (RTPerform)

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg1 withObject:(id)arg2 waitUntilDone:(BOOL)wait
{
    [self performSelectorOnMainThread:aSelector waitUntilDone:wait withObjects:arg1, arg2, nil];
}

- (void)performSelectorInBackground:(SEL)aSelector withObject:(id)arg1 withObject:(id)arg2
{
    [self performSelectorInBackground:aSelector withObjects:arg1, arg2, nil];
}

- (void)performSelectorOnMainThread:(SEL)aSelector waitUntilDone:(BOOL)wait withObjects:(id)arg, ...{
    if ([self respondsToSelector:aSelector])
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:aSelector]];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        
        va_list args;
        va_start(args, arg);
        
        NSInteger index = 2;
        
        for (id object = arg; object != nil; object = va_arg(args, id), index++)
        {
            [invocation setArgument:&object atIndex:index];
        }
        
        [invocation retainArguments];
        va_end(args);
        
        [invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
    }
}

- (void)performSelectorInBackground:(SEL)aSelector withObjects:(id)arg, ...{
    if ([self respondsToSelector:aSelector])
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:aSelector]];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        
        va_list args;
        va_start(args, arg);
        
        NSInteger index = 2;
        
        for (id object = arg; object != nil; object = va_arg(args, id), index++)
        {
            [invocation setArgument:&object atIndex:index];
        }
        
        [invocation retainArguments];
        va_end(args);
        
        [invocation performSelectorInBackground:@selector(invoke) withObject:nil];
    }
}

- (void)performSelector:(SEL)aSelector afterDelay:(NSTimeInterval)delay withObject:(id)arg, ...{
    if ([self respondsToSelector:aSelector])
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:aSelector]];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        
        va_list args;
        va_start(args, arg);
        
        NSInteger index = 2;
        
        for (id object = arg; object != nil; object = va_arg(args, id), index++)
        {
            [invocation setArgument:&object atIndex:index];
        }
        
        [invocation retainArguments];
        va_end(args);
        
        [invocation performSelector:@selector(invoke) withObject:nil afterDelay:delay];
    }
}

+ (NSInvocation *)  invocationWithTarget:(id)target
                    selector            :(SEL)aSelector
                    retainArguments     :(BOOL)retainArguments
                    arguments           :(void *)args, ...{
    va_list ap;
    va_start(ap, args);
    NSMethodSignature   *signature = [target methodSignatureForSelector:aSelector];
    NSInvocation        *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    if (retainArguments)
    {
        [invocation retainArguments];
    }
    
    [invocation setTarget:target];
    [invocation setSelector:aSelector];
    
    for (int index = 2; index < [signature numberOfArguments]; index++)
    {
        [invocation setArgument:args atIndex:index];
        args = va_arg(ap, void *);
    }
    
    va_end(ap);
    return invocation;
}

@end
