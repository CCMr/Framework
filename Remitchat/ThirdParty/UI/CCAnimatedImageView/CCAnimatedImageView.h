//
//  CCAnimatedImageView.h
//  Remitchat
//
//  Created by CC on 15/8/17.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCAnimatedImage;
@protocol CCAnimatedImageViewDebugDelegate;

@interface CCAnimatedImageView : UIImageView

@property (nonatomic, strong) CCAnimatedImage *animatedImage;

@property (nonatomic, strong, readonly) UIImage *currentFrame;
@property (nonatomic, assign, readonly) NSUInteger currentFrameIndex;

#if DEBUG
// Only intended to report internal state for debugging
@property (nonatomic, weak) id<CCAnimatedImageViewDebugDelegate> debug_delegate;
#endif

@end


#if DEBUG
@protocol CCAnimatedImageViewDebugDelegate <NSObject>

@optional

- (void)debug_animatedImageView:(CCAnimatedImageView *)animatedImageView waitingForFrame:(NSUInteger)index duration:(NSTimeInterval)duration;

@end
#endif

