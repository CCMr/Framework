//
//  ScanningView.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCScanningView : UIView

@property (nonatomic, assign, readonly) CCScanningStyle scanningStyle;

- (void)transformScanningTypeWithStyle:(CCScanningStyle)style;

@end
