//
//  CCActionSheet.m
//  Remitchat
//
//  Created by CC on 14-10-29.
//  Copyright (c) 2014年 IFLY. All rights reserved.
//

#import "CCActionSheet.h"

@implementation CCActionSheet{
    UIView *SheetBg;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

-(id)initWithContentView:(UIView *)views{
    self = [super init];
    if (self) {
        SheetBg = views;
        [self addSubview:views];
    }
    return self;
}

-(void)hide:(int)index{
    [self actionSheet:self clickedButtonAtIndex:index];
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, winsize.height - SheetBg.frame.size.height - 50, winsize.width, SheetBg.frame.size.height);
    
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
        
        if ([v isKindOfClass:[UIButton class]]) {
            [v removeFromSuperview];
        }
    }
}

@end
