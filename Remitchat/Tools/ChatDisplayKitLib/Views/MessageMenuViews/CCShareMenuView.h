//
//  CCShareMenuView.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCShareMenuItem.h"

#define kXHShareMenuPageControlHeight 30

@protocol CCShareMenuViewDelegate <NSObject>

@optional
/**
 *  点击第三方功能回调方法
 *
 *  @param shareMenuItem 被点击的第三方Model对象，可以在这里做一些特殊的定制
 *  @param index         被点击的位置
 */
- (void)didSelecteShareMenuItem:(CCShareMenuItem *)shareMenuItem atIndex:(NSInteger)index;

@end


@interface CCShareMenuView : UIView

/**
 *  第三方功能Models
 */
@property (nonatomic, strong) NSArray *shareMenuItems;

@property (nonatomic, weak) id <CCShareMenuViewDelegate> delegate;

/**
 *  根据数据源刷新第三方功能按钮的布局
 */
- (void)reloadData;


@end
