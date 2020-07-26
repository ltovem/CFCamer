//
// LTFaceBodyModel.h
// CFCamer
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2020/7/26.
// Copyright © 2020 LTOVE. All rights reserved.
//
    

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FaceBodySattus) {
    FaceBodySattusShoudler,
    FaceBodySattusEye,
    FaceBodySattusError,
};
NS_ASSUME_NONNULL_BEGIN

@class LTFaceBodyModelBodies;

@interface LTFaceBodyModel : NSObject
@property (nonatomic,strong)NSArray *bodies;
@property (nonatomic,strong)NSNumber *humanCount;
@property (nonatomic,strong)LTFaceBodyModelBodies *right_shoudler;
@property (nonatomic,strong)LTFaceBodyModelBodies *left_shoudler;

@property (nonatomic,strong)LTFaceBodyModelBodies *right_eye;
@property (nonatomic,strong)LTFaceBodyModelBodies *left_eye;

- (FaceBodySattus)getFaceBodyStatus;

@end

@interface LTFaceBodyModelBodies : NSObject
@property (nonatomic,strong)NSNumber *confident;
@property (nonatomic,copy)NSString *label;
@property (nonatomic,strong)NSNumber *points_x;
@property (nonatomic,strong)NSNumber *points_y;
@end

NS_ASSUME_NONNULL_END
