//
//  QRCodeGenerateManager.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/3.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCodeGenerateManager : NSObject

/**
 生成一张普通的二维码

 @param urlStr 地址
 @param length 边长
 @return 二维码
 */
+ (UIImage *)generateWithDefaultQRCodeUrlStr:(NSString *)urlStr imageViewSideLength:(CGFloat)length;

/**
 生成一张带有logo的二维码

 @param urlStr 二维码地址
 @param logoImageName logo地址
 @param logoScaleToSuperView 相对于父视图的缩放比例取值范围：0-1，0不显示，1与父视图大小相同
 @return 二维码
 */
+ (UIImage *)generateWithDefaultQRCodeUrlStr:(NSString *)urlStr logoImageName:(NSString *)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView;

/**
 生成一张彩色的二维码

 @param urlStr 二维码地址
 @param backgroundColor 背景颜色
 @param mainColor 二维码颜色
 @return 二维码图片
 */
+ (UIImage *)generateWithDefaultQRCodeUrlStr:(NSString *)urlStr backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;




@end
