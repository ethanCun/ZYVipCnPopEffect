//
//  FloatWindow.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "FloatWindow.h"


@interface FloatWindow ()

@end

@implementation FloatWindow

#pragma mark - 设置浮窗类型
- (void)setFloatWindowType:(FloatWindowType)floatWindowType
{
    _floatWindowType = floatWindowType;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer) withObject:nil];
 
    if (floatWindowType == FloatWindowTypeCancel) {
        
        [self setupFloatWindowWithFloatWindowType:FloatWindowTypeCancel];
        
        self.floatWindowBgView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.6].CGColor;
        self.floatWindowOperationLab.text = @"取消浮窗";
        
    }else{
        
        [self setupFloatWindowWithFloatWindowType:FloatWindowTypeJoin];
        
        self.floatWindowBgView.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
        self.floatWindowOperationLab.text = @"浮窗";
    }
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupFloatWindowWithFloatWindowType:FloatWindowTypeJoin];
    }
    return self;
}

- (void)setupFloatWindowWithFloatWindowType:(FloatWindowType)floatWindowType
{
    //浮窗背景
    self.floatWindowBgView = [CAShapeLayer layer];
    self.floatWindowBgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.floatWindowBgView.fillColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.floatWindowBgView];
    
    [self resetFloatWindowBgView];
    
    //浮窗提示图层
    self.floatWindowOperationLayer = [[[FloatWindowOperationLayer alloc] init] setupFloatWindowOperationLayerWithFloatWindowType:floatWindowType frame:CGRectMake(FloatWindowRadius/2-40/2, FloatWindowRadius/2-40/2, 40, 40)];
    [self.floatWindowBgView addSublayer:self.floatWindowOperationLayer];
        
    //浮窗提示文字
    self.floatWindowOperationLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-50, FloatWindowRadius, 20)];
    self.floatWindowOperationLab.textAlignment = NSTextAlignmentCenter;
    self.floatWindowOperationLab.text = @"取消浮窗";
    self.floatWindowOperationLab.textColor = [UIColor whiteColor];
    self.floatWindowOperationLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.floatWindowOperationLab];
}

#pragma mark - 背景动画
- (void)expandFloatWindowBgView
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(FloatWindowRadius, FloatWindowRadius)];
    [path addLineToPoint:CGPointMake(0, FloatWindowRadius)];
    [path addArcWithCenter:CGPointMake(FloatWindowRadius, FloatWindowRadius) radius:FloatWindowRadius+20 startAngle:-M_PI endAngle:-1.5*M_PI clockwise:YES];
    [path stroke];
    
    [UIView animateWithDuration:1.0f animations:^{
        
        self.floatWindowBgView.path = path.CGPath;
    }];
}

- (void)resetFloatWindowBgView
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(FloatWindowRadius, FloatWindowRadius)];
    [path addLineToPoint:CGPointMake(0, FloatWindowRadius)];
    [path addArcWithCenter:CGPointMake(FloatWindowRadius, FloatWindowRadius) radius:FloatWindowRadius startAngle:-M_PI endAngle:-1.5*M_PI clockwise:YES];
    [path stroke];
    self.floatWindowBgView.path = path.CGPath;
    
    [UIView animateWithDuration:1.0f animations:^{
        
        self.floatWindowBgView.path = path.CGPath;
    }];
}

- (void)removeSubViewsAndSubLayers
{
    [self.floatWindowBgView removeFromSuperlayer];
    [self.floatWindowOperationLayer removeFromSuperlayer];
    [self.floatWindowOperationLab removeFromSuperview];
    
    self.floatWindowOperationLab = nil;
    self.floatWindowBgView = nil;
    self.floatWindowOperationLayer = nil;
}

@end
