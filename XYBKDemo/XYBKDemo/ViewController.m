//
//  ViewController.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ViewController.h"

#import "QRCodeGenerateVC.h"
#import "QRCodeScanningVC.h"
#import "AVCaptureTool.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, strong) NSArray *dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.dataList = @[@"生成二维码", @"WBQRCode (popVC 逻辑处理）", @"WCQRCode (popToRootVC 逻辑处理)"];
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark -- UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        QRCodeGenerateVC *VC = [[QRCodeGenerateVC alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 1) {
        QRCodeScanningVC *VC = [[QRCodeScanningVC alloc]init];
        [self QRCodeScanVC:VC];
    }
//    if (indexPath.row == 2) {
//        WCQRCodeScanningVC *WCVC = [[WCQRCodeScanningVC alloc] init];
//        [self QRCodeScanVC:WCVC];
//    }
}
- (void)QRCodeScanVC:(UIViewController *)scanVC {
    [AVCaptureTool checkCameraAuthorizedWithController:self withAuthorizedBlock:^{
        [self.navigationController pushViewController:scanVC animated:YES];
    }];
}
#pragma mark -- setup
- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [[UITableView alloc] init];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.rowHeight = 40;
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableV registerClass:[UITableViewCell class]
             forCellReuseIdentifier:@"cell"];
    }
    return _tableV;
}
@end
