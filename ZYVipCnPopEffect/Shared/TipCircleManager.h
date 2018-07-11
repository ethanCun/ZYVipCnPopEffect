//
//  TipCircleManager.h
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Players.h"

@interface TipCircleManager : NSObject<TipCircleDelegate, UIGestureRecognizerDelegate>

/**
 缩略功能图
 */
@property (nonatomic, strong) TipCircle *tipCircle;

/**
 球员信息模型
 */
@property (nonatomic, strong) PlayerDetail *player;

/**
 浮窗
 */
@property (nonatomic, strong) FloatWindow *floatWindow;

/**
 点击浮窗跳转的时候是否显示省略图
 */
@property (nonatomic, assign) BOOL wetherShowTipcircle;


/**
 单击省略图
 */
@property (nonatomic, copy) void (^clickTipCircle)(void);

/**
 实例化
 */
- (void)setupTipCircleViewInViewController:(UIViewController *)viewController;

/**
 实例对象
 */
+ (instancetype)shared;



@end
