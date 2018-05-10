//
//  AVCaptureTool.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVCaptureTool : NSObject



/**
 相机权限

 @param controller 跳转弹框视图
 @param block 权限回调
 */
+ (void)checkCameraAuthorizedWithController:(UIViewController *)controller withAuthorizedBlock:(void(^)(void))block;


/**
 相册权限

 @param controller 跳转弹框视图
 @param block 权限回调
 */
+ (void)checkPhotoAuthorizedWithController:(UIViewController *)controller withAuthorizedBlock:(void(^)(void))block;

@end
