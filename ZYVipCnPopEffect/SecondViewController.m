//
//  SecondViewController.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/9.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

/**
 球员名称
 */
@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *playerName;

/**
 球员详情
 */
@property (weak, nonatomic) IBOutlet UILabel *playerDetailLab;


@end

@implementation SecondViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.finishPop) {
        
        self.finishPop();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.playerImageView sd_setImageWithURL:[NSURL URLWithString:self.player.icon]];
    self.playerName.text = self.player.name;
    self.playerDetailLab.text = self.player.detail;
    
    [self.view.subviews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:@(YES)];
    
    self.player.wetherUpdateModelInfo = NO;
    [TipCircleManager shared].player = self.player;
}


@end
