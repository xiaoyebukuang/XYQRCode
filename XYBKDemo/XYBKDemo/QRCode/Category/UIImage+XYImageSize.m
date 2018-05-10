//
//  UIImage+XYImageSize.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIImage+XYImageSize.h"
#define XYQRCodeScreenWidth  [UIScreen mainScreen].bounds.size.width
#define XYQRCodeScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation UIImage (XYImageSize)
+ (UIImage *)XY_imageSizeWithScreenImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat screenWidth = XYQRCodeScreenWidth;
    CGFloat screenHeight = XYQRCodeScreenHeight;
    if (imageWidth <= screenWidth && imageHeight <= screenHeight) {
        return image;
    }
    CGFloat max = MAX(imageWidth, imageHeight);
    CGFloat scale = max / (screenHeight * 2.0);
    
    CGSize size = CGSizeMake(imageWidth / scale, imageHeight / scale);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
