//
//  CCActionSheet.h
//  Remitchat
//
//  Created by CC on 14-10-29.
//  Copyright (c) 2014年 IFLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCActionSheet : UIActionSheet

-(id)initWithContentView:(UIView *)views;

-(void)hide:(int)index;

@end
