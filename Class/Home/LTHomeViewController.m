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


@interface LTHomeViewController ()

@end

@implementation LTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.title = @"ddd";
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LTCameraViewController *view = [LTCameraViewController new];
//    QDUIKitViewController *view = [QDUIKitViewController new];
    view.title = @"haha";
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:view animated:YES];
//    [view setModalPresentationStyle:UIModalPresentationOverFullScreen];
//    [self presentViewController:view animated:YES completion:nil];
    
//    NSString *token = @"Iq7fn4u5EwlcBMhCYpj2n1KocCukSfRUBB2vr9gU:ImdyTCRheRdtZc5BWKR3TYiFKTA=:eyJzY29wZSI6InB1YmxpY2x0b3ZlIiwiZGVhZGxpbmUiOjE1OTUxNjgwOTd9";
//    UIImage *image = [UIImage imageNamed:@"homebannerinface"];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    QNUploadManager *upManager = [[QNUploadManager alloc] init];
//
////    QNUploadManager *upManager = [[QNUploadManager alloc] init];
//    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
//        NSLog(@"上传进度percent == %.2f", percent);
//    }
//                                                                 params:nil
//                                                               checkCrc:NO
//                                                     cancellationSignal:nil];
//
//    NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
//    [upManager putData:imageData key:@"homebannerinface.jpg" token:token
//    complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//    NSLog(@"%@", info);
//    NSLog(@"%@", resp);
//    } option:uploadOption];
     
//    [HTTPClient.sharedInstance getQiNiuToken:^(BOOL success, NSString *errDesc, id responseData) {
//        NSLog(@"%@",responseData);
//    }];
//    LTQiNiuMethod *qi = [LTQiNiuMethod new];
//    NSString *tokens = [qi geiQiNiuThoken];
//    NSLog(@"%@>>>>>>>>",tokens);
    
    UIImage *image = [UIImage imageNamed:@"segmentimage-src-hu"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [LTQiNiuMethod uploadWithData:imageData fileName:[NSString stringWithFormat:@"%u9999--9.jpg",arc4random()] progressHandler:^(BOOL success, NSString * _Nonnull errDesc, NSString * _Nonnull key, float present) {
        NSLog(@"上传进度percent == %.2f", present);
    } complete:^(NSString * _Nonnull key, NSDictionary * _Nonnull resp) {
        NSLog(@"%@", resp);
        [HTTPClient.sharedInstance getQiNiuDowUrlWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
            NSLog(@"%@========>>>>>>>>>====",responseData);
        }];
        
        //关键点检测
//        [HTTPClient.sharedInstance bodyPostureWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
//            NSLog(@"人像处理结果  ：：：%@========>>>>>>>>>====",[responseData mj_JSONString]);
//        }];
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
