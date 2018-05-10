//
//  QRCodeScanningVC.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "QRCodeScanningVC.h"
#import "QRCode.h"
@interface QRCodeScanningVC ()<QRCodeScanManagerDelegate, QRCodeAlbumManagerDelegate>
/** 二维码扫描 */
@property (nonatomic, strong) QRCodeScanManager *manager;
/** 二维码扫描框 */
@property (nonatomic, strong) QRCodeScanningView *scanningView;
@end

@implementation QRCodeScanningVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [self.manager startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"晓爷扫一扫";
    //扫描框
    [self.view addSubview:self.scanningView];
    [self.scanningView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self setupQRCodeScanning];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
}
- (void)rightBarButtonItenAction {
    QRCodeAlbumManager *manager = [QRCodeAlbumManager sharedManager];
    [manager readQRCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
}
//扫描管理
- (void)setupQRCodeScanning {
    self.manager = [QRCodeScanManager sharedManager];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [self.manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:nil currentController:self];
    [self.manager cancelSampleBufferDelegate];
    self.manager.delegate = self;
}
//数据清除
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}
- (void)dealloc {
    NSLog(@"WBQRCodeScanningVC - dealloc");
    [self removeScanningView];
}
#pragma mark - - - QRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManager:(QRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    NSLog(@"%@",result);
}
- (void)QRCodeAlbumManagerDidReadQRCodeFailure:(QRCodeAlbumManager *)albumManager {
    NSLog(@"暂未识别出二维码");
}

- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(QRCodeAlbumManager *)albumManager {
    
}

#pragma mark - - - QRCodeScanManagerDelegate
- (void)QRCodeScanManager:(QRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager playSoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager stopRunning];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"%@",[obj stringValue]);
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}
#pragma mark -- setup
- (QRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[QRCodeScanningView alloc] init];
        _scanningView.cornerColor = [UIColor orangeColor];
    }
    return _scanningView;
}

@end
