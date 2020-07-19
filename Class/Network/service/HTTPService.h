//
//  HGHTTPService.h
//  HGInitiation
//
//  Created by __无邪_ on 2017/12/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 使用cache策略
 0，不使用缓存
 1，有缓存读取缓存数据，无缓存请求数据并缓存
 2，网络请求失败时才加载缓存
 3，先加载本地数据，再请求网络数据
 */

typedef NS_ENUM(NSUInteger, QXHTTPRequestCachePolicy) {
    QXHTTPRequestNotUseCachePolicy,
    QXHTTPRequestReturnCacheDataElseLoad,
    QXHTTPRequestReturnCacheDataWhenError,
    QXHTTPRequestReturnCacheDataFirst,
};

@protocol QXHTTPService

typedef void (^HTTPResultHandler)(BOOL success, NSString *errDesc, id responseData);
typedef void (^HTTPProgressHandler)(NSProgress *progress);

// 清除缓存数据
- (void)clearAllCache;
// Sets the value for the HTTP headers set in request objects made by the HTTP client.
// If `nil`, removes the existing value for that header.
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/// POST 请求
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                        params:(id)parameters
                     completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                        params:(id)parameters
                   cachePolicy:(QXHTTPRequestCachePolicy)policy completed:(HTTPResultHandler)completed;
/// GET 请求
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       params:(id)parameters
                    completed:(HTTPResultHandler)completed;
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                       params:(id)parameters
                  cachePolicy:(QXHTTPRequestCachePolicy)policy completed:(HTTPResultHandler)completed;
/// DELETE 请求
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                          params:(id)parameters
                       completed:(HTTPResultHandler)completed;
/// FORM 请求
- (NSURLSessionDataTask *)POSTForm:(NSString *)URLString
                            params:(id)parameters
                         completed:(HTTPResultHandler)completed;
/// 上传小文件

- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString
                          params:(id)parameters
                            file:(NSString *)file //服务端标识eg:file
                            data:(NSData *)data   //要上传的数据
                            name:(NSString *)name //上传文件名称 如果不存在会自动生成一个
                            type:(NSString *)type //上传文件类型eg:jpg
                        progress:(HTTPProgressHandler)progress
                       completed:(HTTPResultHandler)completed;

/// 上传文件
- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString
                            flag:(NSString *)flag //服务端标识eg:file
                            path:(NSString *)filePath
                          params:(id)parameters
                        progress:(HTTPProgressHandler)progress
                       completed:(HTTPResultHandler)completed;

- (NSURLSessionDownloadTask *)downloadTaskWithUrl:(NSString *)url
                                         progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                      destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

- (void)abort;

@end
