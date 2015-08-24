//
//  ChatMessageViewModel.h
//  Remitchat
//
//  Created by CC on 15/8/20.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import "BaseViewModel.h"

@interface ChatMessageViewModel : BaseViewModel

/**
 *  @author CC, 15-08-20
 *
 *  @brief  发送消息函数
 *
 *  @param messageType 发送消息类型
 *  @param sendData    发送的数据
 *  @param completion  发送回调函数
 *
 *  @since 1.0
 */
- (void) sendMessage: (CCBubbleMessageMediaType)messageType
            SendData:(NSDictionary *)sendData
          Completion: (Completion) completion;

@end
