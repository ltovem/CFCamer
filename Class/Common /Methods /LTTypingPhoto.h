//
// LTTypingPhoto.h
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

typedef NS_ENUM(NSUInteger, LTPhotoType) {
    LTPhotoTypeNomal1,
    LTPhotoTypeNomal2,
    LTPhotoTypeSmall1,
    LTPhotoTypeSmall2,
    LTPhotoTypeBig1,
    LTPhotoTypeBig2,
    LTPhotoTypeDriver,
    LTPhotoTypeStudentIdCard,
    LTPhotoTypeUSASing,
    
};
typedef NS_ENUM(NSUInteger, LTTypingType) {
    LTTypingTypeV,
    LTTypingTypeH,
    
};

NS_ASSUME_NONNULL_BEGIN

@interface LTTypingPhoto : NSObject
+ (void)typeingWithPhoto:(UIImage *)photo
               photoType:(LTPhotoType)type
                   typedImage:(void(^)(UIImage *typedImage))typed;

+ (UIImage *)drawWatherWithImage:(UIImage *)image
                       watherSte:(NSString *)str;

+ (UIImage *)typeingWithPhoto:(UIImage *)photo
                    photoType:(LTPhotoType)type;
@end

NS_ASSUME_NONNULL_END
