//
//  CCCaptureHelper.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^DidOutputSampleBufferBlock)(CMSampleBufferRef sampleBuffer);

@interface CCCaptureHelper : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>

- (void)setDidOutputSampleBufferHandle:(DidOutputSampleBufferBlock)didOutputSampleBuffer;

- (void)showCaptureOnView:(UIView *)preview;

@end
