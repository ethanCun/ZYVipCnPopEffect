//
//  UINavigationController+Transition.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "UINavigationController+Transition.h"
#import <objc/message.h>

@implementation UINavigationController (Transition)

const char *transitionTypeIdentify = "transitionType";
const char *customTransitionAnimationOpenIdentify = "customTransitionAnimationOpen";

#pragma mark - setter && getter
- (void)setTransitionType:(UINavigationControllerOperation)transitionType
{
    objc_setAssociatedObject(self, &transitionTypeIdentify, @(transitionType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationControllerOperation)transitionType
{
    return (UINavigationControllerOperation)objc_getAssociatedObject(self, &transitionTypeIdentify);
}

- (void)setCustomTransitionAnimationOpen:(BOOL)customTransitionAnimationOpen
{
    objc_setAssociatedObject(self, &customTransitionAnimationOpenIdentify, @(customTransitionAnimationOpen), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (customTransitionAnimationOpen) {
        
        self.delegate = self;

    }else{
        
        self.delegate = nil;
    }
}

- (BOOL)customTransitionAnimationOpen
{
    return objc_getAssociatedObject(self, &customTransitionAnimationOpenIdentify);
}

#pragma mark - hook
+ (void)load
{
    Method method1Push = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    Method method2Push = class_getInstanceMethod(self, @selector(zyPushViewController:animated:));
    
    method_exchangeImplementations(method1Push, method2Push);
}

- (void)zyPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [self zyPushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (self.customTransitionAnimationOpen == NO) {
        
        return nil;
    }
    
    id <UIViewControllerAnimatedTransitioning> animatedTransitioning = [TransitionManager zyTransitionWithType:operation fromVc:fromVC toVc:toVC];
    
    return animatedTransitioning;
}


@end
