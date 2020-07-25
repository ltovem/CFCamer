//
// LTProcessPhoto.h
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


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTProcessPhoto : NSObject


/// 使用阿里云去背景
/// @param data -
/// @param fileName -
/// @param failure -
/// @param successResponse -
+ (void)getClearImageWithData:(NSData *)data
                     fileName:(NSString * _Nullable)fileName
                      failure:(void(^)(NSError *_Nullable error))failure
                      success:(void(^)(UIImage * _Nullable image,  NSError * _Nullable error))successResponse;


/// 使用阿里云定位 裁剪图片
/// @param imageData -
/// @param fileName -
/// @param failure -
/// @param successResponse -
+ (void)getClpedImageWithImage:(NSData *)imageData
                      fileName:(NSString *)fileName
                       failure:(void(^)(NSError *_Nullable error))failure
                       success:(void(^)(UIImage * _Nullable image,  NSError * _Nullable error))successResponse;
@end

NS_ASSUME_NONNULL_END
