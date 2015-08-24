//
//  ChatMessageTableViewController.m
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "ChatMessageTableViewController.h"
#import "CCAudioPlayerHelper.h"
//#import "CCDisplayMediaViewController.h"
#import "CCDisplayLocationViewController.h"
#import "ChatMessageViewModel.h"

@interface ChatMessageTableViewController () <CCAudioPlayerHelperDelegate>

@property (nonatomic, strong) NSArray *emotionManagers;

@property (nonatomic, strong) CCMessageTableViewCell *currentSelectedCell;

@property (nonatomic, strong) ChatMessageViewModel *viewModel;

@end

@implementation ChatMessageTableViewController

- (void)loadDemoDataSource
{
    WEAKSELF
    [_viewModel responseWithBlock:^(id responseData) {
        weakSelf.messages = responseData;
        [weakSelf.messageTableView reloadData];

        [weakSelf scrollToBottomAnimated:NO];
    } WithErrorBlock:^(id errorCode) {
        [weakSelf scrollToBottomAnimated:NO];
    } WithFailureBlock:^(id failure) {
        [weakSelf scrollToBottomAnimated:NO];
    }];
    [_viewModel fetchDataSource];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[CCAudioPlayerHelper shareInstance] stopAudio];
}

- (id)init {
    self = [super init];
    if (self) {
        // 配置输入框UI的样式
        //        self.allowsSendVoice = NO;
        //        self.allowsSendFace = NO;
        //        self.allowsSendMultiMedia = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (CURRENT_SYS_VERSION >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan=NO;
    }
    self.title = CCLocalization(@"聊天");

    _viewModel = [[ChatMessageViewModel alloc] init];

    // Custom UI
    //    [self setBackgroundColor:[UIColor clearColor]];
    //    [self setBackgroundImage:[UIImage imageNamed:@"TableViewBackgroundImage"]];

    // 设置自身用户名
    self.messageSender = @"Jack";

    NSMutableArray *emotionManagers = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++) {
        CCEmotionManager *emotionManager = [[CCEmotionManager alloc] init];
        emotionManager.emotionName = [NSString stringWithFormat:@"表情%ld", (long)i];
        NSMutableArray *emotions = [NSMutableArray array];
        for (NSInteger j = 0; j < 18; j ++) {
            CCEmotion *emotion = [[CCEmotion alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"section%ld_emotion%ld", (long)i , (long)j % 16];
            emotion.emotionPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"emotion%ld.gif", (long)j] ofType:@""];
            emotion.emotionConverPhoto = [UIImage imageNamed:imageName];
            [emotions addObject:emotion];
        }
        emotionManager.emotions = emotions;

        [emotionManagers addObject:emotionManager];
    }

    self.emotionManagers = emotionManagers;
    [self.emotionManagerView reloadData];

    [self initShareMenu];
    [self.shareMenuView reloadData];

    [self loadDemoDataSource];
}

-(void)initShareMenu
{
    NSMutableArray *shareMenuItems = [NSMutableArray array];

    CCShareMenuItem *Photo = [[CCShareMenuItem alloc] initWithNormalIconImage:[UIImage imageNamed:@"sharemore_pic"] title:@"照片" MenuItemType:CCShareMenuItemTypePhoto];
    [shareMenuItems addObject:Photo];

    CCShareMenuItem *video = [[CCShareMenuItem alloc] initWithNormalIconImage:[UIImage imageNamed:@"sharemore_video"] title:@"拍摄" MenuItemType:CCShareMenuItemTypeVideo];
    [shareMenuItems addObject:video];

    self.shareMenuItems = shareMenuItems;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.emotionManagers = nil;
    [[CCAudioPlayerHelper shareInstance] setDelegate:nil];
}

/*
 [self removeMessageAtIndexPath:indexPath];
 [self insertOldMessages:self.messages];
 */

#pragma mark - CCMessageTableViewCell delegate

/**
 *  @author CC, 15-08-18
 *
 *  @brief  点击聊天信息处理委托
 *
 *  @param message              消息体
 *  @param indexPath            下标
 *  @param messageTableViewCell 当前Cell
 *
 *  @since 1.0
 */
- (void)multiMediaMessageDidSelectedOnMessage:(id<CCMessageModel>)message
                                  atIndexPath:(NSIndexPath *)indexPath
                       onMessageTableViewCell:(CCMessageTableViewCell *)messageTableViewCell
{
    UIViewController *disPlayViewController;
    switch (message.messageMediaType) {
        case CCBubbleMessageMediaTypeVideo:
        case CCBubbleMessageMediaTypePhoto: {
            NSLog(@"message : %@", message.photo);
            NSLog(@"message : %@", message.videoConverPhoto);
            //            CCDisplayMediaViewController *messageDisplayTextView = [[CCDisplayMediaViewController alloc] init];
            //            messageDisplayTextView.message = message;
            //            disPlayViewController = messageDisplayTextView;
            break;
        }
            break;
        case CCBubbleMessageMediaTypeVoice: {
            NSLog(@"message : %@", message.voicePath);

            // Mark the voice as read and hide the red dot.
            message.isRead = YES;
            messageTableViewCell.messageBubbleView.voiceUnreadDotImageView.hidden = YES;

            [[CCAudioPlayerHelper shareInstance] setDelegate:(id<NSFileManagerDelegate>)self];
            if (_currentSelectedCell) {
                [_currentSelectedCell.messageBubbleView.animationVoiceImageView stopAnimating];
            }
            if (_currentSelectedCell == messageTableViewCell) {
                [messageTableViewCell.messageBubbleView.animationVoiceImageView stopAnimating];
                [[CCAudioPlayerHelper shareInstance] stopAudio];
                self.currentSelectedCell = nil;
            } else {
                self.currentSelectedCell = messageTableViewCell;
                [messageTableViewCell.messageBubbleView.animationVoiceImageView startAnimating];
                [[CCAudioPlayerHelper shareInstance] managerAudioWithFileName:message.voicePath toPlay:YES];
            }
            break;
        }
        case CCBubbleMessageMediaTypeEmotion:
            NSLog(@"facePath : %@", message.emotionPath);
            break;
        case CCBubbleMessageMediaTypeLocalPosition: {
            NSLog(@"facePath : %@", message.localPositionPhoto);
            CCDisplayLocationViewController *displayLocationViewController = [[CCDisplayLocationViewController alloc] init];
            displayLocationViewController.location = [message location];
            disPlayViewController = displayLocationViewController;
            break;
        }
        default:
            break;
    }
    if (disPlayViewController) {
        [self.navigationController pushViewController:disPlayViewController animated:YES];
    }
}

- (void)didDoubleSelectedOnTextMessage:(id<CCMessageModel>)message
                           atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"text : %@", message.text);
    //    XHDisplayTextViewController *displayTextViewController = [[XHDisplayTextViewController alloc] init];
    //    displayTextViewController.message = message;
    //    [self.navigationController pushViewController:displayTextViewController animated:YES];
}

/**
 *  @author CC, 15-08-18
 *
 *  @brief  点击头像跳转
 *
 *  @param message   消息体
 *  @param indexPath 选中下标
 *
 *  @since 1.0
 */
- (void)didSelectedAvatarOnMessage:(id<CCMessageModel>)message atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath : %@", indexPath);
    //    CCContact *contact = [[CCContact alloc] init];
    //    contact.contactName = [message sender];
    //    contact.contactIntroduction = @"自定义描述，这个需要和业务逻辑挂钩";
    //    XHContactDetailTableViewController *contactDetailTableViewController = [[XHContactDetailTableViewController alloc] initWithContact:contact];
    //    [self.navigationController pushViewController:contactDetailTableViewController animated:YES];
}

- (void)menuDidSelectedAtBubbleMessageMenuSelecteType:(CCBubbleMessageMenuSelecteType)bubbleMessageMenuSelecteType
{

}

#pragma mark - CCAudioPlayerHelper Delegate

- (void)didAudioPlayerStopPlay:(AVAudioPlayer *)audioPlayer {
    if (!_currentSelectedCell) {
        return;
    }
    [_currentSelectedCell.messageBubbleView.animationVoiceImageView stopAnimating];
    self.currentSelectedCell = nil;
}

#pragma mark - CCEmotionManagerView DataSource

- (NSInteger)numberOfEmotionManagers {
    return self.emotionManagers.count;
}

- (CCEmotionManager *)emotionManagerForColumn:(NSInteger)column {
    return [self.emotionManagers objectAtIndex:column];
}

- (NSArray *)emotionManagersAtManager {
    return self.emotionManagers;

}

#pragma mark - CCMessageTableViewController Delegate

- (BOOL)shouldLoadMoreMessagesScrollToTop {
    return YES;
}

- (void)loadMoreMessagesScrollTotop
{
    if (!self.loadingMoreMessage) {
        self.loadingMoreMessage = YES;

        WEAKSELF
        [_viewModel responseWithBlock:^(id responseData) {
            [weakSelf insertOldMessages:responseData];
            weakSelf.loadingMoreMessage = NO;
        } WithErrorBlock:^(id errorCode) {
            [weakSelf scrollToBottomAnimated:NO];
        } WithFailureBlock:^(id failure) {
            [weakSelf scrollToBottomAnimated:NO];
        }];
         [_viewModel fetchDataSource];
    }
}

/**
 *  发送文本消息的回调方法
 *
 *  @param text   目标文本字符串
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendText:(NSString *)text
         fromSender:(NSString *)sender
             onDate:(NSDate *)date
{
    WEAKSELF
    [_viewModel sendMessage:CCBubbleMessageMediaTypeText SendData:@{@"Text":text,@"sender":sender,@"timestamp":date} Completion:^(id request) {
        [weakSelf addMessage:request];
        [weakSelf finishSendMessageWithBubbleMessageType:CCBubbleMessageMediaTypeText];
    }];
}

/**
 *  发送图片消息的回调方法
 *
 *  @param photo  目标图片对象，后续有可能会换
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendPhoto:(UIImage *)photo
          fromSender:(NSString *)sender
              onDate:(NSDate *)date
{
    WEAKSELF
    [_viewModel sendMessage:CCBubbleMessageMediaTypePhoto SendData:@{@"Photo":photo,@"sender":sender,@"timestamp":date} Completion:^(id request) {
        [weakSelf addMessage:request];
        [weakSelf finishSendMessageWithBubbleMessageType:CCBubbleMessageMediaTypePhoto];
    }];
}

/**
 *  发送视频消息的回调方法
 *
 *  @param videoPath 目标视频本地路径
 *  @param sender    发送者的名字
 *  @param date      发送时间
 */
- (void)didSendVideoConverPhoto:(UIImage *)videoConverPhoto
                      videoPath:(NSString *)videoPath
                     fromSender:(NSString *)sender
                         onDate:(NSDate *)date
{
    WEAKSELF
    [_viewModel sendMessage:CCBubbleMessageMediaTypeVideo SendData:@{@"Photo":videoConverPhoto,@"videoPath":videoPath,@"sender":sender,@"timestamp":date} Completion:^(id request) {
        [weakSelf addMessage:request];
        [weakSelf finishSendMessageWithBubbleMessageType:CCBubbleMessageMediaTypeVideo];
    }];
}

/**
 *  发送语音消息的回调方法
 *
 *  @param voicePath        目标语音本地路径
 *  @param voiceDuration    目标语音时长
 *  @param sender           发送者的名字
 *  @param date             发送时间
 */
- (void)didSendVoice:(NSString *)voicePath
       voiceDuration:(NSString *)voiceDuration
          fromSender:(NSString *)sender
              onDate:(NSDate *)date
{
    WEAKSELF
    [_viewModel sendMessage:CCBubbleMessageMediaTypeVoice SendData:@{@"VoicePath":voicePath,@"voiceDuration":voiceDuration,@"sender":sender,@"timestamp":date} Completion:^(id request) {
        [weakSelf addMessage:request];
        [weakSelf finishSendMessageWithBubbleMessageType:CCBubbleMessageMediaTypeVoice];
    }];
}

/**
 *  发送第三方表情消息的回调方法
 *
 *  @param facePath 目标第三方表情的本地路径
 *  @param sender   发送者的名字
 *  @param date     发送时间
 */
- (void)didSendEmotion:(NSString *)emotionPath
            fromSender:(NSString *)sender
                onDate:(NSDate *)date
{
    WEAKSELF
    [_viewModel sendMessage:CCBubbleMessageMediaTypeEmotion SendData:@{@"emotionPath":emotionPath,@"sender":sender,@"timestamp":date} Completion:^(id request) {
        [weakSelf addMessage:request];
        [weakSelf finishSendMessageWithBubbleMessageType:CCBubbleMessageMediaTypeEmotion];
    }];
}

/**
 *  @author CC, 15-08-20
 *
 *  @brief  发送地理位置
 *
 *  @param geoLocationsPhoto 地理位置图片
 *  @param geolocations      地理位置
 *  @param location          经纬度
 *  @param sender            发送者的名字
 *  @param date              发送时间
 *
 *  @since 1.0
 */
- (void)didSendGeoLocationsPhoto:(UIImage *)geoLocationsPhoto
                    geolocations:(NSString *)geolocations
                        location:(CLLocation *)location
                      fromSender:(NSString *)sender
                          onDate:(NSDate *)date
{
    WEAKSELF
    [_viewModel sendMessage:CCBubbleMessageMediaTypeLocalPosition SendData:@{@"geoLocationsPhoto":geoLocationsPhoto,@"geolocations":geolocations,@"location":location,@"sender":sender,@"timestamp":date} Completion:^(id request) {
        [weakSelf addMessage:request];
        [weakSelf finishSendMessageWithBubbleMessageType:CCBubbleMessageMediaTypeLocalPosition];
    }];
}

/**
 *  是否显示时间轴Label的回调方法
 *
 *  @param indexPath 目标消息的位置IndexPath
 *
 *  @return 根据indexPath获取消息的Model的对象，从而判断返回YES or NO来控制是否显示时间轴Label
 */
- (BOOL)shouldDisplayTimestampForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  配置Cell的样式或者字体
 *
 *  @param cell      目标Cell
 *  @param indexPath 目标Cell所在位置IndexPath
 */
- (void)configureCell:(CCMessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

/**
 *  协议回掉是否支持用户手动滚动
 *
 *  @return 返回YES or NO
 */
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling {
    return YES;
}

@end
