//
//  ChatTableViewCell.m
//  Remitchat
//
//  Created by CC on 15/8/21.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "MessageRootEntity.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(id)data{
    MessageRootEntity *entity = data;
    _avatar.image = [UIImage imageNamed:@"avator"];
    _title.text = entity.title;
    _detailed.text = entity.detailed;
    _sendTime.text = entity.sendTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
