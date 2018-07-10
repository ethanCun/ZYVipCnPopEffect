//
//  ViewController.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "Players.h"

@interface ViewController ()

@property (nonatomic, strong) Players *players;


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    [[TipCircleManager shared] setupTipCircleViewInViewController:self];
    
    //获取本地数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Property List.plist" ofType:nil];
    NSDictionary *info = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.players = [Players yy_modelWithJSON:info];

    
    [TipCircleManager shared].clickTipCircle = ^{
        
        SecondViewController *secondVc = [[SecondViewController alloc] init];
        self.navigationController.transitionType = 1;
        secondVc.player = [TipCircleManager shared].tipCircle.player;
        self.navigationController.customTransitionAnimationOpen = YES;
        [self.navigationController pushViewController:secondVc animated:YES];
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.playerInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusedId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedId];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [cell.contentView addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.players.playerInfos[indexPath.row] icon]]];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10+CGRectGetMaxX(imageView.frame), 10, ZYFullWidth-10-CGRectGetMaxX(imageView.frame), 20)];
    [cell.contentView addSubview:nameLab];
    nameLab.text = self.players.playerInfos[indexPath.row].name;
    
    UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(10+CGRectGetMaxX(imageView.frame), 10+CGRectGetMaxY(nameLab.frame), ZYFullWidth-10-CGRectGetMaxX(imageView.frame), 20)];
    [cell.contentView addSubview:detailLab];
    detailLab.text = self.players.playerInfos[indexPath.row].detail;
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:@(YES)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController *secondVc = [SecondViewController new];
    secondVc.player = self.players.playerInfos[indexPath.row];
    self.navigationController.customTransitionAnimationOpen = NO;
    [self.navigationController pushViewController:secondVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

@end
