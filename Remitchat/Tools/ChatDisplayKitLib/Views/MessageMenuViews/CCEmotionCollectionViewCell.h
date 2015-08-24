//
//  CCEmotionCollectionViewCell.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCEmotion.h"

#define kCCEmotionCollectionViewCellIdentifier @"CCEmotionCollectionViewCellIdentifier"

@interface CCEmotionCollectionViewCell : UICollectionViewCell

/**
 *  需要显示和配置的gif表情对象
 */
@property (nonatomic, strong) CCEmotion *emotion;

@end
