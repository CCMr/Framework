//
//  CCEmotionCollectionViewCell.m
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "CCEmotionCollectionViewCell.h"

@interface CCEmotionCollectionViewCell ()

/**
 *  显示表情封面的控件
 */
@property (nonatomic, weak) UIImageView *emotionImageView;

/**
 *  配置默认控件和参数
 */
- (void)setup;
@end


@implementation CCEmotionCollectionViewCell

#pragma setter method

- (void)setEmotion:(CCEmotion *)emotion {
    _emotion = emotion;

    // TODO:
    self.emotionImageView.image = emotion.emotionConverPhoto;
}

#pragma mark - Life cycle

- (void)setup {
    if (!_emotionImageView) {
        UIImageView *emotionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCCEmotionImageViewSize, kCCEmotionImageViewSize)];
        emotionImageView.backgroundColor = [UIColor colorWithRed:0.000 green:0.251 blue:0.502 alpha:1.000];
        [self.contentView addSubview:emotionImageView];
        self.emotionImageView = emotionImageView;
    }
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.emotion = nil;
}


@end
