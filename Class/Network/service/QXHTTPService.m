//
//  HGDefaultHTTPService.m
//  HGInitiation
//
//  Created by __无邪_ on 2017/12/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//
//#import <YYCache.h>
#import "QXHTTPService.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+HG.h"

@interface QXHTTPService ()
@property(nonatomic, strong)AFHTTPSessionManager *httpManager;
@property(nonatomic, strong)YYCache *cache;

@end

@implementation QXHTTPService

#pragma mark -
- (instancetype)init{
    self = [super init];
    if (self) {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = kHTTPTimeoutIntervalForRequest;
        
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *appVer = infoDic[@"CFBundleShortVersionString"];//CFBundleVersion
        
        self.cache = [YYCache cacheWithName:@"QXHTTPServiceCache"];
        //self.cache.diskCache.ageLimit = kCacheExpiryTimeForHTTPRequest;
        
        self.httpManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        self.httpManager.securityPolicy.validatesDomainName = NO;
        self.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.httpManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"device"];
        [self.httpManager.requestSerializer setValue:appVer forHTTPHeaderField:@"version"];
        self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/javascript",@"text/html",@"*/*", nil];
        ((AFJSONResponseSerializer *)self.httpManager.responseSerializer).removesKeysWithNullValues = YES;
        
    }
    return self;
}



#pragma mark - Public


- (void)clearAllCache {
    [self.cache removeAllObjects];
}
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [self.httpManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString params:(id)parameters completed:(HTTPResultHandler)completed{
    return [self POST:URLString params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completed:completed];
}
- (NSURLSessionDataTask *)GET:(NSString *)URLString params:(id)parameters completed:(HTTPResultHandler)completed{
    return [self GET:URLString params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completed:completed];
}


/// post 请求
- (NSURLSessionDataTask *)POST:(NSString *)URLString params:(id)parameters cachePolicy:(QXHTTPRequestCachePolicy)policy completed:(HTTPResultHandler)completed {
    
    if (policy == QXHTTPRequestReturnCacheDataElseLoad || policy == QXHTTPRequestReturnCacheDataFirst) {
        NSString *key = [self cacheKeyForURL:URLString.url params:parameters];
        id responseData = [self getResponseData:key];
        if (responseData) {
            completed(YES, nil, responseData);
            if (policy == QXHTTPRequestReturnCacheDataElseLoad) {
                return nil;
            }
        }
    }
    
    return [self.httpManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject task:task params:parameters cachePolicy:policy completedHandler:completed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error task:task params:parameters cachePolicy:policy completedHandler:completed];
    }];
    
}
/// get 请求
- (NSURLSessionDataTask *)GET:(NSString *)URLString params:(id)parameters cachePolicy:(QXHTTPRequestCachePolicy)policy completed:(HTTPResultHandler)completed {
    
    if (policy == QXHTTPRequestReturnCacheDataElseLoad || policy == QXHTTPRequestReturnCacheDataFirst) {
        NSString *key = [self cacheKeyForURL:URLString.url params:parameters];
        id responseData = [self getResponseData:key];
        if (responseData) {
            completed(YES, nil, responseData);
            if (policy == QXHTTPRequestReturnCacheDataElseLoad) {
                return nil;
            }
        }
    }
    
    NSMutableDictionary *allparameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    return [self.httpManager GET:URLString parameters:allparameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject task:task params:parameters cachePolicy:policy completedHandler:completed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error task:task params:parameters cachePolicy:policy completedHandler:completed];
    }];
    
}
/// delete 请求
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString params:(id)parameters completed:(HTTPResultHandler)completed{
    return [self.httpManager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject task:task params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completedHandler:completed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error task:task params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completedHandler:completed];
    }];
    
}
/// form 请求
- (NSURLSessionDataTask *)POSTForm:(NSString *)URLString params:(id)parameters completed:(HTTPResultHandler)completed{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    return [self.httpManager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:jsonData name:@"data"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject task:task params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completedHandler:completed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error task:task params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completedHandler:completed];
    }];
}

/// 上传小文件
//- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString
//                            flag:(NSString *)flag
//                            path:(NSString *)filePath
//                          params:(id)parameters
//                        progress:(HTTPProgressHandler)progress
//                       completed:(HTTPResultHandler)completed {
//    return [self.httpManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSString *fileName = [filePath fileFullName];
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:flag fileName:fileName mimeType:@"multipart/form-data" error:nil];
//    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [self handleResponse:responseObject task:task params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completedHandler:completed];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self handleError:error task:task params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completedHandler:completed];
//    }];
//}
- (NSURLSessionDataTask *)UPLOAD:(NSString *)URLString params:(id)parameters file:(NSString *)file data:(NSData *)data name:(NSString *)name type:(NSString *)type progress:(HTTPProgressHandler)progress completed:(HTTPResultHandler)completed {
    NSParameterAssert(type);
    return [self.httpManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *fileName = name;
        if (!fileName) {
            fileName =  [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        }
        fileName = [NSString stringWithFormat:@"%@.%@",fileName,type];
        [formData appendPartWithFileData:data name:file fileName:fileName mimeType:@"multipart/form-data"];
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponse:responseObject task:task params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completedHandler:completed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error task:task params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completedHandler:completed];
    }];
}
- (NSURLSessionDownloadTask *)downloadTaskWithUrl:(NSString *)url
                                             progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                          destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    NSURLRequest *request = [NSURLRequest requestWithURL:url.url];
    return [self.httpManager downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
}


- (void)abort {
    if ([self canAbort]) {
        for (NSURLSessionTask *task in self.httpManager.dataTasks) {
            [task cancel];
        }
    }
}

- (BOOL)canAbort {
    if (self.httpManager.tasks) {
        for (NSURLSessionTask *task in self.httpManager.dataTasks) {
            if (task.state == NSURLSessionTaskStateRunning) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - Deal data methods

- (void)handleResponse:(id)response task:(NSURLSessionDataTask *)task params:(id)parameters cachePolicy:(QXHTTPRequestCachePolicy)policy completedHandler:(HTTPResultHandler)completed{
    completed(YES,@"成功",response);
    return;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = httpResponse.statusCode;
    if (statusCode >= 200 && statusCode < 300 && response) {
        NSString *serverCode = [NSString stringWithFormat:@"%@",response[@"code"]];
        NSString *serverMsg = response[@"msg"];
        if (response && serverCode) {
            if ([serverCode isEqualToString:@"0"]) {
                if (policy == QXHTTPRequestNotUseCachePolicy) {
                    completed(YES,nil,[response[@"data"] copy]);
                }else {
                    NSString *key = [self cacheKeyForURL:task.originalRequest.URL params:parameters];
                    if (policy == QXHTTPRequestReturnCacheDataFirst) {
                        id responseData = [self getResponseData:key];
                        if (responseData == nil || [responseData isEqual:response[@"data"]] == NO) {
                            completed(YES,nil,[response[@"data"] copy]);
                        }
                    }else {
                        completed(YES,nil,[response[@"data"] copy]);
                    }
                    [self store:response[@"data"] key:key];
                }
            }else if ([serverCode isEqualToString:@"1"]) {
                NSLog(@"ERROR: %@",serverMsg);
                completed(NO,serverMsg,nil);
            }else if ([serverCode isEqualToString:@"102"]) {
                NSLog(@"ERROR: %@",serverMsg);
//                 [[NSNotificationCenter defaultCenter] postNotificationName:HGShouldLoginNowNotification object:nil];
                completed(NO,serverMsg,nil);
            }else {
                NSLog(@"ERROR: %@",serverMsg);
                completed(NO,serverMsg,nil);
            }
        }else{
            completed(YES,nil,[response copy]);
        }
    }else{
        completed(NO,[NSHTTPURLResponse localizedStringForStatusCode:statusCode],nil);
    }
    
}
- (void)handleError:(NSError *)Error task:(NSURLSessionDataTask *)task params:(id)parameters cachePolicy:(QXHTTPRequestCachePolicy)policy completedHandler:(HTTPResultHandler)completed{
    NSLog(@"【$$$$ERROR!!】%@",Error);
    if (policy == QXHTTPRequestReturnCacheDataWhenError || policy == QXHTTPRequestReturnCacheDataFirst) {
        NSString *key = [self cacheKeyForURL:task.originalRequest.URL params:parameters];
        id responseData = [self getResponseData:key];
        if (responseData) {
            if (policy == QXHTTPRequestReturnCacheDataWhenError) {
                completed(YES, nil, responseData);
            }
            return;
        }
    }
    completed(NO,Error.localizedDescription,nil);
}



- (NSString *)cacheKeyForURL:(NSURL *)url params:(NSDictionary *)params {
    if (params) {
        NSString *pStr = [params jsonStringEncoded];
        return [url.absoluteString stringByAppendingString:pStr];
    }
    return url.absoluteString;
}
- (void)store:(id)responseData key:(NSString *)key {
    [self.cache setObject:responseData forKey:key];
}
- (id)getResponseData:(NSString *)key {
    return [self.cache objectForKey:key];
}

@end
