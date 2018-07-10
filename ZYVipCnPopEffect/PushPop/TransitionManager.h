//
//  TransitionManager.h
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionManager : NSObject<UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

/**
 转场背景
 */
@property (nonatomic, strong) UIView *transitionBgView;


/**
 根据操作类型进行转场动画
 */
+ (instancetype)zyTransitionWithType:(UINavigationControllerOperation)transitionType fromVc:(UIViewController *)fromVc toVc:(UIViewController *)toVc;

@end
