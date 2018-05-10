//
//  UIImage+XYImageSize.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYImageSize)
/** 返回一张不超过屏幕尺寸的 image */
+ (UIImage *)XY_imageSizeWithScreenImage:(UIImage *)image;
@end
