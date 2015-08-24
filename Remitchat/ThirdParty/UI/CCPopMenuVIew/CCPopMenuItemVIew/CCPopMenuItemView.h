//
//  CCPopMenuItemView.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPopMenuItem.h"

@interface CCPopMenuItemView : UITableViewCell

@property (nonatomic, strong) CCPopMenuItem *popMenuItem;

- (void)setupPopMenuItem:(CCPopMenuItem *)popMenuItem atIndexPath:(NSIndexPath *)indexPath isBottom:(BOOL)isBottom;

@end
