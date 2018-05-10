//
//  QRCodeGenerateVC.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/3.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "QRCodeGenerateVC.h"
#import "QRCodeGenerateManager.h"
@interface QRCodeGenerateVC ()

@end

@implementation QRCodeGenerateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 生成二维码(Default)
    [self setupGenerateQRCode];
    
    // 生成二维码(中间带有图标)
    [self setupGenerate_Icon_QRCode];

    // 生成二维码(彩色)
    [self setupGenerate_Color_QRCode];
}
// 生成二维码
- (void)setupGenerateQRCode {
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 150;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    CGFloat imageViewY = 80;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:imageView];
    
    // 2、将CIImage转换成UIImage，并放大显示
    imageView.image = [QRCodeGenerateManager generateWithDefaultQRCodeUrlStr:@"https://blog.csdn.net/xiaoxiaobukuang" imageViewSideLength:imageViewW];
    
#pragma mark - - - 模仿支付宝二维码样式（添加用户头像）
    CGFloat scale = 0.22;
    CGFloat borderW = 5;
    UIView *borderView = [[UIView alloc] init];
    CGFloat borderViewW = imageViewW * scale;
    CGFloat borderViewH = imageViewH * scale;
    CGFloat borderViewX = 0.5 * (imageViewW - borderViewW);
    CGFloat borderViewY = 0.5 * (imageViewH - borderViewH);
    borderView.frame = CGRectMake(borderViewX, borderViewY, borderViewW, borderViewH);
    borderView.layer.borderWidth = borderW;
    borderView.layer.borderColor = [UIColor purpleColor].CGColor;
    borderView.layer.cornerRadius = 10;
    borderView.layer.masksToBounds = YES;
    borderView.layer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    [imageView addSubview:borderView];
}
#pragma mark - - - 中间带有图标二维码生成
- (void)setupGenerate_Icon_QRCode {
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 150;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    CGFloat imageViewY = 240;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:imageView];
    CGFloat scale = 0.2;
    // 2、将最终合得的图片显示在UIImageView上
    imageView.image = [QRCodeGenerateManager generateWithDefaultQRCodeUrlStr:@"https://blog.csdn.net/xiaoxiaobukuang" logoImageName:@"logo" logoScaleToSuperView:scale];
}
#pragma mark - - - 彩色图标二维码生成
- (void)setupGenerate_Color_QRCode {
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 150;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    CGFloat imageViewY = 400;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:imageView];
    
    // 2、将二维码显示在UIImageView上
    imageView.image = [QRCodeGenerateManager generateWithDefaultQRCodeUrlStr:@"https://blog.csdn.net/xiaoxiaobukuang" backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8] mainColor:[CIColor colorWithRed:0.3 green:0.2 blue:0.4]];
}
@end