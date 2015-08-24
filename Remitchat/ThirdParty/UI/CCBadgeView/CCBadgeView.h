//
//  CCBadgeView.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

// Enums
typedef enum {
    CCBadgeViewHorizontalAlignmentLeft = 0,
    CCBadgeViewHorizontalAlignmentCenter,
    CCBadgeViewHorizontalAlignmentRight

} CCBadgeViewHorizontalAlignment;

typedef enum {
    CCBadgeViewWidthModeStandard = 0,     // 30x20
    CCBadgeViewWidthModeSmall            // 22x20
} CCBadgeViewWidthMode;

typedef enum {
    CCBadgeViewHeightModeStandard = 0,    // 20
    CCBadgeViewHeightModeLarge             // 30
} CCBadgeViewHeightMode;

// Constants
#define CC_BADGE_VIEW_STANDARD_HEIGHT       20.0
#define CC_BADGE_VIEW_LARGE_HEIGHT          30.0
#define CC_BADGE_VIEw_STANDARD_WIDTH        30.0
#define CC_BADGE_VIEw_MINIMUM_WIDTH         22.0
#define CC_BADGE_VIEW_FONT_SIZE             16.0

@interface CCBadgeView : UIView

@property (nonatomic, copy) NSString* text;
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, strong) UIFont* font;
@property (nonatomic, strong) UIColor* badgeColor;
@property (nonatomic, strong) UIColor* outlineColor;
@property (nonatomic, assign) CGFloat outlineWidth;
@property (nonatomic, assign) BOOL outline;
@property (nonatomic, assign) CCBadgeViewHorizontalAlignment horizontalAlignment;
@property (nonatomic, assign) CCBadgeViewWidthMode widthMode;
@property (nonatomic, assign) CCBadgeViewHeightMode heightMode;
@property (nonatomic, assign) BOOL shadow;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowBlur;
@property (nonatomic, strong) UIColor* shadowColor;
@property (nonatomic, assign) BOOL shadowOfOutline;
@property (nonatomic, assign) BOOL shadowOfText;
@property (nonatomic, assign) CGSize textOffset;

+ (CGFloat)badgeHeight; // @depricated
- (CGFloat)badgeHeight;


@end
