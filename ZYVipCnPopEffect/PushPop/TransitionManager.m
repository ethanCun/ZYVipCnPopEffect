//
//  TransitionManager.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "TransitionManager.h"

@interface TransitionManager ()

/**
 上下文
 */
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> context;

/**
 转场类型
 */
@property (nonatomic, assign) NSInteger transitionType;

/**
 原控制器 目标控制器 起始区域
 */
@property (nonatomic, strong) UIViewController *fromVc;
@property (nonatomic, strong) UIViewController *toVc;
@property (nonatomic, assign) CGRect startRect;

@end

@implementation TransitionManager

#pragma mark - lazy
- (UIView *)transitionBgView
{
    if (!_transitionBgView) {
        
        UIView *transitionBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZYFullWidth, ZYFullHeight)];
        transitionBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [ZYKeyWindow addSubview:transitionBgView];
        
        self.transitionBgView = transitionBgView;
    }
    return _transitionBgView;
}


#pragma mark - Initial
+ (instancetype)zyTransitionWithType:(UINavigationControllerOperation)transitionType fromVc:(UIViewController *)fromVc toVc:(UIViewController *)toVc
{
    return [[self alloc] initWithTransitionType:transitionType fromVc:fromVc toVc:toVc];
}

- (instancetype)initWithTransitionType:(NSInteger)transtionType fromVc:(UIViewController *)fromVc toVc:(UIViewController *)toVc
{
    if (self = [super init]) {
        
        self.transitionType = transtionType;
        self.fromVc = fromVc;
        self.toVc = toVc;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.context = transitionContext;
    
    if (self.transitionType == UINavigationControllerOperationPush) {
        
        //push
        [self push];
        
    }else{
        
        //pop
        [self pop];
    }
}

- (void)push
{
    UIView *containerView = self.context.containerView;
    
    //原控制器与目标控制器
    UIViewController *fromVc = [self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //添加原控制器视图之后添加目标控制器视图
    [containerView addSubview:fromVc.view];
    [containerView addSubview:toVc.view];
    
    [fromVc.view addSubview:self.transitionBgView];
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:[TipCircleManager shared].tipCircle.frame cornerRadius:30];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset([TipCircleManager shared].tipCircle.frame, -ZYFullHeight/2, -ZYFullHeight/2) cornerRadius:40];
    
    //添加一个layer的蒙层到目标控制器上
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor redColor].CGColor;
    toVc.view.layer.mask = maskLayer;
    maskLayer.path = endPath.CGPath;

    //添加push动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    pathAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    pathAnimation.duration = [self transitionDuration:self.context];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    pathAnimation.delegate = self;
    
    [maskLayer addAnimation:pathAnimation forKey:@"show"];
}

- (void)pop
{
    UIView *containerView = self.context.containerView;
    
    //原控制器与目标控制器
    UIViewController *fromVc = [self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [toVc.view addSubview:self.transitionBgView];

    //添加原控制器视图之后添加目标控制器视图
    [containerView addSubview:toVc.view];
    [containerView addSubview:fromVc.view];
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset([TipCircleManager shared].tipCircle.frame, -ZYFullHeight/2, -ZYFullHeight/2) cornerRadius:40];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:[TipCircleManager shared].tipCircle.frame cornerRadius:[TipCircleManager shared].tipCircle.frame.size.width/2];

    //添加一个layer的蒙层到目标控制器上
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor redColor].CGColor;
    maskLayer.path = endPath.CGPath;
    fromVc.view.layer.mask = maskLayer;

    //添加push动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = [self transitionDuration:self.context];
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [maskLayer addAnimation:animation forKey:@"pop"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.context completeTransition:YES];
    
    [self.context viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    [self.context viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    
    if (self.transitionBgView) {

        [UIView animateWithDuration:0.5 animations:^{
            
            self.transitionBgView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [self.transitionBgView removeFromSuperview];
            self.transitionBgView = nil;
        }];
    }
}



@end
