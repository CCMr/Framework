//
//  CCMessageVoiceFactory.h
//  Remitchat
//
//  Created by CC on 15/8/17.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCMessageBubbleFactory.h"

@interface CCMessageVoiceFactory : NSObject

+ (UIImageView *)messageVoiceAnimationImageViewWithBubbleMessageType:(CCBubbleMessageType)type;

@end
