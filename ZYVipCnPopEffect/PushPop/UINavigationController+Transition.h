//
//  UINavigationController+Transition.h
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UINavigationController (Transition)<UINavigationControllerDelegate>

/**
 界面转换类型
 */
@property (nonatomic, assign) UINavigationControllerOperation transitionType;

/**
 是否使用自定义转场动画
 */
@property (nonatomic, assign) BOOL customTransitionAnimationOpen;



@end
