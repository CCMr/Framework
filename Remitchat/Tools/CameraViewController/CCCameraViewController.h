//
//  CCCameraViewController.h
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

#import <UIKit/UIKit.h>

@interface CCCameraViewController : UIViewController

/**
 *  @author CC, 2015-07-23
 *
 *  @brief  启动相机或照片文件视图控制器
 *
 *  @param viewController <#viewController description#>
 *  @param complate       <#complate description#>
 *
 *  @since 1.0
 */
- (void)startCameraOrPhotoFileWithViewController:(UIViewController *)viewController
                                        complate:(Completion)complate;

/**
 *  @author CC, 15-08-19
 *
 *  @brief  启动相机试图控制器
 *
 *  @param viewController <#viewController description#>
 *  @param complate       <#complate description#>
 *
 *  @since <#1.0#>
 */
- (void)startCcameraWithViewController:(UIViewController *)viewController
                              complate:(Completion)complate;

/**
 *  @author CC, 15-08-19
 *
 *  @brief  启动照片文件夹试图
 *
 *  @param viewController <#viewController description#>
 *  @param complate       <#complate description#>
 *
 *  @since <#1.0#>
 */
- (void)startPhotoFileWithViewController:(UIViewController *)viewController
                                complate:(Completion)complate;

@end
