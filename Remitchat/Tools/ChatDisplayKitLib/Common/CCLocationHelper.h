//
//  CCLocationHelper.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^DidGetGeolocationsCompledBlock)(NSArray *placemarks);

@interface CCLocationHelper : NSObject

- (void)getCurrentGeolocationsCompled:(DidGetGeolocationsCompledBlock)compled;

@end
