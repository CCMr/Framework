//
//  UIButton+CCButtonTitlePosition.m
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "UIButton+CCButtonTitlePosition.h"

@implementation UIButton (CCButtonTitlePosition)

- (void)setTitlePositionWithType:(CCButtonTitlePostionType)type {
    switch (type) {
        case CCButtonTitlePostionTypeBottom: {
            // the space between the image and text
            CGFloat spacing = 2.0;

            // lower the text and push it left so it appears centered
            //  below the image
            CGSize imageSize = self.imageView.frame.size;
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);

            // raise the image and push it right so it appears centered
            //  above the text
            CGSize titleSize = self.titleLabel.frame.size;
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
            break;
        }
        default:
            break;
    }
}

@end
