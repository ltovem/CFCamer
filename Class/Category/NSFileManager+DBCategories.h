//
//  NSFileManager+DBCategories.h
//  QXun_iOS
//
//  Created by __无邪_ on 2018/11/20.
//  Copyright © 2018 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSFileManager (DBCategories)


+ (NSString *)pathGlobalDB;
+ (NSString *)pathMessageDB:(NSString *)userId;

+ (NSString *)pathDocumentUser:(NSString *)userId;
+ (NSString *)pathImage:(NSString *)userId;
+ (NSString *)pathFile:(NSString *)userId;
+ (NSString *)pathVoice:(NSString *)userId;
+ (NSString *)pathDownloadFile:(NSString *)userId;
+ (NSString *)pathDownloadFileList:(NSString *)userId;
+ (NSString *)saveImage2File:(UIImage *)image userId:(NSString *)userId isOriginal:(BOOL)isOriginal;
+ (NSString *)saveImageData2File:(NSData *)imageData isGif:(BOOL)isJif userId:(NSString *)userId;
+ (void)createDirectoryIfNotExistsAtPath:(NSString *)path;


+ (CGSize)imageSize:(NSString *)path;
+ (int64_t)fileSize:(NSString *)path;

+ (BOOL)removeDirectory:(NSString *)path;


+ (NSURL *)documentsURL;
+ (NSString *)documentsPath;


+ (NSURL *)libraryURL;
+ (NSString *)libraryPath;


+ (NSURL *)cachesURL;
+ (NSString *)cachesPath;


+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path;

+ (double)availableDiskSpace;

@end
