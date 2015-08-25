//
//  Conflg.h
//  Conflg
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

#ifndef Remitchat__Config_h
#define Remitchat__Config_h

#pragma mark - 定义全局回调函数
typedef void (^Completion)(id request);

/**
 *  @author CC, 15-08-20
 *
 *  @brief  检测网络状态回调
 *
 *  @param netConnetState 网络是否可用
 *
 *  @since 1.0
 */
typedef void (^NetWorkBlock)(BOOL netConnetState);

/**
 *  @author CC, 2015-07-23
 *
 *  @brief  网络请求完成
 *
 *  @param request <#request description#>
 *
 *  @since 1.0
 */
typedef void (^RequestComplete)(id responseData);

/**
 *  @author CC, 2015-07-23
 *
 *  @brief  错误代码块
 *
 *  @param errorCodeBlock <#errorCodeBlock description#>
 *
 *  @since 1.0
 */
typedef void (^ErrorCodeBlock)(id errorCode);

/**
 *  @author CC, 2015-07-23
 *
 *  @brief  超时或者请求失败
 *
 *  @param failureBlock <#failureBlock description#>
 *
 *  @since 1.0
 */
typedef void (^FailureBlock)(id failure);

/**
 *  @author CC, 2015-07-23
 *
 *  @brief  请求回调相应
 *
 *  @param responseData 相应数据
 *  @param isError      是否有错误
 *
 *  @since 1.0
 */
typedef void (^RequestBlock)(id responseData,bool isError);

/**
 *  @author CC, 15-08-19
 *
 *  @brief  上传下载进度回调
 *
 *  @param bytesRead                读取的字节
 *  @param totalBytesRead           总字节数学
 *  @param totalBytesExpectedToRead 读取字节数
 *
 *  @since <#1.0#>
 */
typedef void (^ProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);

/**
 *  @author CC, 2015-08-13
 *
 *  @brief  对输出日子处理
 *
 *  @param ... <#... description#>
 *
 *  @return <#return value description#>
 *
 *  @since 1.0
 */
#ifdef DEBUG
 #define NSLog(...) NSLog(__VA_ARGS__)
 #define debugMethod() NSLog(@"%s", __func__)
#else
 #define NSLog(...)
 #define debugMethod()
#endif

#pragma mark - 全局变量与方法
/**
 *  @author CC, 2015-08-13
 *
 *  @brief  弱引用对象
 *
 *  @param self 当前页面对象
 *
 *  @return <#return value description#>
 *
 *  @since 1.0
 */
#define WEAKSELF typeof(self) __weak weakSelf = self;

/**
 *  @author CC, 2015-08-13
 *
 *  @brief  强类型弱引用
 *
 *  @param weakSelf 弱引用对象
 *
 *  @return <#return value description#>
 *
 *  @since 1.0
 */
#define STRONGSELF __strong __typeof(weakSelf)strongSelf = weakSelf;

//版本号
#define VersonNumber [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

//设备编号
#define deviceUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

//设备版本号
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//获取屏幕
#define winsize [[UIScreen mainScreen] bounds].size

//获取缓存
#define userDefaults [NSUserDefaults standardUserDefaults]

//设置颜色RGB
#define Color(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//判断字符串
#define CCSafeString(str) (str == nil ? @"" : str)

#define XH_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

// iPad
#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIs_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhone_6 (kIs_iPhone && winsize.height == 667.0)
#define kIs_iPhone_6P (kIs_iPhone && winsize.height == 736.0)

#define kVoiceRecorderTotalTime 60.0

#endif