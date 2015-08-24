//
//  CCMessageAvatarFactory.m
//  Remitchat
//
//  Created by CC on 15/8/17.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "CCMessageAvatarFactory.h"
#import "UIImage+CCRounded.h"

@implementation CCMessageAvatarFactory

+ (UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatarType:(CCMessageAvatarType)messageAvatarType {
    CGFloat radius = 0.0;
    switch (messageAvatarType) {
        case CCMessageAvatarTypeNormal:
            return originImage;
            break;
        case CCMessageAvatarTypeCircle:
            radius = originImage.size.width / 2.0;
            break;
        case CCMessageAvatarTypeSquare:
            radius = 8;
            break;
        default:
            break;
    }
    UIImage *avatar = [originImage createRoundedWithRadius:radius];
    return avatar;
}

@end
