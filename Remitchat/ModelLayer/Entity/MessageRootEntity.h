//
//  MessageRootEntity.h
//  Remitchat
//
//  Created by CC on 15/8/24.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import "BaseEntity.h"

@interface MessageRootEntity : BaseEntity

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detailed;
@property (nonatomic, strong) NSString *sendTime;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign) CCMessageType type;

@end
