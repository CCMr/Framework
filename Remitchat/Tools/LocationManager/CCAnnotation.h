//
//  CCAnnotation.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CCAnnotation : NSObject<MKAnnotation>

/**
 *  实现MKAnnotation协议必须要定义这个属性
 */
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) CLRegion *region;

@property (nonatomic, readwrite) CLLocationDistance radius;

- (id)initWithCLRegion:(CLRegion *)newRegion title:(NSString *)title subtitle:(NSString *)subtitle;

@end
