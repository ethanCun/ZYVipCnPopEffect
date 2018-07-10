//
//  FloatWindowOperationLayer.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "FloatWindowOperationLayer.h"



@implementation FloatWindowOperationLayer

- (instancetype)setupFloatWindowOperationLayerWithFloatWindowType:(NSInteger)floatWidowType frame:(CGRect)frame
{
    if (self == [super init]) {
    
        CAShapeLayer *circle1 = [CAShapeLayer layer];
        CAShapeLayer *circle2 = [CAShapeLayer layer];
        CAShapeLayer *line = [CAShapeLayer layer];
        
        self.outerCircle = circle1;
        self.innerCircle = circle2;
        self.lineLayer = line;

        UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(FloatWindowRadius/2, FloatWindowRadius/2) radius:CirCle1Width startAngle:0 endAngle:2*M_PI clockwise:YES];
        circle1.fillColor = [UIColor clearColor].CGColor;
        circle1.lineWidth = CircleLineWidth;
        circle1.strokeColor = [UIColor whiteColor].CGColor;
        circle1.lineJoin = kCALineCapRound;
        circle1.path = path1.CGPath;
        
        UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(FloatWindowRadius/2, FloatWindowRadius/2) radius:Circle2Width startAngle:0 endAngle:2*M_PI clockwise:YES];
        circle2.fillColor = [UIColor clearColor].CGColor;
        circle2.lineWidth = CircleLineWidth;
        circle2.strokeColor = [UIColor whiteColor].CGColor;
        circle2.lineJoin = kCALineCapRound;
        circle2.path = path2.CGPath;
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(FloatWindowRadius/2-18, FloatWindowRadius/2-18)];
        [linePath addLineToPoint:CGPointMake(FloatWindowRadius/2+18, FloatWindowRadius/2+18)];
        
        line.frame = CGRectMake(0, 0, 10, 10);
        line.strokeColor = [UIColor whiteColor].CGColor;
        line.lineWidth = LineWidth;
        line.path = linePath.CGPath;

        if (floatWidowType == 1) {
            
            [self addSublayer:circle1];
            [self addSublayer:circle2];
            
        }else{
            
            [self addSublayer:circle1];
            [self addSublayer:circle2];
            [self addSublayer:line];
        }
    }
    return self;
}



@end
