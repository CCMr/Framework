//
//  ChatMessageViewModel.m
//  Remitchat
//
//  Created by CC on 15/8/20.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import "ChatMessageViewModel.h"
#import "CCMessage.h"
#import "CCMessageVideoConverPhotoFactory.h"

@implementation ChatMessageViewModel

- (CCMessage *)getTextMessageWithBubbleMessageType:(CCBubbleMessageType)bubbleMessageType {
    CCMessage *textMessage = [[CCMessage alloc] initWithText:@"Call Me 15915895880.这是华捷微信，为什么模仿这个页面效果呢？希望微信团队能看到我们在努力，请微信团队给个机会，让我好好的努力靠近大神，希望自己也能发亮，好像有点过分的希望了，如果大家喜欢这个开源库，请大家帮帮忙支持这个开源库吧！我是Jack，叫华仔也行，曾宪华就是我啦！" sender:@"华仔" timestamp:[NSDate distantPast]];
    textMessage.avatar = [UIImage imageNamed:@"avatar"];
    textMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    textMessage.bubbleMessageType = bubbleMessageType;

    return textMessage;
}

- (CCMessage *)getPhotoMessageWithBubbleMessageType:(CCBubbleMessageType)bubbleMessageType {
    CCMessage *photoMessage = [[CCMessage alloc] initWithPhoto:[UIImage imageNamed:@"placeholderImage"] thumbnailUrl:@"http://www.pailixiu.com/jack/networkPhoto.png" originPhotoUrl:nil sender:@"Jack" timestamp:[NSDate date]];
    photoMessage.avatar = [UIImage imageNamed:@"avatar"];
    photoMessage.avatarUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    photoMessage.bubbleMessageType = bubbleMessageType;

    return photoMessage;
}

- (CCMessage *)getVideoMessageWithBubbleMessageType:(CCBubbleMessageType)bubbleMessageType {
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"IMG_1555.MOV" ofType:@""];
    CCMessage *videoMessage = [[CCMessage alloc] initWithVideoConverPhoto:[CCMessageVideoConverPhotoFactory videoConverPhotoWithVideoPath:videoPath] videoPath:videoPath videoUrl:nil sender:@"Jayson" timestamp:[NSDate date]];
    videoMessage.avatar = [UIImage imageNamed:@"avatar"];
    videoMessage.avatarUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    videoMessage.bubbleMessageType = bubbleMessageType;

    return videoMessage;
}

- (CCMessage *)getVoiceMessageWithBubbleMessageType:(CCBubbleMessageType)bubbleMessageType {
    CCMessage *voiceMessage = [[CCMessage alloc] initWithVoicePath:nil voiceUrl:nil voiceDuration:@"1" sender:@"Jayson" timestamp:[NSDate date]];    initWithVoicePath: voiceUrl: sender: timestamp:
    voiceMessage.avatar = [UIImage imageNamed:@"avatar"];
    voiceMessage.avatarUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    voiceMessage.bubbleMessageType = bubbleMessageType;

    return voiceMessage;
}

- (CCMessage *)getEmotionMessageWithBubbleMessageType:(CCBubbleMessageType)bubbleMessageType {
    CCMessage *emotionMessage = [[CCMessage alloc] initWithEmotionPath:[[NSBundle mainBundle] pathForResource:@"Demo0.gif" ofType:nil] sender:@"Jayson" timestamp:[NSDate date]];
    emotionMessage.avatar = [UIImage imageNamed:@"avatar"];
    emotionMessage.avatarUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    emotionMessage.bubbleMessageType = bubbleMessageType;

    return emotionMessage;
}

- (CCMessage *)getGeolocationsMessageWithBubbleMessageType:(CCBubbleMessageType)bubbleMessageType {
    CCMessage *localPositionMessage = [[CCMessage alloc] initWithLocalPositionPhoto:[UIImage imageNamed:@"Fav_Cell_Loc"] geolocations:@"中国湖南省长沙" location:[[CLLocation alloc] initWithLatitude:23.110387 longitude:113.399444] sender:@"Jack" timestamp:[NSDate date]];
    localPositionMessage.avatar = [UIImage imageNamed:@"avatar"];
    localPositionMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    localPositionMessage.bubbleMessageType = bubbleMessageType;

    return localPositionMessage;
}

- (NSMutableArray *)getTestMessages {
    NSMutableArray *messages = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < 2; i ++) {
        [messages addObject:[self getPhotoMessageWithBubbleMessageType:(i % 5) ? CCBubbleMessageTypeSending : CCBubbleMessageTypeReceiving]];

        [messages addObject:[self getVideoMessageWithBubbleMessageType:(i % 6) ? CCBubbleMessageTypeSending : CCBubbleMessageTypeReceiving]];

        [messages addObject:[self getVoiceMessageWithBubbleMessageType:(i % 4) ? CCBubbleMessageTypeSending : CCBubbleMessageTypeReceiving]];

        [messages addObject:[self getEmotionMessageWithBubbleMessageType:(i % 2) ? CCBubbleMessageTypeSending : CCBubbleMessageTypeReceiving]];

        [messages addObject:[self getGeolocationsMessageWithBubbleMessageType:(i % 7) ? CCBubbleMessageTypeSending : CCBubbleMessageTypeReceiving]];

        [messages addObject:[self getTextMessageWithBubbleMessageType:(i % 2) ? CCBubbleMessageTypeSending : CCBubbleMessageTypeReceiving]];
    }
    return messages;
}

- (void)fetchDataSource
{
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *messages = [weakSelf getTestMessages];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.returnBlock(messages);
        });
    });
}

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
- (void)sendMessage:(CCBubbleMessageMediaType)messageType
           SendData:(NSDictionary *)sendData
         Completion:(Completion)completion
{
    CCMessage *sendMessage;
    switch (messageType) {
        case CCBubbleMessageMediaTypeText:
            sendMessage = [[CCMessage alloc] initWithText:[sendData objectForKey:@"Text"] sender:[sendData objectForKey:@"sender"] timestamp:[sendData objectForKey:@"timestamp"]];
            sendMessage.avatar = [UIImage imageNamed:@"Avatar"];
            sendMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";

            break;
        case CCBubbleMessageMediaTypePhoto:
            sendMessage = [[CCMessage alloc] initWithPhoto:[sendData objectForKey:@"Photo"] thumbnailUrl:nil originPhotoUrl:nil sender:[sendData objectForKey:@"sender"] timestamp:[sendData objectForKey:@"timestamp"]];
            sendMessage.avatar = [UIImage imageNamed:@"avatar"];
            sendMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";

            break;
        case CCBubbleMessageMediaTypeVideo:
            sendMessage = [[CCMessage alloc] initWithVideoConverPhoto:[sendData objectForKey:@"videoConverPhoto"] videoPath:[sendData objectForKey:@"videoPath"] videoUrl:nil sender:[sendData objectForKey:@"sender"] timestamp:[sendData objectForKey:@"timestamp"]];
            sendMessage.avatar = [UIImage imageNamed:@"avatar"];
            sendMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";

            break;
        case CCBubbleMessageMediaTypeVoice:
            sendMessage = [[CCMessage alloc] initWithVoicePath:[sendData objectForKey:@"voicePath"] voiceUrl:nil voiceDuration:[sendData objectForKey:@"voiceDuration"] sender:[sendData objectForKey:@"sender"] timestamp:[sendData objectForKey:@"timestamp"]];
            sendMessage.avatar = [UIImage imageNamed:@"avatar"];
            sendMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";

            break;
        case CCBubbleMessageMediaTypeEmotion:
            sendMessage = [[CCMessage alloc] initWithEmotionPath:[sendData objectForKey:@"emotionPath"] sender:[sendData objectForKey:@"sender"] timestamp:[sendData objectForKey:@"timestamp"]];
            sendMessage.avatar = [UIImage imageNamed:@"avatar"];
            sendMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";

            break;
        case CCBubbleMessageMediaTypeLocalPosition:
            sendMessage = [[CCMessage alloc] initWithLocalPositionPhoto:[sendData objectForKey:@"geoLocationsPhoto"] geolocations:[sendData objectForKey:@"geolocations"] location:[sendData objectForKey:@"location"] sender:[sendData objectForKey:@"sender"] timestamp:[sendData objectForKey:@"timestamp"]];
            sendMessage.avatar = [UIImage imageNamed:@"avatar"];
            sendMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";

        default:
            break;
    }
    completion(sendMessage);
}

@end
