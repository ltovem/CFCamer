//
// LTWebViewController.m
// CFCamer
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2020/7/25.
// Copyright © 2020 LTOVE. All rights reserved.
//
    

#import "LTWebViewController.h"
#import <WebKit/WebKit.h>

@interface LTWebViewController ()
@property (nonatomic,strong)WKWebView *webView;
@end

@implementation LTWebViewController

- (void)loadView{
    WKWebViewConfiguration *confit = [WKWebViewConfiguration new];
    self.webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:confit];
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://blog.ltove.com/"]];
    [self.webView loadRequest:request];
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
