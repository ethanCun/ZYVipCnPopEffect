//
//  AppDelegate.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    return YES;
}



@end
