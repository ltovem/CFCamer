//
// QMUITips+LTShow.h
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
    

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMUITips (LTShow)
+ (void)showCustomViewTiosWithPreview:(UIView *)preview
                                title:(NSString *)title
                              imfoStr:(NSString * _Nullable)infoStr
                          customImage:(UIImage *)image;
+ (void)showCustomVieWithTitle:(NSString *)title
                          info:(NSString *)info
                       preview:(UIView *)preview;
@end

NS_ASSUME_NONNULL_END
