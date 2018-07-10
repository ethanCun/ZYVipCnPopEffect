//
//  TipCircle.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "TipCircle.h"

#define circleEdgeMargin 10

@interface TipCircle ()

/**
 缩略图图片
 */
@property (nonatomic, strong) UIImageView *tipImageView;

@end

@implementation TipCircle

#pragma mark - setter && getter
- (void)setCircleImageUrl:(NSString *)circleImageUrl
{
    _circleImageUrl = circleImageUrl;
    
    [self.tipImageView sd_setImageWithURL:[NSURL URLWithString:circleImageUrl]];
}

- (void)setCircleImageName:(NSString *)circleImageName
{
    _circleImageName = circleImageName;
    
    self.tipImageView.image = [UIImage imageNamed:circleImageName];
}

- (void)setPlayer:(PlayerDetail *)player
{
    _player = player;
    
    if (self.player.wetherUpdateModelInfo == NO) {
        
        return;
    }
    
    [self.tipImageView sd_setImageWithURL:[NSURL URLWithString:player.icon]];
}

- (UIImageView *)tipImageView
{
    if (!_tipImageView) {
        
        UIImageView *tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-10)];
        tipImageView.layer.cornerRadius = CGRectGetWidth(tipImageView.frame)/2;
        tipImageView.layer.masksToBounds = YES;
        tipImageView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        
        _tipImageView = tipImageView;
    }
    return _tipImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupTipCircleView];
    }
    return self;
}

- (void)setupTipCircleView
{
    self.layer.cornerRadius = CGRectGetWidth(self.frame)/2;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [self addSubview:self.tipImageView];
    
    //单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:tap];
    
    self.tipImageView.userInteractionEnabled = YES;
}

#pragma mark - 单击手势
- (void)singleTap:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(tipCircleDidSingleClick)]) {
        
        [self.delegate tipCircleDidSingleClick];
    }
}

#pragma mark - Touch事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(tipCircleDidStartMoveToPoint:)]) {
        
        UITouch *touch = touches.anyObject;
        
        [self.delegate tipCircleDidStartMoveToPoint:[touch locationInView:ZYKeyWindow]];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(tipCircleDidEndMoveToPoint:)]) {
        
        UITouch *touch = touches.anyObject;
        
        [self.delegate tipCircleDidEndMoveToPoint:[touch locationInView:ZYKeyWindow]];
    }
    
    CGPoint touchPoint = [touches.anyObject locationInView:ZYKeyWindow];
    
    [self resetTipCircleLocationWithPoint:touchPoint];
    
    [self removeFloatWindowLayer];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(tipCircleDidMovingToPoint:)]) {
        
        UITouch *touch = touches.anyObject;

        [self.delegate tipCircleDidMovingToPoint:[touch locationInView:ZYKeyWindow]];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.center = [touches.anyObject locationInView:ZYKeyWindow];
    }];
    
    [self setupFloatWindowLayer];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(tipCircleDidCancelMoveToPoint:)]) {
        
        UITouch *touch = touches.anyObject;

        [self.delegate tipCircleDidCancelMoveToPoint:[touch locationInView:ZYKeyWindow]];
    }
    
    CGPoint touchPoint = [touches.anyObject locationInView:ZYKeyWindow];
    
    [self resetTipCircleLocationWithPoint:touchPoint];
    
    [self removeFloatWindowLayer];
}


#pragma mark - 重新设置省略图的位置
- (void)resetTipCircleLocationWithPoint:(CGPoint)touchPoint
{
    //弹性
    if (touchPoint.x < ZYFullWidth/2) {
        
        touchPoint.x = ZYCommonMargin+CGRectGetWidth(self.frame)/2;
    }else{
        
        touchPoint.x = ZYFullWidth-ZYCommonMargin-CGRectGetWidth(self.frame)/2;
    }
    
    //上下不能超出边界
    if (touchPoint.y < 10 + CGRectGetWidth(self.frame)/2) {
        
        touchPoint.y = 10 + CGRectGetWidth(self.frame)/2;
    }
    if (touchPoint.y > ZYFullHeight - (10 + CGRectGetWidth(self.frame)/2)){
        
        touchPoint.y = ZYFullHeight - (10 + CGRectGetWidth(self.frame)/2);
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.center = touchPoint;
    }];
}


#pragma mark - 浮窗
- (void)setupFloatWindowLayer
{
    if (self.floatWindow) {
        return;
    }
    
    self.floatWindow = [[FloatWindow alloc] initWithFrame:CGRectMake(ZYFullWidth-FloatWindowRadius, ZYFullHeight-FloatWindowRadius, FloatWindowRadius, FloatWindowRadius)];
    
    [ZYKeyWindow insertSubview:self.floatWindow belowSubview:self];
}


#pragma mark - 移除浮窗
- (void)removeFloatWindowLayer
{
    [self.floatWindow removeSubViewsAndSubLayers];
    [self.floatWindow removeFromSuperview];
    self.floatWindow = nil;
}


@end






