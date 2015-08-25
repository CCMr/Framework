//
//  BaseViewModel.m
//  Remitchat
//
//  Created by CC on 15/8/20.
//  Copyright (c) 2015年 PC-1. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel
/**
 *  @author CC, 15-08-20
 *
 *  @brief  检测链接服务器网络是否畅通
 *
 *  @param netConnectBlock  网络状态回调
 *  @param requestURLString 服务器网络地址
 *
 *  @since 1.0
 */
- (void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock
                        RequestURLString: (NSString *) requestURLString
{
    BOOL newState = [CCHTTPRequest netWorkReachabilityWithURLString:requestURLString];
    netConnectBlock(newState);
}

/**
 *  @author CC, 15-08-20
 *
 *  @brief  传入交互的Block块
 *
 *  @param returnBlock   完成响应回调
 *  @param errorBlock    错误响应函数
 *  @param faiilureBlock 超时或者请求失败响应函数
 *
 *  @since <#1.0#>
 */
- (void) responseWithBlock: (Completion) returnBlock
            WithErrorBlock: (ErrorCodeBlock) errorBlock
          WithFailureBlock: (FailureBlock)failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}

/**
 *  @author CC, 15-08-20
 *
 *  @brief  获取数据
 *
 *  @since 1.0
 */
- (void) fetchDataSource
{

}

@end
