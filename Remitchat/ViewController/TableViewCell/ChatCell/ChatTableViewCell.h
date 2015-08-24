//
//  ChatTableViewCell.h
//  Remitchat
//
//  Created by CC on 15/8/21.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface ChatTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detailed;
@property (weak, nonatomic) IBOutlet UILabel *sendTime;
@property (weak, nonatomic) IBOutlet UIImageView *status;

@end
