//
// LTCameraViewController.m
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
    

#import "LTCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface LTCameraViewController ()

@property (nonatomic,strong)UIView *bottomView;

@end

@implementation LTCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"cammera";
    self.view.layer.backgroundColor = [UIColor redColor].CGColor;
    // Do any additional setup after loading the view.
    [self setupUi];
}

- (void)setupUi{
    self.bottomView = [self addBottomView];
    
    
    [self.view addSubview:_bottomView];
}

- (UIView *)addBottomView{
    UIView *bottom = [UIView new];
    
    bottom.backgroundColor = [UIColor yellowColor];
    return bottom;
}

- (void)viewWillLayoutSubviews{
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.equalTo(@80);
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

- (void)dealloc{
    NSLog(@"sss");
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
@end
