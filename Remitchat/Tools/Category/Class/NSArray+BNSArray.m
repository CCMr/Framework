//
//  NSArray+BNSArray.m
//  Remitchat
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

#import "NSArray+BNSArray.h"

@implementation NSArray (BNSArray)

/**
 *  @author CC, 2015-07-23 10:07:46
 *
 *  @brief  可变数组
 *
 *  @return <#return value description#>
 *
 *  @since <#version number#>
 */
- (NSMutableArray *)mutableArray
{
    return [NSMutableArray arrayWithArray:self];
}

/**
 *  @author CC, 2015-07-23 10:07:39
 *
 *  @brief  创建可变数组
 *
 *  @param array <#array description#>
 *
 *  @return <#return value description#>
 *
 *  @since <#version number#>
 */
+ (NSMutableArray *)mutableUnEmptyArrayWithArray:(NSArray *)array
{
    if (array == nil) {
        return [NSMutableArray array];
    }
    return [array mutableArray];
}

/**
 *  @author CC, 2015-07-23 10:07:27
 *
 *  @brief  只适用于截取URL  Value
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 *
 *  @since 1.0
 */
- (NSString *)findOutUrlValueWithKey:(NSString *)key
{
    for(NSString *string in self){
        NSRange range = [string rangeOfString:key];
        if(range.location != NSNotFound){
            return [string substringFromIndex:range.location + range.length];
        }
    }
    return nil;
}

@end
