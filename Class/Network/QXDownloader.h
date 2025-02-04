//
//  HGDownloadManager.h
//  HGInitiation
//
//  Created by __无邪_ on 2018/3/27.
//  Copyright © 2018年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QXDownloader;


extern NSString *const HGDownloadCompletedUnitCount;
extern NSString *const HGDownloadTotalUnitCount;

typedef void (^HGDownloadProgressHandler)(NSURL *url,NSProgress *progress);
typedef void (^HGDownloadCompletedHandler)(QXDownloader *downloader, NSURL *url, NSURL *location);


/* 此类只能用于一般下载，当用户手动关闭app时，会导致下载信息无法保存，进而无法从退出app那个时恢复下载
*/

@interface QXDownloader : NSObject

/* 设置后台session
*/
- (void)setDidFinishEventsForBackgroundURLSessionBlock:(void (^)(NSURLSession *session))block;

- (instancetype)initWithIdentifier:(NSString *)identifier
              allowsCellularAccess:(BOOL)allowsCellularAccess
                          progress:(HGDownloadProgressHandler)progress completed:(HGDownloadCompletedHandler)completed;

/* 开始或者恢复
*/
- (void)startDownloadWithURL:(NSURL *)url;

/* 暂停
*/
- (void)stopDownloadWithURL:(NSURL *)url;

/* 本地已下载文件信息
*/
- (NSDictionary *)localDownloadInfoForURL:(NSURL *)url;

/* 立即停止并保存下载信息
*/
- (void)pauseWorkImmediately;

- (BOOL)isRunning:(NSURL *)url;

@end

/// 默认下载实例

extern NSString *const HGDownloaderDefaultIdentifier;
extern NSNotificationName const HGNotificationDefaultDownloadProgress;
extern NSNotificationName const HGNotificationDefaultDownloadDone;

@interface QXDownloader (Default)

+ (instancetype)defaultInstance;

@end





