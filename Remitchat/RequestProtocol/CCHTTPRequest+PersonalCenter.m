//
//  CCHTTPRequest+PersonalCenter.m
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

#import "CCHTTPRequest.h"

@implementation CCHTTPRequest (PersonalCenter)

/**
 *  @author CC, 2015-07-24
 *
 *  @brief  登录请求
 *
 *  @param PostData      <#PostData description#>
 *  @param responseBlock <#responseBlock description#>
 *
 *  @since <#version number#>
 */
-(void)Login:(NSDictionary *)PostData responseBlock:(RequestBlock)responseBlock
{
    [self setRequestOBJBlock:responseBlock Key:@"Login"];
    
    NSString *urlString = [self appendingServerURLWithString:[NSString stringWithFormat:@"sysCenter?action=sysLogin"]];
    
    [[CCHTTPManager sharedlnstance] NetRequestGETWithRequestURL:urlString WithParameter:[self fixedParameters:PostData] WithReturnValeuBlock:^(id responseData) {
        [self responseProcessEvent:responseData BlokKey:@"Login"];
    } WithErrorCodeBlock:^(id errorCode) {
        [self errorCodeWithDic:errorCode BlokKey:@"Login"];
    } WithFailureBlock:^(id failure) {
        [self netFailure:failure BlokKey:@"Login"];
    }];
}

@end
