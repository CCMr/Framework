//
//  CCRourRotation.h
//  Remitchat
//
//  Created by CC on 15/8/31.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCRourRotation : UIView

/**
 *  @author CC, 15-08-31
 *
 *  @brief  设置微调的圆的线宽
 *
 *  @since <#1.0#>
 */
@property (nonatomic) CGFloat lineWidth;

/**
 *  @author CC, 15-08-31
 *
 *  @brief  设置动画是否隐藏
 *
 *  @since <#1.0#>
 */
@property (nonatomic) BOOL hidesWhenStopped;

/**
 *  @author CC, 15-08-31
 *
 *  @brief  指定定时功能用于控制的动画。默认为kCAMediaTimingFunctionEaseInEaseOut
 *
 *  @since <#1.0#>
 */
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;

/** Property indicating whether the view is currently animating. */
@property (nonatomic, readonly) BOOL isAnimating;

/**
 *  Convenience function for starting & stopping animation with a boolean variable instead of explicit
 *  method calls.
 *
 *  @param animate true to start animating, false to stop animating.
 @note This method simply calls the startAnimating or stopAnimating methods based on the value of the animate parameter.
 */
- (void)setAnimating:(BOOL)animate;

/**
 *  Starts animation of the spinner.
 */
- (void)startAnimating;

/**
 *  Stops animation of the spinnner.
 */
- (void)stopAnimating;


@end
