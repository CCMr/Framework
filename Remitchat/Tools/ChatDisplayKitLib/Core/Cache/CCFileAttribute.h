//
//  CCFileAttribute.h
//  Remitchat
//
//  Created by CC on 15/8/17.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFileAttribute : NSObject

@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSDictionary *fileAttributes;
@property (nonatomic, readonly) NSDate *fileModificationDate;
- (id)initWithPath:(NSString *)filePath attributes:(NSDictionary *)attributes;

@end
