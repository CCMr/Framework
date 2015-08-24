//
//  CCEmotionCollectionViewFlowLayout.m
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "CCEmotionCollectionViewFlowLayout.h"

@implementation CCEmotionCollectionViewFlowLayout

- (id)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(kCCEmotionImageViewSize, kCCEmotionImageViewSize);
        int count = winsize.width / (kCCEmotionImageViewSize + kCCEmotionMinimumLineSpacing);
        CGFloat spacing = winsize.width / count - kCCEmotionImageViewSize;
        self.minimumLineSpacing = spacing;
        self.sectionInset = UIEdgeInsetsMake(10, spacing / 2, 0, spacing / 2);
        self.collectionView.alwaysBounceVertical = YES;
    }
    return self;
}


@end
