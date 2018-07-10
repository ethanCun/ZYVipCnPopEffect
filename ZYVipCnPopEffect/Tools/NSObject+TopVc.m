//
//  NSObject+TopVc.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/10.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "NSObject+TopVc.h"

@implementation NSObject (TopVc)

- (UIViewController *)currentViewController
{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (true)
    {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

- (UINavigationController *)currentNavigationController
{
    return [self currentViewController].navigationController;
}

- (UITabBarController *)currentTabBarController
{
    return [self currentViewController].tabBarController;
}


@end
