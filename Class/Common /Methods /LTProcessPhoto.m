//
// LTProcessPhoto.m
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
    

#import "LTProcessPhoto.h"
#import "LTQiNiuMethod.h"
#import "HTTPClient.h"

@implementation LTProcessPhoto


+ (void)getClearImageWithData:(NSData *)data
                     fileName:(NSString * _Nullable)fileName
                      failure:(void(^)(NSError *_Nullable error))failure
                      success:(void(^)(UIImage * _Nullable image,  NSError * _Nullable error))successResponse
{
    [LTQiNiuMethod uploadWithData:data fileName:fileName progressHandler:^(BOOL success, NSString * _Nonnull errDesc, NSString * _Nonnull key, float present) {
        NSLog(@"上传进度percent == %.2f", present);
    } complete:^(NSString * _Nonnull key, NSDictionary * _Nonnull resp) {
        NSLog(@"%@", resp);
        if (resp ==nil) {
            failure(nil);
            return;
        }
        [HTTPClient.sharedInstance getQiNiuDowUrlWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
            
            NSString *url = responseData[@"data"][@"imageURL"];
            SDWebImageDownloader *download = [SDWebImageDownloader sharedDownloader];
            [download downloadImageWithURL:[url mj_url] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                successResponse(image,error);
            }];
        }];
        
    }];
}

@end
