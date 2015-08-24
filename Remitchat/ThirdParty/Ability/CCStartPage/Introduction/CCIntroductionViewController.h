//
//  CCIntroductionViewController.h
//  Remitchat
//
//  Created by CC on 15/8/17.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCIntroductionViewController : UIViewController

/**
 *  @author CC, 15-08-17
 *
 *  @brief  背景图片
 *
 *  @since 1.0
 */
@property (nonatomic, strong) NSArray *backgroundImageNames;

/**
 *  @author CC, 15-08-17
 *
 *  @brief  简介图片
 *
 *  @since 1.0
 */
@property (nonatomic, strong) NSArray *coverImageNames;

/**
 *  @author CC, 15-08-17
 *
 *  @brief  初始化控件
 *
 *  @param coverNames 简介图片数组
 *  @param bgNames    背景图片数组
 *
 *  @return 返回当前控件
 *
 *  @since 1.0
 */
- (id)initWithCoverImageNames: (NSArray *)coverNames
         backgroundImageNames: (NSArray *)bgNames;

/**
 *  @author CC, 15-08-17
 *
 *  @brief  初始化控件
 *
 *  @param coverNames 简介图片数组
 *  @param bgNames    背景图片数组
 *  @param button     完成按钮
 *
 *  @return 返回当前控件
 *
 *  @since 1.0
 */
- (id)initWithCoverImageNames: (NSArray *)coverNames
         backgroundImageNames: (NSArray *)bgNames
                       button: (UIButton *)button;

@property (nonatomic, copy) Completion didSelectedEnter;

/**
 *  @author CC, 15-08-17
 *
 *  @brief  完成回调
 *
 *  @param enterBlock 返回回调block
 *
 *  @since 1.0
 */
- (void)didSelectedEnter:(Completion)enterBlock;

@end
