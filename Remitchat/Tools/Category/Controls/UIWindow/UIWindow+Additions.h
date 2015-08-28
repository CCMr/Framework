//
//  UIWindow+Additions.h
//  Remitchat
//
//  Created by CC on 15/8/28.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Additions)

- (UIViewController *)viewControllerForStatusBarStyle;
- (UIViewController *)viewControllerForStatusBarHidden;
- (UIImage *)snapshot;

@end
