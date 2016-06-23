//
//  UIView+onscreen.m
//  SlateCore
//
//  Created by linyize on 16/5/27.
//  Copyright © 2016年 islate. All rights reserved.
//

#import "UIView+onscreen.h"

@implementation UIView (onScreen)

// 判断View是否显示在屏幕上
- (BOOL)onScreen
{
    if (self.window == nil || self.superview == nil)
    {
        return NO;
    }
    
    // 判断view是否在当前window范围内显示(phone 会上下多算一段距离)
    CGRect viewFrame = [self.window convertRect:self.frame fromView:self.superview];
    CGRect screenFrame = self.window.bounds;
    CGRect intersectionRect = CGRectIntersection(viewFrame, screenFrame);
    if (!CGRectIntersectsRect(viewFrame, screenFrame))
    {
        //NSLog(@"is not on screen");
        return NO;
    }
    
    // 判断view是否在hitTest路径上（没有被其他视图挡住）
    CGPoint point = CGPointMake(CGRectGetMidX(intersectionRect), CGRectGetMidY(intersectionRect));
    UIView *hitTestResult = [self.window hitTest:point withEvent:nil];
    if (hitTestResult == self || [hitTestResult isDescendantOfView:self] || [self isDescendantOfView:hitTestResult])
    {
        //        ALog(@"on %f,%f %@ %@",point.x,point.y,self,hitTestResult);
        return YES;
    }
    
    //ALog(@"not %f,%f %@ %@",point.x,point.y,hitTestResult);
    return NO;
}

@end
