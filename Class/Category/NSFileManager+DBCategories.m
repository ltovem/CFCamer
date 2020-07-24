//
//  NSFileManager+DBCategories.m
//  QXun_iOS
//
//  Created by __无邪_ on 2018/11/20.
//  Copyright © 2018 __无邪_. All rights reserved.
//

// https://developer.apple.com/icloud/documentation/data-storage/index.html
/*
 Overview
 iCloud includes Backup, which automatically backs up a user’s iOS device daily over Wi-Fi. Everything in your app’s home directory is backed up, with the exception of the application bundle itself, the caches directory, and temp directory. Purchased music, apps, books, the Camera Roll, device settings, home screen and app organization, messages, and ringtones are backed up as well. Because backups are done wirelessly and stored in iCloud for each user, it’s best to minimize the amount of data that’s stored for your app. Large files will lengthen the time it takes to perform a backup and consume more of a user’s available iCloud storage.
 
 Storing Your App’s Data Efficiently
 To ensure that backups are as efficient as possible, store your app’s data according to the following guidelines:
 
 Only documents and other data that is user-generated, or that cannot otherwise be recreated by your application, should be stored in the <Application_Home>/Documents directory and will be automatically backed up by iCloud.
 Data that can be downloaded again or regenerated should be stored in the <Application_Home>/Library/Caches directory. Examples of files you should put in the Caches directory include database cache files and downloadable content, such as that used by magazine, newspaper, and map applications.
 Data that is used only temporarily should be stored in the <Application_Home>/tmp directory. Although these files are not backed up to iCloud, remember to delete those files when you are done with them so that they do not continue to consume space on the user’s device.
 Use the "do not back up" attribute for specifying files that should remain on device, even in low storage situations. Use this attribute with data that can be recreated but needs to persist even in low storage situations for proper functioning of your app or because customers expect it to be available during offline use. This attribute works on marked files regardless of what directory they are in, including the Documents directory. These files will not be purged and will not be included in the user's iCloud or iTunes backup. Because these files do use on-device storage space, your app is responsible for monitoring and purging these files periodically.
*/

/*
 1.Documents:只有用户生成的文件、其他数据及其他程序不能重新创建的文件，应该保存在/Documents目录下面，并将通过iCloud自动备份。
 2.Library:可以重新下载或者重新生成的数据应该保存在/Library /caches目录下面。举个例子，比如杂志、新闻、地图应用使用的数据库缓存文件和可下载内容应该保存到这个文件夹。
 3.tmp:只是临时使用的数据应该保存在/ tmp 文件夹，tmp目录不是你程序退出的时候就清空，是在你内存不足的情况系统会给你清空，看是网络缓存的数据还是本地存储的，如果本地存储你可以放在doc目录。尽管iCloud不会备份这些文件，但在应用使用完这些数据之后要注意随时删除，避免占用用户设备的空间。
 */

// 此app中
// 文件保存在document下
// 数据保存在library下


#import "NSFileManager+DBCategories.h"

@implementation NSFileManager (DBCategories)

+ (NSString *)pathDocumentUser:(NSString *)userId {
    if (userId.length == 0) {
        userId = @"visitor";
    }
    return [NSString stringWithFormat:@"%@/User/%@",[self documentsPath],userId];
}
+ (NSString *)pathLibraryUser:(NSString *)userId {
    if (userId.length == 0) {
        userId = @"visitor";
    }
    return [NSString stringWithFormat:@"%@/User/%@",[self libraryPath],userId];
}
+ (NSString *)pathGlobalDB {
    NSString *path = [NSString stringWithFormat:@"%@/User/Global",[self libraryPath]];
    [self createDirectoryIfNotExistsAtPath:path];
    return path;
}
+ (NSString *)pathMessageDB:(NSString *)userId {
    NSString *path = [[self pathLibraryUser:userId] stringByAppendingPathComponent:@"DB"];
    [self createDirectoryIfNotExistsAtPath:path];
    return path;
}
+ (NSString *)pathImage:(NSString *)userId {
    NSString *path = [[self pathDocumentUser:userId] stringByAppendingPathComponent:@"Image"];
    [self createDirectoryIfNotExistsAtPath:path];
    return path;
}
+ (NSString *)pathFile:(NSString *)userId {
    NSString *path = [[self pathDocumentUser:userId] stringByAppendingPathComponent:@"File"];
    [self createDirectoryIfNotExistsAtPath:path];
    return path;
}
+ (NSString *)pathDownloadFile:(NSString *)userId {
    NSString *path = [[self pathDocumentUser:userId] stringByAppendingPathComponent:@"DownloadFile"];
    [self createDirectoryIfNotExistsAtPath:path];
    return path;
}
+ (NSString *)pathDownloadFileList:(NSString *)userId {
    NSString *path = [[self pathDocumentUser:userId] stringByAppendingPathComponent:@"DownloadFileList"];
    [self createDirectoryIfNotExistsAtPath:path];
    return path;
}
+ (NSString *)pathVoice:(NSString *)userId {
    return [self pathFile:userId];
}
+ (void)createDirectoryIfNotExistsAtPath:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
}
+ (NSString *)saveImage2File:(UIImage *)image userId:(NSString *)userId isOriginal:(BOOL)isOriginal {
    NSData *imageData;
    if (isOriginal) {
        imageData = UIImageJPEGRepresentation(image,0.5);
    }else {
        imageData = UIImageJPEGRepresentation(image, 0.3);
    }
    return [self saveImageData2File:imageData isGif:NO userId:userId];
}
+ (NSString *)saveImageData2File:(NSData *)imageData isGif:(BOOL)isGif userId:(NSString *)userId {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tmpDir = [self pathImage:userId];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.jpg",tmpDir,@([[NSDate date] timeIntervalSince1970])];
    if (isGif) {
        filePath = [NSString stringWithFormat:@"%@/%@.gif",tmpDir,@([[NSDate date] timeIntervalSince1970])];
    }
    [fileManager createDirectoryAtPath:tmpDir withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:filePath contents:imageData attributes:nil];
    return filePath;
}
+ (CGSize)imageSize:(NSString *)path {
    
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:path],NULL);
    CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0,NULL);
    NSNumber *pixelWidthObj = (__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
    NSNumber *pixelHeightObj = (__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
    NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
    NSNumber *temp = @0;
    switch (orientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored: {
            temp = pixelWidthObj;
            pixelWidthObj = pixelHeightObj;
            pixelHeightObj = temp;
            break;
        }
        default:
            break;
    }
    CFRelease(imageProperties);
    CFRelease(imageSourceRef);
    return CGSizeMake(pixelWidthObj.floatValue, pixelHeightObj.floatValue);
}
+ (int64_t)fileSize:(NSString *)path {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if([fileManager fileExistsAtPath:path]){
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:path error:nil];
        NSNumber *num = [attributes objectForKey:NSFileSize];
        return num.longLongValue;
    }
    return 0;
}


+ (BOOL)removeDirectory:(NSString *)path {
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}




+ (NSURL *)URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)documentsURL
{
    return [self URLForDirectory:NSDocumentDirectory];
}
+ (NSString *)documentsPath
{
    return [self pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)libraryURL
{
    return [self URLForDirectory:NSLibraryDirectory];
}
+ (NSString *)libraryPath
{
    return [self pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)cachesURL
{
    return [self URLForDirectory:NSCachesDirectory];
}

+ (NSString *)cachesPath
{
    return [self pathForDirectory:NSCachesDirectory];
}

+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}


@end
