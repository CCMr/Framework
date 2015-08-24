//
//  BaseSearchTableViewController.h
//  Remitchat
//
//  Created by CC on 15/8/21.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseSearchTableViewController : BaseTableViewController

/**
 *  @author CC, 15-08-21
 *
 *  @brief  搜索结果数据源
 *
 *  @since <#1.0#>
 */
@property (nonatomic, strong) NSMutableArray *filteredDataSource;

/**
 *  @author CC, 15-08-21
 *
 *  @brief  TableView右边的IndexTitles数据源
 *
 *  @since 1.0
 */
@property (nonatomic, strong) NSArray *sectionIndexTitles;

/**
 *  @author CC, 15-08-21
 *
 *  @brief  判断TableView是否为搜索控制器的TableView
 *
 *  @param tableView 被判断的目标TableView对象
 *
 *  @return 返回是否为预想结果
 *
 *  @since <#1.0#>
 */
- (BOOL)enableForSearchTableView:(UITableView *)tableView;

/**
 *  @author CC, 15-08-21
 *
 *  @brief  获取搜索框的文本
 *
 *  @return 返回文本对象
 *
 *  @since 1.0
 */
- (NSString *)getSearchBarText;

@end
