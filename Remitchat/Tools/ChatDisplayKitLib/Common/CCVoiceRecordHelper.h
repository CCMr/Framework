//
//  CCVoiceRecordHelper.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^CCPrepareRecorderCompletion)();
typedef void(^CCStartRecorderCompletion)();
typedef void(^CCStopRecorderCompletion)();
typedef void(^CCPauseRecorderCompletion)();
typedef void(^CCResumeRecorderCompletion)();
typedef void(^CCCancellRecorderDeleteFileCompletion)();
typedef void(^CCRecordProgress)(float progress);
typedef void(^CCPeakPowerForChannel)(float peakPowerForChannel);

@interface CCVoiceRecordHelper : NSObject

@property (nonatomic, copy) CCStopRecorderCompletion maxTimeStopRecorderCompletion;
@property (nonatomic, copy) CCRecordProgress recordProgress;
@property (nonatomic, copy) CCPeakPowerForChannel peakPowerForChannel;
@property (nonatomic, copy, readonly) NSString *recordPath;
@property (nonatomic, copy) NSString *recordDuration;
@property (nonatomic) float maxRecordTime; // 默认 60秒为最大
@property (nonatomic, readonly) NSTimeInterval currentTimeInterval;

- (void)prepareRecordingWithPath:(NSString *)path prepareRecorderCompletion:(CCPrepareRecorderCompletion)prepareRecorderCompletion;
- (void)startRecordingWithStartRecorderCompletion:(CCStartRecorderCompletion)startRecorderCompletion;
- (void)pauseRecordingWithPauseRecorderCompletion:(CCPauseRecorderCompletion)pauseRecorderCompletion;
- (void)resumeRecordingWithResumeRecorderCompletion:(CCResumeRecorderCompletion)resumeRecorderCompletion;
- (void)stopRecordingWithStopRecorderCompletion:(CCStopRecorderCompletion)stopRecorderCompletion;
- (void)cancelledDeleteWithCompletion:(CCCancellRecorderDeleteFileCompletion)cancelledDeleteCompletion;


@end
