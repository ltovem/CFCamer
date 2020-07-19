//
//  HGHTTPClient.h
//  HGInitiation
//
//  Created by __无邪_ on 2017/12/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

#import "QXHTTPService.h"

FOUNDATION_EXTERN NSString *const HGXAuthToken;
FOUNDATION_EXTERN NSString *const HGXAuthKey;
FOUNDATION_EXTERN NSNotificationName HGShouldLoginNowNotification;

typedef NS_ENUM(NSUInteger, HTTPRequestType) {
    HTTPPOST,
    HTTPGET,
    HTTPDELETE,
};
typedef NS_ENUM(NSUInteger, netWorkType) {
    netWorkTypeUnone = 1 << 0,
    netWorkTypeNoConnect = 1 << 1,
    netWorkTypeCellular = 1 << 2,
    netWorkTypeWifi = 1 << 3,
};
@interface HTTPClient : NSObject
+ (instancetype)sharedInstance;

- (void)clearAllCache;
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
- (NSURLSessionDataTask *)requestWithType:(HTTPRequestType)type
                                   action:(NSString *)action
                                   params:(id)parameters
                                completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)requestWithType:(HTTPRequestType)type
                                   action:(NSString *)action
                                   params:(id)parameters
                              cachePolicy:(QXHTTPRequestCachePolicy)cache completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)upload:(NSString *)urlStr
                            name:(NSString *)fileName
                            type:(NSString *)fileType
                          params:(id)params
                            data:(NSData *)data
                        progress:(HTTPProgressHandler)progress
                       completed:(HTTPResultHandler)completed;

// 上传文件
- (NSURLSessionDataTask *)uploadFile:(NSString *)filePath
                              params:(id)params
                            progress:(HTTPProgressHandler)progress
                           completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)uploadGlobalFile:(NSString *)filePath
                                    params:(id)params
                                  progress:(HTTPProgressHandler)progress
                                 completed:(HTTPResultHandler)completed;
// 下载文件
- (void)fetchVoiceFileWithUrl:(NSString *)url
                    progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                   completed:(HTTPResultHandler)completed;


// 获取上传文件列表
- (NSURLSessionDataTask *)fetchFiles:(NSString *)account completed:(HTTPResultHandler)completed;
// 文件转发
//- (NSURLSessionDataTask *)fileTransfer:(NSString *)targetId name:(NSString *)name size:(NSString *)size url:(NSString *)url completed:(HTTPResultHandler)completed;
// 登录
- (NSURLSessionDataTask *)login:(NSString *)account password:(NSString *)password completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)regist:(NSString *)account password:(NSString *)password captcha:(NSString *)captcha completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)fetchCaptcha:(NSString *)account completed:(HTTPResultHandler)completed;

// 获取用户信息
//- (NSURLSessionDataTask *)fetchUserInfoByStaffNum:(NSString *)staffNum completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)fetchUserInfo:(NSString *)account completed:(HTTPResultHandler)completed;
// 1：App工作台
- (NSURLSessionDataTask *)fetchCarousel:(NSInteger)type completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)fetchLightAppWithcompleted:(HTTPResultHandler)completed;
// 搜索
//- (NSURLSessionDataTask *)searchGlobal:(NSString *)content
//                              deptCode:(NSString *)deptCode//查询的父级部门(没有则不传)
//                               account:(NSString *)account completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)searchGroup:(NSString *)content
                              groupId:(NSString *)groupId
                              account:(NSString *)account
                            completed:(HTTPResultHandler)completed;

- (NSURLSessionDataTask *)checkVersionCompleted:(HTTPResultHandler)completed;

- (NSURLSessionDataTask *)issuedProclamation:(NSDictionary *)params completed:(HTTPResultHandler)completed;

#pragma -- camera

- (NSURLSessionDataTask *)getQiNiuToken:(HTTPResultHandler)completed;

/// 人像分割接口
/// @param name 七牛上传图片名称
/// @param completed 处理结果
- (NSURLSessionDataTask *)getQiNiuDowUrlWithName:(NSString *)name
                                        complete:(HTTPResultHandler)completed;
/// 人像分关键点检测
/// @param name 七牛上传图片名称
/// @param completed 处理结果
- (NSURLSessionDataTask *)bodyPostureWithName:(NSString *)name
                                        complete:(HTTPResultHandler)completed;
@end
