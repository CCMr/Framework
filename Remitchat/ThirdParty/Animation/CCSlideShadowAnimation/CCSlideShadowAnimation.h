//
//  CCSlideShadowAnimation.h
//  Remitchat
//
//  Created by CC on 15/8/20.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCSlideShadowAnimation : NSObject

@property (weak, nonatomic) UIView *animatedView;

@property (strong, nonatomic) UIColor *shadowBackgroundColor;
@property (strong, nonatomic) UIColor *shadowForegroundColor;
@property (assign, nonatomic) CGFloat shadowWidth;
@property (assign, nonatomic) CGFloat repeatCount;
/**
 *  @author CC, 15-08-20
 *
 *  @brief  动画速度（数值越小越快）
 *
 *  @since 1.0
 */
@property (assign, nonatomic) NSTimeInterval duration;

/**
 *  @author CC, 15-08-20
 *
 *  @brief  启动函数
 *
 *  @since <#1.0#>
 */
- (void)start;

/**
 *  @author CC, 15-08-20
 *
 *  @brief  停止函数
 *
 *  @since <#1.0#>
 */
- (void)stop;

@end
