//
//  QRCodeAlbumManager.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "QRCodeAlbumManager.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+XYImageSize.h"
#import "AVCaptureTool.h"

#ifdef DEBUG
#define XYQRCodeLog(...) NSLog(__VA_ARGS__)
#else
#define XYQRCodeLog(...)
#endif

@interface QRCodeAlbumManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) UIViewController *currentVC;
@end

@implementation QRCodeAlbumManager
+ (instancetype)sharedManager {
    static QRCodeAlbumManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QRCodeAlbumManager alloc] init];
    });
    return manager;
}

- (void)readQRCodeFromAlbumWithCurrentController:(UIViewController *)currentController {
    self.currentVC = currentController;
    if (currentController == nil) {
        @throw [NSException exceptionWithName:@"SGQRCode" reason:@"readQRCodeFromAlbumWithCurrentController: 方法中的 currentController 参数不能为空" userInfo:nil];
    }
    [AVCaptureTool checkPhotoAuthorizedWithController:self.currentVC withAuthorizedBlock:^{
        [self enterImagePickerController];
    }];
}

// 进入 UIImagePickerController
- (void)enterImagePickerController {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - - - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.currentVC dismissViewControllerAnimated:YES completion:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeAlbumManagerDidCancelWithImagePickerController:)]) {
        [self.delegate QRCodeAlbumManagerDidCancelWithImagePickerController:self];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // 对选取照片的处理，如果选取的图片尺寸过大，则压缩选取图片，否则不作处理
    UIImage *image = [UIImage XY_imageSizeWithScreenImage:info[UIImagePickerControllerOriginalImage]];
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
    // 声明一个 CIDetector，并设定识别类型 CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    if (features.count == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeAlbumManagerDidReadQRCodeFailure:)]) {
            [self.delegate QRCodeAlbumManagerDidReadQRCodeFailure:self];
        }
        [self.currentVC dismissViewControllerAnimated:YES completion:nil];
        return;
    } else {
        NSString *resultStr = @"";
        for (int index = 0; index < [features count]; index ++) {
            CIQRCodeFeature *feature = [features objectAtIndex:index];
            resultStr = feature.messageString;
        }
        [self.currentVC dismissViewControllerAnimated:YES completion:^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeAlbumManager:didFinishPickingMediaWithResult:)]) {
                [self.delegate QRCodeAlbumManager:self didFinishPickingMediaWithResult:resultStr];
            }
        }];
    }
}
@end
