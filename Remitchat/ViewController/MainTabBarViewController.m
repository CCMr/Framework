//
//  MainTabBarViewController.m
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

#import "MainTabBarViewController.h"
#import "BaseNavigationController.h"

#import "CCMessageRootViewController.h"
#import "ContactViewController.h"
#import "ForumViewController.h"
#import "FindViewController.h"
#import "ProfileViewController.h"

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self InitTabBar];
}

#pragma mark - 初始化选项卡
-(void)InitTabBar{
    BaseNavigationController *remitchat = [[BaseNavigationController alloc] initWithRootViewController:[[CCMessageRootViewController alloc] init] title:@"汇信" SelImage:[UIImage imageNamed:@"WeChat"] Image:[UIImage imageNamed:@"WeChat"] Tag:1];

    BaseNavigationController *contact = [[BaseNavigationController alloc] initWithRootViewController:[[ContactViewController alloc] init] title:@"通讯录" SelImage:[UIImage imageNamed:@"WeChat"] Image:[UIImage imageNamed:@"WeChat"] Tag:2];

     BaseNavigationController *forum = [[BaseNavigationController alloc] initWithRootViewController:[[ForumViewController alloc] init] title:@"论坛" SelImage:[UIImage imageNamed:@"WeChat"] Image:[UIImage imageNamed:@"WeChat"] Tag:3];

     BaseNavigationController *find = [[BaseNavigationController alloc] initWithRootViewController:[[FindViewController alloc] init] title:@"发现" SelImage:[UIImage imageNamed:@"WeChat"] Image:[UIImage imageNamed:@"WeChat"] Tag:4];

     BaseNavigationController *profile = [[BaseNavigationController alloc] initWithRootViewController:[[ProfileViewController alloc] init] title:@"我" SelImage:[UIImage imageNamed:@"WeChat"] Image:[UIImage imageNamed:@"WeChat"] Tag:5];

    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbarBkg"];
    self.viewControllers = [NSArray arrayWithObjects:remitchat,contact,forum,find,profile, nil];

}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
