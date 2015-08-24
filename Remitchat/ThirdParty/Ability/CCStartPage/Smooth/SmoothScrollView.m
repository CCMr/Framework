//
//  SmoothScrollView.m
//  Remitchat
//
//  Created by CC on 15/8/21.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import "SmoothScrollView.h"

@implementation SmoothScrollView

-(id)init
{
    if(self = [super init]){
        [self viewPrepare];
    }

    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self viewPrepare];
    }
    return self;
}

-(void)viewPrepare
{
    //开启分页
    self.pagingEnabled = YES;

    //隐藏各种条
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;

    //取消boundce
    self.bounces = NO;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    __block CGRect frame = self.bounds;
    __block NSUInteger count = 0;

    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop)
    {
        if([subView isKindOfClass:[UIImageView class]])
        {
            CGFloat frameX = frame.size.width * idx;
            frame.origin.x = frameX;
            subView.frame = frame;
            count ++;
        }
    }];

    self.contentSize = CGSizeMake(frame.size.width * count, 0);
}

@end
