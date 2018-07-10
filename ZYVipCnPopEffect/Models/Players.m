//
//  Players.m
//  ZYVipCnPopEffect
//
//  Created by chenzhengying on 2018/7/8.
//  Copyright © 2018年 canzoho. All rights reserved.
//

#import "Players.h"

@implementation Players

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"playerInfos" : [PlayerDetail class]};
}

@end


@implementation PlayerDetail

@end
