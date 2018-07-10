//
//  Players.h
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PlayerDetail;

@interface Players : NSObject

/**
 所有球员信息
 */
@property (nonatomic, strong) NSArray <PlayerDetail *> *playerInfos;


@end


@interface PlayerDetail : NSObject

/**
 头像
 */
@property (nonatomic, copy) NSString *icon;

/**
 名称
 */
@property (nonatomic, copy) NSString *name;

/**
 详情
 */
@property (nonatomic, copy) NSString *detail;

/**
 是否更新模型信息
 */
@property (nonatomic, assign) BOOL wetherUpdateModelInfo;


@end


