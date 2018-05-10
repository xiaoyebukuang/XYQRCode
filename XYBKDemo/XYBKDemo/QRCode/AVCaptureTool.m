//
//  AVCaptureTool.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "AVCaptureTool.h"
#import <AVFoundation/AVFoundation.h>
#import "UIAlertViewTool.h"
#import <Photos/Photos.h>
@implementation AVCaptureTool

+ (void)checkCameraAuthorizedWithController:(UIViewController *)controller withAuthorizedBlock:(void(^)(void))block {
    //获取相机
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        //相机权限
        AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (AVstatus) {
            case AVAuthorizationStatusAuthorized:
                //经授权的
                block();
                break;
            case AVAuthorizationStatusDenied:
            {
                //拒绝的
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                // app名称
                NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                NSString *title = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - 相机 - %@]打开访问开关",app_Name];
                [UIAlertViewTool showAlertViewControllerWithTitle:@"温馨提示" withAlertMessage:title withViewController:controller withCompletionBlock:^{
                    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
                        [[UIApplication sharedApplication] openURL:settingsURL];
                    }
                }];
            }
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                //未确定的
                //获取相机权限
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        //同意权限
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            block();
                        });
                    }else{
                        //拒绝权限
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
            }
                break;
            case AVAuthorizationStatusRestricted:
                //限制的
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            default:
                break;
        }
    } else {
        //没有摄像头
        [UIAlertViewTool showAlertViewControllerWithTitle:@"温馨提示" withAlertMessage:@"未检测到您的摄像头" withViewController:controller withCompletionBlock:^{
        }];
    }
}

+ (void)checkPhotoAuthorizedWithController:(UIViewController *)controller withAuthorizedBlock:(void(^)(void))block {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        switch (status) {
            case PHAuthorizationStatusAuthorized:
                //经授权的
                block();
                break;
            case PHAuthorizationStatusDenied:
            {
                //拒绝的
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                // app名称
                NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                NSString *title = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - 照片 - %@]打开访问开关",app_Name];
                [UIAlertViewTool showAlertViewControllerWithTitle:@"温馨提示" withAlertMessage:title withViewController:controller withCompletionBlock:^{
                    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
                        [[UIApplication sharedApplication] openURL:settingsURL];
                    }
                }];
            }
                break;
            case PHAuthorizationStatusNotDetermined:
                {
                    //获取相册权限
                    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                        if (status == PHAuthorizationStatusAuthorized) {
                            //同意权限
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                block();
                            });
                        }else{
                            //拒绝权限
                            NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                        }
                    }];
                }
                break;
            case PHAuthorizationStatusRestricted:
                //限制的
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            default:
                break;
        }
    }
}
@end
