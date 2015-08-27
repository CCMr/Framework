//
//  UIImage+Data.h
//  Remitchat
//
//  Created by CC on 15/8/27.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Data)

/**
 *  @author CC, 15-08-27
 *
 *  @brief  Image转data
 *
 *  @return 返回ImageData
 *
 *  @since 1.0
 */
- (NSData *)data;

/**
 *  @author CC, 15-08-27
 *
 *  @brief  Image转base64位字符串
 *
 *  @return 返回Image字符串
 *
 *  @since <#1.0#>
 */
- (NSString *)base64;

/**
 *  @author CC, 15-08-27
 *
 *  @brief  Image压缩转base64位字符串
 *
 *  @param targetSize 压缩图片大小
 *
 *  @return 返回Image字符串
 *
 *  @since 1.0
 */
- (NSString *)base64: (CGSize)targetSize;

/**
 *  @author CC, 15-08-27
 *
 *  @brief  Image压缩转base64位字符串
 *
 *  @param size    压缩图片大小
 *  @param percent 压缩比例
 *
 *  @return 返回Image字符串
 *
 *  @since 1.0
 */
- (NSString *)baset64:(CGSize)size
              Percent:(float)percent;

@end
