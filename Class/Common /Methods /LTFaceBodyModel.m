//
// LTFaceBodyModel.m
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
    

#import "LTFaceBodyModel.h"

@implementation LTFaceBodyModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"bodies":@"data.outputs[0].results[0].bodies",
        @"humanCount":@"data.outputs[0].humanCount"
    };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
        @"bodies":@"LTFaceBodyModelBodies",
    };
}

- (void)setBodies:(NSArray *)bodies{
    _bodies = bodies;
    [bodies enumerateObjectsUsingBlock:^(LTFaceBodyModelBodies*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.label isEqualToString:@"left_shoudler"]) {
            self.left_shoudler = obj;
        }else if ([obj.label isEqualToString:@"right_shoudler"]){
            self.right_shoudler = obj;
        }else if ([obj.label  isEqualToString:@"right_eye"]){
            self.right_eye = obj;
        }else if ([obj.label isEqualToString:@"left_eye"]){
            self.left_eye = obj;
        }
    }];
}

- (FaceBodySattus)getFaceBodyStatus{
    if ([self.left_shoudler.confident floatValue] == 0 || [self.left_shoudler.confident floatValue] == 0) {
        if ([self.left_eye.confident floatValue] == 0 || [self.left_eye.confident floatValue] == 0) {
            return FaceBodySattusError;
        }else{
            return FaceBodySattusEye;
        }
    }else{
        return FaceBodySattusShoudler;
    }
}

@end


@implementation LTFaceBodyModelBodies

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"points_x":@"positions[0].points[0]",
        @"points_y":@"positions[0].points[1]"
    };
}

@end
