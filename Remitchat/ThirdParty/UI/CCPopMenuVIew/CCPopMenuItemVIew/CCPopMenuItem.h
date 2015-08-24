//
//  CCPopMenuItem.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCCMenuTableViewWidth 122
#define kCCMenuTableViewSapcing 7

#define kCCMenuItemViewHeight 36
#define kCCMenuItemViewImageSapcing 15
#define kCCSeparatorLineImageViewHeight 0.5

@interface CCPopMenuItem : NSObject

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *title;

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;

@end
