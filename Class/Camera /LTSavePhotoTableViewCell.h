//
// LTSavePhotoTableViewCell.h
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
    

#import <QMUIKit/QMUIKit.h>
@class LTSavePhotoCellModel;
NS_ASSUME_NONNULL_BEGIN

@interface LTSavePhotoTableViewCell : QMUITableViewCell
@property (nonatomic,strong)LTSavePhotoCellModel *Model;
@end

NS_ASSUME_NONNULL_END
