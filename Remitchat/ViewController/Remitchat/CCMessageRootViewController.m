//
//  CCMessageRootViewController.m
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "CCMessageRootViewController.h"
#import "CCPopMenu.h"
#import "ChatMessageTableViewController.h"
#import "CCQRCodeViewController.h"

#import "ChatTableViewCell.h"
#import "CCMessageRootViewModel.h"

@interface CCMessageRootViewController ()

@property (nonatomic, strong) CCPopMenu *popMenu;
@property (nonatomic, strong) CCMessageRootViewModel *viewModel;

@end

@implementation CCMessageRootViewController

#pragma mark - Propertys
- (CCPopMenu *)popMenu {
    if (!_popMenu) {
        NSMutableArray *popMenuItems = [[NSMutableArray alloc] initWithCapacity:6];
        for (int i = 0; i < 5; i ++) {
            NSString *imageName;
            NSString *title;
            switch (i) {
                case 0: {
                    imageName = @"contacts_add_newmessage";
                    title = @"发起群聊";
                    break;
                }
                case 1: {
                    imageName = @"contacts_add_friend";
                    title = @"添加朋友";
                    break;
                }
                case 2: {
                    imageName = @"contacts_add_scan";
                    title = @"扫一扫";
                    break;
                }
                case 3: {
                    imageName = @"contacts_add_photo";
                    title = @"拍照分享";
                    break;
                }
                case 4: {
                    imageName = @"contacts_add_voip";
                    title = @"视频聊天";
                    break;
                }
                default:
                    break;
            }
            CCPopMenuItem *popMenuItem = [[CCPopMenuItem alloc] initWithImage:[UIImage imageNamed:imageName] title:title];
            [popMenuItems addObject:popMenuItem];
        }

        WEAKSELF
        _popMenu = [[CCPopMenu alloc] initWithMenus:popMenuItems];
        _popMenu.popMenuDidSlectedCompled = ^(NSInteger index, CCPopMenuItem *popMenuItems) {
            if (index == 2) {
                [weakSelf enterQRCodeController];
            }else if (index == 0 ) {
                //                [weakSelf addContactForGroup];
            }
        };
    }
    return _popMenu;
}

- (void)enterQRCodeController {
    CCQRCodeViewController *QRCodeViewController = [[CCQRCodeViewController alloc] init];
    [self pushNewViewController:QRCodeViewController];
}

- (void)loadDataSource {
    WEAKSELF
    [_viewModel responseWithBlock:^(id responseData) {
        weakSelf.dataSource = responseData;
        [weakSelf.tableView reloadData];
    } WithErrorBlock:^(id errorCode) {

    } WithFailureBlock:^(id failure) {
        [weakSelf hudMessages:nil DetailsLabelText:failure];
    }];
    [_viewModel fetchDataSource];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showMenuOnView:)];

    [self.view addSubview:self.tableView];

    _viewModel = [[CCMessageRootViewModel alloc] init];

    [self loadDataSource];
}

- (void)showMenuOnView:(UIBarButtonItem *)buttonItem {
    [self.popMenu showMenuOnView:self.view atPoint:CGPointZero];
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    ChatTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!Cell) {
        Cell = [[ChatTableViewCell alloc] init];
    }

    [Cell setData:self.dataSource[indexPath.row]];

    return Cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!indexPath.row) {
        //        [self enterNewsController];
    } else if (indexPath.row == 6) {
        //        [self enterCustomCellMessage];
    } else {
        //        [self enterMessage];
        ChatMessageTableViewController *viewController = [[ChatMessageTableViewController alloc] init];
        [self pushNewViewController:viewController];
    }
}


@end
