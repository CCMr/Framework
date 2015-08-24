//
//  CCSlideShadowAnimation.m
//  Remitchat
//
//  Created by CC on 15/8/20.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import "CCSlideShadowAnimation.h"

@interface CCSlideShadowAnimation()

@property (nonatomic, strong) CABasicAnimation *currentAnimation;

@property (nonatomic, assign) BOOL isAnimated;

@end

@implementation CCSlideShadowAnimation

- (id) init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void) commonInit
{
    _shadowBackgroundColor = [UIColor colorWithWhite:1. alpha:.3];
    _shadowForegroundColor = [UIColor whiteColor];

    _shadowWidth = 20.;
    _repeatCount = HUGE_VALF;
    _duration = 3;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)applicationWillEnterForegroundNotification:(NSNotification *)nc
{
    if (_isAnimated) {
        [self start];
    }
    else {
        [self stop];
    }
}

/**
 *  @author CC, 15-08-20
 *
 *  @brief  启动函数
 *
 *  @since <#1.0#>
 */
- (void) start
{
    if(!self.animatedView){
        NSLog(@"CCSlideShadowAnimation no view to animate");
        return;
    }

    [self stop];

    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = self.animatedView.bounds;

    CGFloat gradientSize = self.shadowWidth / self.animatedView.frame.size.width;

    NSArray *startLocations = @[
                                @0,
                                [NSNumber numberWithFloat:(gradientSize / 2.)],
                                [NSNumber numberWithFloat:gradientSize]
                                ];
    NSArray *endLocations = @[
                              [NSNumber numberWithFloat:(1. - gradientSize)],
                              [NSNumber numberWithFloat:(1. - (gradientSize / 2.))],
                              @1
                              ];


    gradientMask.colors = @[
                            (id)self.shadowBackgroundColor.CGColor,
                            (id)self.shadowForegroundColor.CGColor,
                            (id)self.shadowBackgroundColor.CGColor
                            ];
    gradientMask.locations = startLocations;
    gradientMask.startPoint = CGPointMake(0 - (gradientSize * 2), .5);
    gradientMask.endPoint = CGPointMake(1 + gradientSize, .5);

    self.animatedView.layer.mask = gradientMask;

    _currentAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    _currentAnimation.fromValue = startLocations;
    _currentAnimation.toValue = endLocations;
    _currentAnimation.repeatCount = self.repeatCount;
    _currentAnimation.duration  = self.duration;
    _currentAnimation.delegate = self;

    [gradientMask addAnimation:_currentAnimation forKey:@"CCSlideShadowAnimation"];

}

/**
 *  @author CC, 15-08-20
 *
 *  @brief  停止函数
 *
 *  @since <#1.0#>
 */
- (void)stop
{
    if(self.animatedView && self.animatedView.layer.mask){
        [self.animatedView.layer.mask removeAnimationForKey:@"CCSlideShadowAnimation"];
        self.animatedView.layer.mask = nil;
        _currentAnimation = nil;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished
{
    if(anim == _currentAnimation){
        [self stop];
    }
}


@end
