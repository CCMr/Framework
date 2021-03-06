//
//  BaseEntity.h
//  CC
//
// Copyright (c) 2015 CC ( http://www.ccskill.com )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


#import <Foundation/Foundation.h>

@interface BaseEntity : NSObject

//must override
+ (id)dataWithJavaJsonDictonary:(NSDictionary *)jsonDic error:(NSError **)error;

/**
 *  @author CC, 2015-06-23 11:06:49
 *  @brief  NSDictionary转对象
 *  @since 1.0
 */
+(id)BaseEntityWithDict:(NSDictionary *)dict;

/**
 *  @author CC, 2015-06-23 11:06:07
 *  @brief  初始化对象
 *  @since 1.0
 */
- (id)initWithDict:(NSDictionary *)dict;

/**
 *  @author CC, 2015-06-24 11:06:42
 *  @brief  赋值属性
 *          递归解析子对象时，对象属性命名规则：对应属性名_对应对象名
 *  @since 1.0
 */
- (void)setDic:(NSDictionary *)dic;

/**
 *  @author CC, 2015-06-16 16:06:45
 *  @brief  对象转NSDictionary
 */
- (NSDictionary *)ChangedDictionary;

@end


@interface BaseEntityList : NSObject

//must override
+ (id)dataWithJavaJsonDictonary:(NSDictionary *)jsonDic error:(NSError **)error;

@property (nonatomic,assign) NSUInteger pageIndex;
@property (nonatomic,assign) NSUInteger pageCount;
@property (nonatomic,strong) NSMutableArray *dataList;


@end
