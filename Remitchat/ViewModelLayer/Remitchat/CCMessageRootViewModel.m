//
//  CCMessageRootViewModel.m
//  Remitchat
//
//  Created by CC on 15/8/24.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import "CCMessageRootViewModel.h"
#import "MessageRootEntity.h"

@implementation CCMessageRootViewModel

- (void)fetchDataSource
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        MessageRootEntity *entity = [[MessageRootEntity alloc] init];
        entity.avatar = @"";
        entity.title = [NSString stringWithFormat:@"CC%d",i];
        entity.detailed = @"点击我查看最新消息，里面有惊喜哦！点击我查看最新消息，里面有惊喜哦！点击我查看最新消息，里面有惊喜哦！点击我查看最新消息，里面有惊喜哦！";
        entity.sendTime = [[NSDate date] toStringFormat:@"yy/MM/dd"];
        entity.status = @"";
        entity.type = i % 2 ? CCMessageTypeHaveread : CCMessageTypeUnread;
        [array addObject:entity];
    }
    self.returnBlock(array);
}

@end
