//
//  CCPopMenu.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPopMenuItem.h"

typedef void(^PopMenuDidSlectedCompledBlock)(NSInteger index, CCPopMenuItem *menuItem);

@interface CCPopMenu : UIView

- (instancetype)initWithMenus:(NSArray *)menus;

- (instancetype)initWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

- (void)showMenuAtPoint:(CGPoint)point;

- (void)showMenuOnView:(UIView *)view atPoint:(CGPoint)point;

@property (nonatomic, copy) PopMenuDidSlectedCompledBlock popMenuDidSlectedCompled;

@property (nonatomic, copy) PopMenuDidSlectedCompledBlock popMenuDidDismissCompled;


@end
