//
//  FloatWindow.h
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatWindowOperationLayer.h"

typedef NS_ENUM(NSInteger, FloatWindowType)
{
    FloatWindowTypeJoin = 1,
    FloatWindowTypeCancel = 2
};

@interface FloatWindow : UIView

/**
 浮窗背景
 */
@property (nonatomic, strong) CAShapeLayer *floatWindowBgView;

/**
 浮窗当前操作提示
 */
@property (nonatomic, strong) UILabel *floatWindowOperationLab;

/**
 浮窗当前操作提示图层
 */
@property (nonatomic, strong) FloatWindowOperationLayer *floatWindowOperationLayer;

/**
 当前浮窗类型
 */
@property (nonatomic, assign) FloatWindowType floatWindowType;


/**
 背景扩大范围
 */
- (void)expandFloatWindowBgView;

/**
 背景恢复至原来的大小
 */
- (void)resetFloatWindowBgView;

/**
 移除子视图
 */
- (void)removeSubViewsAndSubLayers;

@end
