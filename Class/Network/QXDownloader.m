//
//  HGDownloadManager.m
//  HGInitiation
//
//  Created by __无邪_ on 2018/3/27.
//  Copyright © 2018年 __无邪_. All rights reserved.
//

#import "QXDownloader.h"
#import <AFNetworking/AFNetworking.h>

NSString *const HGDownloadCompletedUnitCount = @"HGDownloadCompletedUnitCount";
NSString *const HGDownloadTotalUnitCount = @"HGDownloadTotalUnitCount";

@interface QXDownloader()
@property(nonatomic, strong) AFHTTPSessionManager *httpManager;
@property(nonatomic, strong) NSMutableDictionary *tasks;
@property(nonatomic, strong) NSMutableDictionary *totalBytes;
@property(nonatomic, copy) HGDownloadProgressHandler progressHandler;
@property(nonatomic, copy) HGDownloadCompletedHandler completedHandler;

@end

@implementation QXDownloader


- (instancetype)initWithIdentifier:(NSString *)identifier allowsCellularAccess:(BOOL)allowsCellularAccess progress:(HGDownloadProgressHandler)progress completed:(HGDownloadCompletedHandler)completed {
    
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifier];
        configuration.timeoutIntervalForRequest = DBL_MAX;
        self.httpManager = [AFHTTPSessionManager.alloc initWithSessionConfiguration:configuration];
        self.httpManager.requestSerializer.allowsCellularAccess = allowsCellularAccess;
        self.tasks = [NSMutableDictionary.alloc init];
        self.totalBytes = [NSMutableDictionary.alloc init];
        self.completedHandler = completed;
        self.progressHandler = progress;
    }
    return self;
}

// see: https://forums.developer.apple.com/thread/14854

- (void)setDidFinishEventsForBackgroundURLSessionBlock:(void (^)(NSURLSession *session))block {
    [self.httpManager setDidFinishEventsForBackgroundURLSessionBlock:block];
}

#pragma mark -

// 开始、恢复下载
- (void)startDownloadWithURL:(NSURL *)url {
    
    NSURLSessionDownloadTask *downloadTask;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadData:) name:AFNetworkingTaskDidCompleteNotification object:downloadTask];
    
    __weak typeof(self) weakSelf = self;
    
    NSString *key = [self cacheKeyForURL:url];
    NSString *path = [NSFileManager pathFile:QXCurrentUser.shared.account];
    path = [path stringByAppendingPathComponent:url.lastPathComponent];
    NSURL *target = [NSURL fileURLWithPath:path];
    
    void (^downloadProgressBlock)(NSProgress *downloadProgress) = ^(NSProgress *downloadProgress) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.totalBytes[key] = [NSString stringWithFormat:@"%@/%@",@(downloadProgress.completedUnitCount),@(downloadProgress.totalUnitCount)];
        strongSelf.progressHandler(url,downloadProgress);
    };
    void (^completionHandler)(NSURLResponse *response, NSURL *filePath, NSError *error) = ^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (error) {
            if (![error.userInfo objectForKey:NSURLSessionDownloadTaskResumeData]) {
                NSLog(@"------下载失败");
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:key];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [strongSelf removeDownloadTaskForKey:key];
                [strongSelf startDownloadWithURL:url];
            }else {
                NSLog(@"----------下载暂停成功");
            }
        }else{
            strongSelf.completedHandler(strongSelf,url,filePath);
            [strongSelf removeDownloadTaskForKey:key];
        }
    };
    NSData *resumeData = [self resumeDataForKey:key];
    if (resumeData) {
        [self.httpManager setDownloadTaskDidFinishDownloadingBlock:^NSURL * _Nullable(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, NSURL * _Nonnull location) {
            return target;
        }];
        downloadTask = [self.httpManager downloadTaskWithResumeData:resumeData progress:downloadProgressBlock destination:nil completionHandler:completionHandler];
    }else {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        downloadTask = [self.httpManager downloadTaskWithRequest:request progress:downloadProgressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return target;
        } completionHandler:completionHandler];
    }
    
    self.tasks[key] = downloadTask;
    [downloadTask resume];
    
}

// 暂停下载
- (void)stopDownloadWithURL:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    NSURLSessionDownloadTask *downloadTask = [self downloadTaskForKey:key];
    __weak typeof(self) weakSelf = self;
    if (downloadTask.state == NSURLSessionTaskStateRunning) {
        [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf saveResumeData:resumeData forKey:key];
        }];
    }
}

- (void)pauseWorkImmediately {
    for (NSString *key in self.tasks.allKeys) {
        NSURLSessionDownloadTask *downloadTask = self.tasks[key];
        if (downloadTask.state == NSURLSessionTaskStateRunning) {
            [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                NSLog(@"----save");
                [self saveResumeData:resumeData forKey:key];
            }];
        }
    }
}
- (BOOL)isRunning:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    NSURLSessionDownloadTask *downloadTask = [self downloadTaskForKey:key];
    if (downloadTask && downloadTask.state == NSURLSessionTaskStateRunning) {
        return YES;
    }
    return NO;
}

// 获取本地已下载信息
- (NSDictionary *)localDownloadInfoForURL:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    NSData *data = [self resumeDataForKey:key];
    if (!data || [data length] < 1) return nil;
    NSError *error;
    NSDictionary *resumeDictionary = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:&error];
    if (!resumeDictionary || error) return nil;
    return resumeDictionary;
}

- (NSURLSessionDownloadTask *)downloadTaskForKey:(NSString *)key {
    return self.tasks[key];
}
- (void)removeDownloadTaskForKey:(NSString *)key {
    [self.tasks removeObjectForKey:key];
}
- (void)saveResumeData:(NSData *)data forKey:(NSString *)key {
    if (![self isValidResumeData:data]) {
        return;
    }
    NSDictionary *resumeDictionary = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:nil];
    NSString *progressInfo = self.totalBytes[key];
    NSMutableDictionary *resumeMutableDic = [NSMutableDictionary.alloc initWithDictionary:resumeDictionary];
    if (progressInfo) {
        NSArray *items = [progressInfo componentsSeparatedByString:@"/"];
        [resumeMutableDic setValue:[items firstObject] forKey:HGDownloadCompletedUnitCount];
        [resumeMutableDic setValue:[items lastObject] forKey:HGDownloadTotalUnitCount];
    }
    NSData *resumeData = [NSPropertyListSerialization dataWithPropertyList:resumeMutableDic format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:resumeData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSData *)resumeDataForKey:(NSString *)key {
    NSData *resumeData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([self isValidResumeData:resumeData]) {
        return resumeData;
    }
    return nil;
}

- (void)downloadData:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSURLSessionDownloadTask class]]) {
        NSError *err = [notification.userInfo objectForKey:AFNetworkingTaskDidCompleteErrorKey];
        if (err) {
            NSData *resumeData = err.userInfo[@"NSURLSessionDownloadTaskResumeData"];
            if (resumeData) {
                NSLog(@"---ResumeData");
            }
        }
    }
}

#pragma mark - Private

- (BOOL)isValidResumeData:(NSData *)data{
    if (!data || [data length] < 1) return NO;
    
    NSError *error;
    NSDictionary *resumeDictionary = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:&error];
    if (!resumeDictionary || error) return NO;
    
    return YES;
}

- (NSString *)cacheKeyForURL:(NSURL *)url {
    if (!url) { return nil; }
    return [url.absoluteString hgMD5HexLower];
}


@end



NSString *const HGDownloaderDefaultIdentifier = @"HGDownloaderDefaultIdentifier";
NSNotificationName const HGNotificationDefaultDownloadProgress = @"HGNotificationDefaultDownloadProgress";
NSNotificationName const HGNotificationDefaultDownloadDone = @"HGNotificationDefaultDownloadDone";


@implementation QXDownloader (Default)

#pragma mark - SHARED INSTANCE

+ (instancetype)defaultInstance{
    static QXDownloader *downloader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloader = [[QXDownloader alloc] initWithIdentifier:HGDownloaderDefaultIdentifier allowsCellularAccess:YES progress:^(NSURL *url, NSProgress *progress) {
            [[NSNotificationCenter defaultCenter] postNotificationName:HGNotificationDefaultDownloadProgress object:@{@"url":url,@"prg":progress}];
        } completed:^(QXDownloader *downloader, NSURL *url, NSURL *location) {
            [[NSNotificationCenter defaultCenter] postNotificationName:HGNotificationDefaultDownloadDone object:@{@"url":url,@"loc":location.absoluteString}];
        }];
    });
    return downloader;
}

@end
