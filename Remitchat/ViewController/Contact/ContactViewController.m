//
//  ContactViewController.m
//  Remitchat
//
//  Created by CC on 15/8/14.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController


- (NSMutableArray *)getContactConfigureArray {
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    [contacts addObject:@[@"",@""]];
    for (int i = 0; i <= 26; i ++) {
        NSMutableArray *contact = [NSMutableArray array];

        NSString *contactName;
        switch (i) {
            case 0:
                contactName = @"apple";
                break;
            case 1:
                contactName = @"bpple";
                break;
            case 2:
                contactName = @"cpple";
                break;
            case 3:
                contactName = @"dpple";
                break;
            case 4:
                contactName = @"epple";
                break;
            case 5:
                contactName = @"fpple";
                break;
            case 6:
                contactName = @"gpple";
                break;
            case 7:
                contactName = @"hpple";
                break;
            case 8:
                contactName = @"ipple";
                break;
            case 9:
                contactName = @"jpple";
                break;
            case 10:
                contactName = @"kpple";
                break;
            case 11:
                contactName = @"rpple";
                break;
            case 12:
                contactName = @"mpple";
                break;
            case 13:
                contactName = @"npple";
                break;
            case 14:
                contactName = @"opple";
                break;
            case 15:
                contactName = @"ppple";
                break;
            case 16:
                contactName = @"qpple";
                break;
            case 17:
                contactName = @"rpple";
                break;
            case 18:
                contactName = @"spple";
                break;
            case 19:
                contactName = @"tpple";
                break;
            case 20:
                contactName = @"upple";
                break;
            case 21:
                contactName = @"vpple";
                break;
            case 22:
                contactName = @"wpple";
                break;
            case 23:
                contactName = @"xpple";
                break;
            case 24:
                contactName = @"ypple";
                break;
            case 25:
                contactName = @"zpple";
                break;
            case 26:
                contactName = @"#pple";
                break;
            default:
                break;
        }

        [contact addObject:contactName];

        [contacts addObject:contact];
    }

    return contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.sectionIndexColor = [UIColor grayColor];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDataSource];
}


- (void)loadDataSource
{
    NSMutableArray *secionindex = [NSMutableArray array];
    [secionindex addObject:UITableViewIndexSearch];
    [secionindex addObjectsFromArray:[UILocalizedIndexedCollation.currentCollation sectionIndexTitles]];
    self.sectionIndexTitles = secionindex;

    self.dataSource = [self getContactConfigureArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contactTableViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    // 默认通信录的tableView
    if (indexPath.section < self.dataSource.count) {
        // 获取联系人数组
        NSArray *sections = self.dataSource[indexPath.section];

        // 判断数组越界问题
        if (indexPath.row < [sections count]) {
           NSString *contact = sections[indexPath.row];
            cell.textLabel.text = contact;

        }
    }


    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
