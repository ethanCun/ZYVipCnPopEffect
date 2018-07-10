//
//  FloatWindowOperationLayer.h
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


@interface FloatWindowOperationLayer : CALayer

/**
 外圈
 */
@property (nonatomic, strong) CALayer *outerCircle;

/**
 内圈
 */
@property (nonatomic, strong) CALayer *innerCircle;

/**
 线条
 */
@property (nonatomic, strong) CALayer *lineLayer;


/**
 根据浮窗操作类型 创建不同的浮窗提示
 */
- (instancetype)setupFloatWindowOperationLayerWithFloatWindowType:(NSInteger)floatWidowType frame:(CGRect)frame;


@end
