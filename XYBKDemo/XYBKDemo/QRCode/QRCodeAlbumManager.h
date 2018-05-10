//
//  QRCodeAlbumManager.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QRCodeAlbumManager;

@protocol QRCodeAlbumManagerDelegate <NSObject>

@required
/** 图片选择控制器取消按钮的点击回调方法 */
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(QRCodeAlbumManager *)albumManager;
/** 图片选择控制器读取图片二维码信息成功的回调方法 (result: 获取的二维码数据) */
- (void)QRCodeAlbumManager:(QRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result;
/** 图片选择控制器读取图片二维码信息失败的回调函数 */
- (void)QRCodeAlbumManagerDidReadQRCodeFailure:(QRCodeAlbumManager *)albumManager;
@end

@interface QRCodeAlbumManager : NSObject

/** 快速创建单利方法 */
+ (instancetype)sharedManager;
/** SGQRCodeAlbumManagerDelegate */
@property (nonatomic, weak) id<QRCodeAlbumManagerDelegate> delegate;

/** 从相册中读取二维码方法，必须实现的方法 */
- (void)readQRCodeFromAlbumWithCurrentController:(UIViewController *)currentController;

@end
