//
//  HGHTTPClient.m
//  HGInitiation
//
//  Created by __无邪_ on 2017/12/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

#import "HTTPClient.h"

NSString *const HGXAuthToken = @"appToken";
NSString *const HGXAuthKey = @"appKey";
NSNotificationName HGShouldLoginNowNotification = @"HGShouldLoginNowNotification";



@interface HTTPClient ()
@property (nonatomic, strong) id<QXHTTPService> service;
@end

@implementation HTTPClient

- (NSURLSessionDataTask *)fetchEmojies:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service GET:[self urlGithub:@"emojis"] params:nil completed:completed];
    return dataTask;
}

#pragma mark - LOGIN
- (NSURLSessionDataTask *)login:(NSString *)account password:(NSString *)password completed:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service POST:[self urlDefault:@"authentication"]
                                                 params:@{@"loginCode":account,@"password":password}
                                              completed:completed];
    return dataTask;
}
- (NSURLSessionDataTask *)regist:(NSString *)account password:(NSString *)password captcha:(NSString *)captcha completed:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service POST:[self urlDefault:@"user/register"]
                                                 params:@{@"username":account,@"password":password,@"name":captcha}
                                              completed:completed];
    return dataTask;
}
- (NSURLSessionDataTask *)fetchCaptcha:(NSString *)account completed:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service GET:[self urlGithub:@"emojis"] params:nil completed:completed];
    return dataTask;
}

#pragma mark -

//- (NSURLSessionDataTask *)fetchUserInfoByStaffNum:(NSString *)staffNum completed:(HTTPResultHandler)completed {
//    NSURLSessionDataTask *dataTask = [self.service POST:[self urlDefault:@"user/getContactsMsg"] params:@{@"userCode":QXCurrentUser.shared.refCode,@"contacts":SafeStr(staffNum)} cachePolicy:QXHTTPRequestReturnCacheDataFirst completed:completed];
//    return dataTask;
//}
- (NSURLSessionDataTask *)fetchUserInfo:(NSString *)account completed:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service POST:[self urlDefault:@"user/queryUserMsg"] params:@{@"loginId":account} completed:completed];
    return dataTask;
}
- (NSURLSessionDataTask *)fetchCarousel:(NSInteger)type completed:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service GET:[self urlDefault:[NSString stringWithFormat:@"truns/pics/%@",@(type)]] params:nil cachePolicy:QXHTTPRequestReturnCacheDataFirst completed:completed];
    return dataTask;
}
- (NSURLSessionDataTask *)fetchLightAppWithcompleted:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service GET:[self urlDefault:[NSString stringWithFormat:@"lightApp"]] params:nil cachePolicy:QXHTTPRequestReturnCacheDataFirst completed:completed];
    return dataTask;
}

//- (NSURLSessionDataTask *)searchGlobal:(NSString *)content deptCode:(NSString *)deptCode account:(NSString *)account completed:(HTTPResultHandler)completed {
//    NSDictionary *params = @{@"queryCriteria":content,@"account":SafeStr(account)};
//    if (deptCode) {
//        params = @{@"queryCriteria":content,@"deptCode":deptCode,@"account":SafeStr(account)};
//    }
//    NSURLSessionDataTask *dataTask = [self.service POST:[self urlDefault:@"dept/searchDeptAndPeopleMsg"] params:params completed:completed];
//    return dataTask;
//}
- (NSURLSessionDataTask *)searchGroup:(NSString *)content groupId:(NSString *)groupId account:(NSString *)account completed:(HTTPResultHandler)completed {
    NSDictionary *params = @{@"queryCriteria":content,@"groupId":groupId,@"loginId":account};
    NSURLSessionDataTask *dataTask = [self.service POST:[self urlDefault:@"group/groupSearch"] params:params completed:completed];
    return dataTask;
}
- (NSURLSessionDataTask *)checkVersionCompleted:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service GET:[self urlDefault:@"update"] params:nil completed:completed];
    return dataTask;
}
- (NSURLSessionDataTask *)issuedProclamation:(NSDictionary *)params completed:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service POST:[self urlDefault:@"qx/qxNotify/save"] params:params completed:completed];
    return dataTask;
}

#pragma mark -

- (void)clearAllCache {
    [self.service clearAllCache];
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [self.service setValue:value forHTTPHeaderField:field];
}

- (NSURLSessionDataTask *)requestWithType:(HTTPRequestType)type action:(NSString *)action params:(id)parameters
              completed:(HTTPResultHandler)completed {
    return [self requestWithType:type action:action params:parameters cachePolicy:QXHTTPRequestNotUseCachePolicy completed:completed];
}
- (NSURLSessionDataTask *)requestWithType:(HTTPRequestType)type
                                   action:(NSString *)action
                                   params:(id)parameters
                              cachePolicy:(QXHTTPRequestCachePolicy)cache completed:(HTTPResultHandler)completed {
    switch (type) {
        case HTTPPOST:
            return [self.service POST:[self urlDefault:action] params:parameters cachePolicy:cache completed:completed];
        case HTTPGET:
            return [self.service GET:[self urlDefault:action] params:parameters cachePolicy:cache completed:completed];
        case HTTPDELETE:
            return [self.service DELETE:[self urlDefault:action] params:parameters completed:completed];
        default:
            break;
    }
    return nil;
}

#pragma mark - upload

// 上传文件
- (NSURLSessionDataTask *)upload:(NSString *)urlStr
                            name:(NSString *)fileName
                            type:(NSString *)fileType
                          params:(id)params
                            data:(NSData *)data
                        progress:(HTTPProgressHandler)progress
                       completed:(HTTPResultHandler)completed {
    return [self.service UPLOAD:[self urlDefault:urlStr] params:params file:@"file" data:data name:fileName type:fileType progress:progress completed:completed];
}

// 上传文件
- (NSURLSessionDataTask *)uploadFile:(NSString *)filePath params:(id)params progress:(HTTPProgressHandler)progress completed:(HTTPResultHandler)completed {
    return [self.service UPLOAD:[self urlDefault:@"upload/uploadFile"] flag:@"file" path:filePath params:params progress:progress completed:completed];
}
- (NSURLSessionDataTask *)uploadGlobalFile:(NSString *)filePath params:(id)params progress:(HTTPProgressHandler)progress completed:(HTTPResultHandler)completed {
    return [self.service UPLOAD:[self urlDefault:@"qx/qxNotify/upload"] flag:@"file" path:filePath params:params progress:progress completed:completed];
}
// 下载文件
//- (void)fetchVoiceFileWithUrl:(NSString *)url
//                     progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
//                    completed:(HTTPResultHandler)completed {
//    //判断一下文件是否存在，如果存在直接返回
//    NSString *path = [[NSFileManager pathVoice:QXCurrentUser.shared.account] stringByAppendingPathComponent:[url fileFullName]];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
//        completed(YES,nil,[url fileFullName]);
//        return;
//    }
//
//    [[self.service downloadTaskWithUrl:url progress:downloadProgressBlock destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        return [NSURL fileURLWithPath:path];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        if (completed) {
//            if (error) {
//                completed(NO,error.localizedDescription,nil);
//            }else{
//                completed(YES,nil,[url fileFullName]);
//            }
//        }
//    }] resume];
//}

- (NSURLSessionDataTask *)fetchFiles:(NSString *)account completed:(HTTPResultHandler)completed {
    NSURLSessionDataTask *dataTask = [self.service POST:[self urlDefault:@"upload/getReceiveFile"] params:@{@"loginId":account} completed:completed];
    return dataTask;
}
//- (NSURLSessionDataTask *)fileTransfer:(NSString *)targetId name:(NSString *)name size:(NSString *)size url:(NSString *)url completed:(HTTPResultHandler)completed {
//    NSURLSessionDataTask *dataTask = [self.service POST:[self urlDefault:@"upload/inputFileLog"] params:@{@"receiveRefcode":targetId,@"sendRefcode":QXCurrentUser.shared.refCode,@"fileName":name,@"fileSize":size,@"fileUrl":url} completed:completed];
//    return dataTask;
//}
//upload/inputFileLog



- (NSURLSessionDataTask *)getQiNiuToken:(HTTPResultHandler)completed{
    return [self.service GET:[self urlDefault:@"qiniu"] params:nil completed:completed];
}
- (NSURLSessionDataTask *)getQiNiuDowUrlWithName:(NSString *)name complete:(HTTPResultHandler)completed{
    return [self GETMethodWithAction:@"segmentBody" param:@{@"name":name} complete:completed];
}
- (NSURLSessionDataTask *)bodyPostureWithName:(NSString *)name complete:(HTTPResultHandler)completed{
    return [self GETMethodWithAction:@"bodyPosture" param:@{@"name":name} complete:completed];
}
- (NSURLSessionDataTask *)GETMethodWithAction:(NSString *)action
                                      param:(NSDictionary * _Nullable )param
                                   complete:(HTTPResultHandler)completed{
    return [self.service GET:[self urlDefault:action] params:param completed:completed];
}

#pragma mark - BASE URL

- (NSString *)urlDefault:(NSString *)target {
    return [NSString stringWithFormat:@"%@%@",BASE_API_URL,target];
}
- (NSString *)urlGithub:(NSString *)target {
    return [NSString stringWithFormat:@"%@%@",BASE_API_URL,target];
}

#pragma mark - SHARED INSTANCE
+ (instancetype)sharedInstance{
    static HTTPClient *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTTPClient alloc] init];
        manager.service = [[QXHTTPService alloc] init];
    });
    return manager;
}
@end
