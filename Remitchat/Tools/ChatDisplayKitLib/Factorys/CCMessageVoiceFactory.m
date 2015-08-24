//
//  CCMessageVoiceFactory.m
//  Remitchat
//
//  Created by CC on 15/8/17.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "CCMessageVoiceFactory.h"

@implementation CCMessageVoiceFactory

+ (UIImageView *)messageVoiceAnimationImageViewWithBubbleMessageType:(CCBubbleMessageType)type {
    UIImageView *messageVoiceAniamtionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 17)];
    NSString *imageSepatorName;
    switch (type) {
        case CCBubbleMessageTypeSending:
            imageSepatorName = @"Sender";
            break;
        case CCBubbleMessageTypeReceiving:
            imageSepatorName = @"Receiver";
            break;
        default:
            break;
    }
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i = 0; i < 4; i ++) {
        UIImage *image = [UIImage imageNamed:[imageSepatorName stringByAppendingFormat:@"VoiceNodePlaying00%ld", (long)i]];
        if (image)
            [images addObject:image];
    }

    messageVoiceAniamtionImageView.image = [UIImage imageNamed:[imageSepatorName stringByAppendingString:@"VoiceNodePlaying"]];
    messageVoiceAniamtionImageView.animationImages = images;
    messageVoiceAniamtionImageView.animationDuration = 1.0;
    [messageVoiceAniamtionImageView stopAnimating];

    return messageVoiceAniamtionImageView;
}


@end
