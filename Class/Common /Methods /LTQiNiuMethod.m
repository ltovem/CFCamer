//
// LTQiNiuMethod.m
// CFCamer
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2020/7/19.
// Copyright © 2020 LTOVE. All rights reserved.
//
    

#import "LTQiNiuMethod.h"
#import "HTTPClient.h"
#import <Qiniu/QiniuSDK.h>

@implementation LTQiNiuMethod


- (NSString *)geiQiNiuThoken{
    
    
    
    __block NSString *token = @"";
    
    
    
    return token;
}
+ (void)uploadWithData:(NSData *)data
              fileName:( NSString * _Nullable )flieName
       progressHandler:(void(^)(BOOL success,NSString *errDesc,NSString *key,float present))progressHandler
              complete:(void(^)(NSString *key,NSDictionary *resp))complete
{
    [HTTPClient.sharedInstance getQiNiuToken:^(BOOL success, NSString *errDesc, id responseData) {
        if (success) {
            NSString *token = responseData[@"token"];
            NSLog(@"%@======",token);
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
                
            //    QNUploadManager *upManager = [[QNUploadManager alloc] init];
                QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
//                    NSLog(@"上传进度percent == %.2f", percent);
                    progressHandler(YES,@"",key,percent);
                }
                                                                             params:nil
                                                                           checkCrc:NO
                                                                 cancellationSignal:nil];
                
                
                [upManager putData:data key:flieName token:token
                complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                NSLog(@"%@", info);
//                NSLog(@"%@", resp);
                    complete(key,resp);
                } option:uploadOption];
        }else{
            progressHandler(NO,errDesc,nil,0);
        }
    }];
    
}
@end
