//
//  SmoothViewController.h
//  Remitchat
//
//  Created by CC on 15/8/21.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmoothViewController : UIViewController

/**
 *  @author CC, 15-08-21
 *
 *  @brief  引导页图片
 *
 *  @since 1.0
 */
@property (nonatomic, strong) NSArray *images;

@property (nonatomic, copy) Completion didSelectedEnter;

/**
 *  @author CC, 15-08-17
 *
 *  @brief  初始化控件
 *
 *  @param bgNames    背景图片数组
 *
 *  @return 返回当前控件
 *
 *  @since 1.0
 */
- (id) initWithCoverImageNames: (NSArray *)bgNames;

/**
 *  @author CC, 15-08-17
 *
 *  @brief  初始化控件
 *
 *  @param bgNames    背景图片数组
 *  @param button     完成按钮
 *
 *  @return 返回当前控件
 *
 *  @since 1.0
 */
- (id) initWithCoverImageNames: (NSArray *)bgNames
                       button: (UIButton *)button;

/**
 *  @author CC, 15-08-17
 *
 *  @brief  完成回调
 *
 *  @param enterBlock 返回回调block
 *
 *  @since 1.0
 */
- (void) didSelectedEnter:(Completion)enterBlock;

/**
 *  @author CC, 15-08-21
 *
 *  @brief  是否显示
 *
 *  @return return value description
 *
 *  @since <#1.0#>
 */
+ (BOOL) canShowNewFeature;

@end
