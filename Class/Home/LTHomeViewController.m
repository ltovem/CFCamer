//
// LTHomeViewController.m
// CFCamer
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2020/7/8.
// Copyright © 2020 LTOVE. All rights reserved.
//


#import "LTHomeViewController.h"

#import "QDUIKitViewController.h"
#import "LTCameraViewController.h"
#import <QiniuSDK.h>
//#import "LTHTTPService.h"
#import "HTTPClient.h"
#import "LTQiNiuMethod.h"
#import "UIImage+Luban_iOS_Extension_h.h"
#import <TZImagePickerController/TZImagePickerController.h>

#import <QMUIZoomImageView.h>

#import "LTTypingPhoto.h"
#import "LTWebViewController.h"
#import "LTEditPhotoViewController.h"


@interface LTHomeViewController ()<UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,copy)NSString *name;
@end

@implementation LTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.title = @"ddd";
    self.name = @"timg11";
    self.imageView = [[UIImageView alloc]init];
    [self.view addSubview:self.imageView];
    QMUIZoomImageView *view = [[QMUIZoomImageView alloc]init];
    [view.imageView setImage:[UIImage imageNamed:@"56789"]];
    [view showLoading];
    view.frame = self.view.bounds;
    
    
    self.imageView.frame = CGRectMake(0, 0, 400, 500);
    self.imageView.contentMode = UIViewContentModeScaleToFill;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    LTCameraViewController *view = [LTCameraViewController new];
 
    
    LTEditPhotoViewController *webView = [LTEditPhotoViewController new];
    webView.photo = [UIImage imageNamed:@"IMG_0004"];
    [self.navigationController pushViewController:webView animated:YES];
}



@end
