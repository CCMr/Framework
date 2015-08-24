//
//  CCAnnotation.m
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "CCAnnotation.h"

@implementation CCAnnotation

- (id)initWithCLRegion:(CLRegion *)newRegion title:(NSString *)title subtitle:(NSString *)subtitle {
    self = [super init];
    if (self) {
        self.region = newRegion;
        _coordinate = _region.center;
        self.radius = _region.radius;
        self.title = title;
        self.subtitle = subtitle;
    }

    return self;
}


/*
 This method provides a custom setter so that the model is notified when the subtitle value has changed.
 */
- (void)setRadius:(CLLocationDistance)newRadius {
    [self willChangeValueForKey:@"subtitle"];

    _radius = newRadius;

    [self didChangeValueForKey:@"subtitle"];
}

- (void)dealloc {
    _region = nil;
    _title = nil;
    _subtitle = nil;
}


@end
