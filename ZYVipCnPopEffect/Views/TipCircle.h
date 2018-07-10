//
//  TipCircle.h
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatWindow.h"
#import "Players.h"

@protocol TipCircleDelegate<NSObject>

//开始拖动
- (void)tipCircleDidStartMoveToPoint:(CGPoint)point;

//结束拖动
- (void)tipCircleDidEndMoveToPoint:(CGPoint)point;

//取消拖动
- (void)tipCircleDidCancelMoveToPoint:(CGPoint)point;

//正在拖动
- (void)tipCircleDidMovingToPoint:(CGPoint)point;

//点击
- (void)tipCircleDidSingleClick;

@end

@interface TipCircle : UIView

/**
 代理对象
 */
@property (nonatomic, strong) id<TipCircleDelegate> delegate;

/**
 缩略图 网络url
 */
@property (nonatomic, copy) NSString *circleImageUrl;

/**
 缩略图 本地图片名
 */
@property (nonatomic, copy) NSString *circleImageName;

/**
 浮窗图层
 */
@property (nonatomic, strong) FloatWindow *floatWindow;

/**
 当前浮窗显示的球员信息模型
 */
@property (nonatomic, strong) PlayerDetail *player;


@end
