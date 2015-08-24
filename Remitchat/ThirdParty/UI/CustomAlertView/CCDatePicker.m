//
//  CCDatePicker.m
//  Remitchat
//
//  Created by CC on 14-10-29.
//  Copyright (c) 2014年 IFLY. All rights reserved.
//

#import "CCDatePicker.h"

@implementation CCDatePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        NSDate *localeDate = [self getLocale];
//        [self setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
//        // 设置当前显示
//        [self setDate:localeDate animated:YES];
//        // 设置显示最大时间（
//        [self setMinimumDate:localeDate];
//        // 显示模式
//        [self setDatePickerMode:UIDatePickerModeDateAndTime];
        [self setMinimumDate:[NSDate date]];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(NSDate *)getLocale{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return [date  dateByAddingTimeInterval: interval];
}

@end
