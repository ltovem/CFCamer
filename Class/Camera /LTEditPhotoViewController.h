//
// LTEditPhotoViewController.h
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
    

#import <UIKit/UIKit.h>
#import "LTTypingPhoto.h"

NS_ASSUME_NONNULL_BEGIN

@interface LTEditPhotoViewController : QMUICommonViewController
@property (nonatomic,strong)UIImage *photo;
@property (nonatomic,assign)LTPhotoType photoSizetype;
@end

NS_ASSUME_NONNULL_END
