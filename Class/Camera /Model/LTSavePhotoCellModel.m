//
// LTSavePhotoCellModel.m
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
    

#import "LTSavePhotoCellModel.h"

@implementation LTSavePhotoCellModel

+ (instancetype)initWithPhoto:(UIImage *)photo photoType:(PhotoColorType)type{
    LTSavePhotoCellModel *model = [LTSavePhotoCellModel new];
    model.photo = photo;
    switch (type) {
        case PhotoColorTypeWhite:
            {
                model.title = @"高清白底照片";
                model.subtitle = @"价格 :3元";
            }
            break;
        case PhotoColorTypeBlue:
        {
            model.title = @"高清蓝底照片";
            model.subtitle = @"价格 :3元";
        }
        break;
        case PhotoColorTypeRead:
        {
            model.title = @"高清红底底照片";
            model.subtitle = @"价格 :3元";
        }
        break;
            
        default:
            break;
    }
    return model;
}

@end
