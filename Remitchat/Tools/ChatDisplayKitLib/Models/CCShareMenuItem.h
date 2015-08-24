//
//  CCShareMenuItem.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCCShareMenuItemWidth 60
#define KCCShareMenuItemHeight 80

@interface CCShareMenuItem : NSObject

/**
 *  正常显示图片
 */
@property (nonatomic, strong) UIImage *normalIconImage;

/**
 *  第三方按钮的标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  @author CC, 15-08-18
 *
 *  @brief  按钮类型
 *
 *  @since 1.0
 */
@property (nonatomic, assign) CCShareMenuItemType itemType;

/**
 *  根据正常图片和标题初始化一个Model对象
 *
 *  @param normalIconImage 正常图片
 *  @param title           标题
 *
 *  @return 返回一个Model对象
 */
- (instancetype)initWithNormalIconImage:(UIImage *)normalIconImage
                                  title:(NSString *)title
                           MenuItemType:(CCShareMenuItemType)itemType;

@end
