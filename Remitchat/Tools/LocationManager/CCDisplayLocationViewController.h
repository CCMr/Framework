//
//  CCDisplayLocationViewController.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CCDisplayLocationViewController : UIViewController

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *geolocations;

@end
