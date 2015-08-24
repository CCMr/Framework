//
//  CCConfigurationHelper.m
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "CCConfigurationHelper.h"

@interface CCConfigurationHelper ()

@property (nonatomic, strong) NSArray *popMenuTitles;

@end


@implementation CCConfigurationHelper

+ (instancetype)appearance {
    static CCConfigurationHelper *configurationHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configurationHelper = [[CCConfigurationHelper alloc] init];
    });
    return configurationHelper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.popMenuTitles = @[CCLocalization(@"复制文本消息"),
                               CCLocalization(@"转发"),
                               CCLocalization(@"收藏"),
                               CCLocalization(@"更多"),];
    }
    return self;
}

- (void)setupPopMenuTitles:(NSArray *)popMenuTitles {
    self.popMenuTitles = popMenuTitles;
}


@end
