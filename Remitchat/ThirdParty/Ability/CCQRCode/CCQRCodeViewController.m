//
//  CCQRCodeViewController.m
//  Remitchat
//
//  Created by CC on 15/8/18.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "CCQRCodeViewController.h"
#import "CCCaptureHelper.h"
#import "CCVideoOutputSampleBufferFactory.h"
#import "CCScanningView.h"
#import "CCFoundationCommon.h"
#import "UIButton+CCButtonTitlePosition.h"
#import "CCCameraViewController.h"

#define kCCScanningButtonPadding 36

@interface CCQRCodeViewController ()

@property (nonatomic, strong) UIView *preview;

@property (nonatomic, strong) CCScanningView *scanningView;

@property (nonatomic, strong) UIView *buttonContainerView;
@property (nonatomic, strong) UIButton *scanQRCodeButton;
@property (nonatomic, strong) UIButton *scanBookButton;
@property (nonatomic, strong) UIButton *scanStreetButton;
@property (nonatomic, strong) UIButton *scanWordButton;

@property (nonatomic, strong) CCCaptureHelper *captureHelper;

@end

@implementation CCQRCodeViewController

#pragma mark - Action

- (void)scanButtonClicked:(UIButton *)sender {
    self.scanQRCodeButton.selected = (sender == self.scanQRCodeButton);
    self.scanBookButton.selected = (sender == self.scanBookButton);
    self.scanStreetButton.selected = (sender == self.scanStreetButton);
    self.scanWordButton.selected = (sender == self.scanWordButton);

    [self.scanningView transformScanningTypeWithStyle:sender.tag];
}

#pragma mark - Propertys

- (UIButton *)createButton {
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(scanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIView *)preview {
    if (!_preview) {
        _preview = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _preview;
}

- (CCScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[CCScanningView alloc] initWithFrame:CGRectMake(0, (CURRENT_SYS_VERSION >= 7.0 ? 0 : 0), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - (CURRENT_SYS_VERSION >= 7.0 ? 0 : 44))];
    }
    return _scanningView;
}

- (UIView *)buttonContainerView {
    if (!_buttonContainerView) {
        _buttonContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 120 - [CCFoundationCommon getAdapterHeight], CGRectGetWidth(self.view.bounds), 62)];
        _buttonContainerView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];

        [_buttonContainerView addSubview:self.scanQRCodeButton];
        [_buttonContainerView addSubview:self.scanBookButton];
        [_buttonContainerView addSubview:self.scanStreetButton];
        [_buttonContainerView addSubview:self.scanWordButton];
    }
    return _buttonContainerView;
}
- (UIButton *)scanQRCodeButton {
    if (!_scanQRCodeButton) {
        _scanQRCodeButton = [self createButton];
        _scanQRCodeButton.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - kCCScanningButtonPadding * 1.5 - 35 * 2, 8, 35, CGRectGetHeight(self.buttonContainerView.bounds) - 16);
        _scanQRCodeButton.tag = 0;
        [_scanQRCodeButton setImage:[UIImage imageNamed:@"ScanQRCode"] forState:UIControlStateNormal];
        [_scanQRCodeButton setImage:[UIImage imageNamed:@"ScanQRCode_HL"] forState:UIControlStateSelected];
        _scanQRCodeButton.selected = YES;
        [_scanQRCodeButton setTitle:@"扫码" forState:UIControlStateNormal];
        [_scanQRCodeButton setTitlePositionWithType:CCButtonTitlePostionTypeBottom];
    }
    return _scanQRCodeButton;
}
- (UIButton *)scanBookButton {
    if (!_scanBookButton) {
        _scanBookButton = [self createButton];
        CGRect scanBookButtonFrame = self.scanQRCodeButton.frame;
        scanBookButtonFrame.origin.x += kCCScanningButtonPadding + CGRectGetWidth(self.scanQRCodeButton.bounds);
        _scanBookButton.frame = scanBookButtonFrame;
        _scanBookButton.tag = 1;
        [_scanBookButton setImage:[UIImage imageNamed:@"ScanBook"] forState:UIControlStateNormal];
        [_scanBookButton setImage:[UIImage imageNamed:@"ScanBook_HL"] forState:UIControlStateSelected];
        [_scanBookButton setTitle:@"封面" forState:UIControlStateNormal];
        [_scanBookButton setTitlePositionWithType:CCButtonTitlePostionTypeBottom];
    }
    return _scanBookButton;
}
- (UIButton *)scanStreetButton {
    if (!_scanStreetButton) {
        _scanStreetButton = [self createButton];
        CGRect scanBookButtonFrame = self.scanBookButton.frame;
        scanBookButtonFrame.origin.x += kCCScanningButtonPadding + CGRectGetWidth(self.scanQRCodeButton.bounds);
        _scanStreetButton.frame = scanBookButtonFrame;
        _scanStreetButton.tag = 2;
        [_scanStreetButton setImage:[UIImage imageNamed:@"ScanStreet"] forState:UIControlStateNormal];
        [_scanStreetButton setImage:[UIImage imageNamed:@"ScanStreet_HL"] forState:UIControlStateSelected];
        [_scanStreetButton setTitle:@"街景" forState:UIControlStateNormal];
        [_scanStreetButton setTitlePositionWithType:CCButtonTitlePostionTypeBottom];
    }
    return _scanStreetButton;
}
- (UIButton *)scanWordButton {
    if (!_scanWordButton) {
        _scanWordButton = [self createButton];
        CGRect scanBookButtonFrame = self.scanStreetButton.frame;
        scanBookButtonFrame.origin.x += kCCScanningButtonPadding + CGRectGetWidth(self.scanQRCodeButton.bounds);
        _scanWordButton.frame = scanBookButtonFrame;
        _scanWordButton.tag = 3;
        [_scanWordButton setImage:[UIImage imageNamed:@"ScanWord"] forState:UIControlStateNormal];
        [_scanWordButton setImage:[UIImage imageNamed:@"ScanWord_HL"] forState:UIControlStateSelected];
        [_scanWordButton setTitle:@"翻译" forState:UIControlStateNormal];
        [_scanWordButton setTitlePositionWithType:CCButtonTitlePostionTypeBottom];
    }
    return _scanWordButton;
}

- (CCCaptureHelper *)captureHelper {
    if (!_captureHelper) {
        _captureHelper = [[CCCaptureHelper alloc] init];
        [_captureHelper setDidOutputSampleBufferHandle:^(CMSampleBufferRef sampleBuffer) {
            // 这里可以做子线程的QRCode识别
            NSLog(@"image : %@", [CCVideoOutputSampleBufferFactory imageFromSampleBuffer:sampleBuffer]);
        }];
    }
    return _captureHelper;
}

#pragma mark - Life Cycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.captureHelper showCaptureOnView:self.preview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedStringFromTable(@"Scanning", @"MessageDisplayKitString", @"扫一扫");

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleBordered target:self action:@selector(showPhotoLibray)];

    self.view.backgroundColor = [UIColor grayColor];

    [self.view addSubview:self.preview];

    [self.view addSubview:self.scanningView];
    [self.view addSubview:self.buttonContainerView];
}

- (void)showPhotoLibray {
    [[CCCameraViewController alloc] startPhotoFileWithViewController:self complate:^(id request) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.captureHelper = nil;
    self.scanningView = nil;
}

@end
