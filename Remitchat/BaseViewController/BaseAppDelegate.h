//
//  BaseAppDelegate.h
//
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
#import "CCDropzone.h"

@interface BaseAppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) Reachability * reach;

////飘窗
//@property (strong,nonatomic) CCDropzone *dropZone;

/**
 *  @author CC, 2015-07-30
 *
 *  @brief  动画消失启动页
 *
 *  @since 1.0
 */
- (void)AnimationStartPage;

/**
 *  @author CC, 15-08-21
 *
 *  @brief  引导页
 *
 *  @since <#1.0#>
 */
- (void)initguidePages;

/**
 *  @author CC, 15-08-21
 *
 *  @brief  启动进入主窗口
 *
 *  @since 1.0
 */
- (void) startViewController;

@end
