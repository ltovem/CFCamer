//
// LTSavePhotoViewController.h
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
#import "LTTypingPhoto.h"

typedef NS_ENUM(NSUInteger, ExportPageType) {
    ExportPageTypePhoto,
    ExportPageTypeTypingPhoto,
};

NS_ASSUME_NONNULL_BEGIN

@interface LTSavePhotoViewController : QMUICommonTableViewController

@property (nonatomic,strong)UIImage *photo;
@property (nonatomic,assign)ExportPageType photoType;
@property (nonatomic,assign)LTPhotoType photoSizeType;
@end

NS_ASSUME_NONNULL_END
