//
//  CCConfigurationHelper.h
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCConfigurationHelper : NSObject

@property (nonatomic, strong, readonly) NSArray *popMenuTitles;

+ (instancetype)appearance;

- (void)setupPopMenuTitles:(NSArray *)popMenuTitles;


@end
