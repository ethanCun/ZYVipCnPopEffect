//
//  SecondViewController.h
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

/**
 球员模型
 */
@property (nonatomic, strong) PlayerDetail *player;

/**
 pop完成
 */
@property (nonatomic, copy) void (^finishPop)(void);

@end
