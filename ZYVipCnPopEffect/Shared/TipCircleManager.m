//
//  TipCircleManager.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "TipCircleManager.h"
#import "SecondViewController.h"

#define TipCircleDefaultSize CGSizeMake(60, 60)

@interface TipCircleManager ()

/**
 导航栏边缘手势
 */
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePan;

/**
 添加一个定时器 滑动的时候获取每帧的位移
 */
@property (nonatomic, strong) CADisplayLink *link;


@end

@implementation TipCircleManager

static TipCircleManager *manager = nil;

#pragma mark - shared
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[TipCircleManager alloc] init];
        
        //返回手势回调
        [manager currentNavigationController].interactivePopGestureRecognizer.delegate = manager;
    });
    return manager;
}

- (CADisplayLink *)link
{
    if (!_link) {
        
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(panMoved:)];
    }
    return _link;
}

- (void)deallocLink
{
    [self.link invalidate];
    self.link = nil;
}


#pragma mark - setup
- (void)setupTipCircleViewInViewController:(UIViewController *)viewController
{
    self.tipCircle = [[TipCircle alloc] initWithFrame:CGRectMake(ZYFullWidth-ZYCommonMargin-TipCircleDefaultSize.width, ZYFullHeight/2-TipCircleDefaultSize.height/2, TipCircleDefaultSize.width, TipCircleDefaultSize.height)];
    
    self.tipCircle.delegate = self;
    
    //默认影藏
    self.tipCircle.hidden = YES;
    
    [ZYKeyWindow addSubview:self.tipCircle];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //获取边缘滑动手势
    self.edgePan = (UIScreenEdgePanGestureRecognizer *)gestureRecognizer;
    
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    return YES;
}

#pragma mark - 导航栏手势拖动
- (void)panMoved:(CADisplayLink *)link
{
    //显示导航栏
    [manager currentNavigationController].navigationBar.hidden = NO;
    
    CGPoint point = CGPointZero;
    
    if (self.edgePan.state == UIGestureRecognizerStateBegan) {
        
        
    }else if (self.edgePan.state == UIGestureRecognizerStateChanged){
        
        //当前移动移动的距离
        point = [self.edgePan translationInView:[manager currentViewController].view];
        
        //添加浮窗
        [self setupFloatWindowLayer];
        
        //超过1/3将浮窗显示出来 1/3至2/3之间由0显示到（FloatWindowRadius）150
        CGFloat transitionX = fabs(point.x);
        
        if (transitionX < ZYFullWidth/3) {
            
            self.floatWindow.frame = CGRectMake(ZYFullWidth-FloatWindowRadius, ZYFullHeight-transitionX+20, FloatWindowRadius, FloatWindowRadius);
        }else{
            
            self.floatWindow.frame = CGRectMake(ZYFullWidth-FloatWindowRadius, ZYFullHeight-FloatWindowRadius, FloatWindowRadius, FloatWindowRadius);
        }

        
    }else if (self.edgePan.state == UIGestureRecognizerStateEnded){
        
        [self deallocLink];
        [self removeFloatWindowLayer];
        
    }else if (self.edgePan.state == UIGestureRecognizerStateFailed){
        
        [self deallocLink];
        [self removeFloatWindowLayer];

    }else if (self.edgePan.state == UIGestureRecognizerStateCancelled){
        
        [self deallocLink];
        [self removeFloatWindowLayer];
        
    }else if (self.edgePan.state == UIGestureRecognizerStatePossible){
        
        //当前在窗口中的位置
        CGPoint locationInKeyWindow = [self.edgePan locationInView:ZYKeyWindow];
        
        //判断当前滑动点是否移入添加缩略图的区域：点到圆心的距离<=半径
        CGFloat distance = sqrt(pow(locationInKeyWindow.x-ZYFullWidth, 2)+pow(locationInKeyWindow.y-ZYFullHeight, 2));
        
        //如果影藏了就判断逻辑
        if (self.tipCircle.hidden == YES) {
            

        }
        
        if (distance <= FloatWindowRadius) {
            
            self.tipCircle.hidden = NO;
            self.tipCircle.frame = CGRectMake(ZYFullWidth-ZYCommonMargin-TipCircleDefaultSize.width, ZYFullHeight/2-TipCircleDefaultSize.height/2, TipCircleDefaultSize.width, TipCircleDefaultSize.height);
            
            //滑动的时候要求更新模型
            self.player.wetherUpdateModelInfo = YES;
            self.tipCircle.player = self.player;
            
        }else{
            
            self.tipCircle.hidden = YES;
        }
        
        [self deallocLink];
        [self removeFloatWindowLayer];
    }
}

#pragma mark - 浮窗
- (void)setupFloatWindowLayer
{
    if (self.floatWindow) {
        return;
    }
    
    self.floatWindow = [[FloatWindow alloc] initWithFrame:CGRectMake(ZYFullWidth-FloatWindowRadius, ZYFullHeight-FloatWindowRadius, FloatWindowRadius, FloatWindowRadius)];
    self.floatWindow.floatWindowType = FloatWindowTypeJoin;
    [ZYKeyWindow addSubview:self.floatWindow];
    [ZYKeyWindow bringSubviewToFront:self.floatWindow];
}


#pragma mark - 移除浮窗
- (void)removeFloatWindowLayer
{
    [self.floatWindow removeSubViewsAndSubLayers];
    [self.floatWindow removeFromSuperview];
    self.floatWindow = nil;
}

#pragma mark - TipCircleDelegate
- (void)tipCircleDidSingleClick
{
    if (self.clickTipCircle) {
        
        self.clickTipCircle();
    }
}

- (void)tipCircleDidStartMoveToPoint:(CGPoint)point
{
    [self adjustFloatWindowWithPoint:point];
}

- (void)tipCircleDidMovingToPoint:(CGPoint)point
{
    [self adjustFloatWindowWithPoint:point];
}

- (void)tipCircleDidEndMoveToPoint:(CGPoint)point
{
    [self adjustFloatWindowWithPoint:point];
    
    //松手的时候判断是否在圆圈内
    if ([self judgeWetherTipCircleAddToFloatWindowOfCurentPoint:point]) {
        
        self.tipCircle.hidden = YES;
    }else{
        
        self.tipCircle.hidden = NO;
    }
}

- (void)tipCircleDidCancelMoveToPoint:(CGPoint)point
{
    [self adjustFloatWindowWithPoint:point];
}


#pragma mark - 判断缩略图是否移入浮窗之中
- (BOOL)judgeWetherTipCircleAddToFloatWindowOfCurentPoint:(CGPoint)point
{
    //点到圆心的距离 <= 半径
    CGFloat distance = sqrt(pow(point.x-ZYFullWidth, 2)+pow(point.y-ZYFullHeight, 2));
    
    if (distance <= FloatWindowRadius) {
        
        return YES;
    }
    
    return NO;
}

#pragma mark - 调整浮窗动画
- (void)adjustFloatWindowWithPoint:(CGPoint)point
{
    self.tipCircle.floatWindow.floatWindowType = FloatWindowTypeCancel;
    
    if ([self judgeWetherTipCircleAddToFloatWindowOfCurentPoint:point]) {
        
        [self.tipCircle.floatWindow expandFloatWindowBgView];
        
    }else{
        
        [self.tipCircle.floatWindow resetFloatWindowBgView];
    }
}




@end
