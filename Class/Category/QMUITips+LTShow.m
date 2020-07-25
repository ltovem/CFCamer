//
// QMUITips+LTShow.m
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


#import "QMUITips+LTShow.h"
#import "QDCustomToastAnimator.h"
#import "QDCustomToastContentView.h"

@implementation QMUITips (LTShow)

+ (void)showCustomVieWithTitle:(NSString *)title info:(NSString *)info preview:(nonnull UIView *)preview{
    [QMUITips hideAllTips];
    [QMUITips showCustomViewTiosWithPreview:preview title:title imfoStr:info customImage:UIImageMake(@"image0")];
}

+ (void)showCustomViewTiosWithPreview:(UIView *)preview title:(NSString *)title imfoStr:(NSString *)infoStr customImage:(UIImage *)image{
    QMUITips *tips = [QMUITips createTipsToView:preview];
    tips.toastPosition = QMUIToastViewPositionTop;
    QDCustomToastAnimator *customAnimator = [[QDCustomToastAnimator alloc] initWithToastView:tips];
    tips.toastAnimator = customAnimator;
    QDCustomToastContentView *customContentView = [[QDCustomToastContentView alloc] init];
    [customContentView renderWithImage:UIImageMake(@"image0") text:title detailText:infoStr];
    tips.contentView = customContentView;
    [tips showAnimated:YES];
    [tips hideAnimated:YES afterDelay:4];
    
}

@end
