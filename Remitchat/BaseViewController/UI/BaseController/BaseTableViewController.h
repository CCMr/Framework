//
//  BaseTableViewController.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

/**
 *  @author CC, 15-08-18
 *
 *  @brief  显示大量数据的控件
 *
 *  @since <#1.0#>
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  @author CC, 15-08-18
 *
 *  @brief  初始化init的时候设置tableView的样式才有效
 *
 *  @since <#1.0#>
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/**
 *  @author CC, 15-08-18
 *
 *  @brief  大量数据的数据源
 *
 *  @since <#1.0#>
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  @author CC, 15-08-18
 *
 *  @brief  去除iOS7新的功能api，tableView的分割线变成iOS6正常的样式
 *
 *  @since <#1.0#>
 */
- (void)configuraTableViewNormalSeparatorInset;

/**
 *  @author CC, 15-08-18
 *
 *  @brief   配置tableView右侧的index title 背景颜色，因为在iOS7有白色底色，iOS6没有
 *
 *  @param tableView 目标tableView
 *
 *  @since <#1.0#>
 */
- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView;

/**
 *  @author CC, 15-08-18
 *
 *  @brief  加载本地或者网络数据源
 *
 *  @since <#1.0#>
 */
- (void)loadDataSource;

/**
 *  @author CC, 2015-07-23
 *
 *  @brief  隐藏TableView多余线
 *
 *  @param tableView 目标tableView
 *
 *  @since 1.0
 */
- (void)setExtraCellLineHidden:(UITableView *)tableView;

@end
