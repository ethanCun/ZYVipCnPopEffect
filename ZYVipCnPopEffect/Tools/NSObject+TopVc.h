//
//  NSObject+TopVc.h
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/10.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TopVc)

/**
 当前控制器
 */
- (UIViewController *)currentViewController;

/**
 当前导航栏控制器
 */
- (UINavigationController *)currentNavigationController;

/**
 当前标签栏控制器
 */
- (UITabBarController *)currentTabBarController;

@end
