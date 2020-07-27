//
// LTSavePhotoCellModel.h
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

typedef NS_ENUM(NSUInteger, PhotoColorType) {
    PhotoColorTypeWhite,
    PhotoColorTypeBlue,
    PhotoColorTypeRead,
};

NS_ASSUME_NONNULL_BEGIN

@interface LTSavePhotoCellModel : NSObject

@property (nonatomic,strong)UIImage *photo;

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subtitle;
@property (nonatomic,assign)BOOL isSelect;
@property (nonatomic,assign)CGFloat price;

+ (instancetype)initWithPhoto:(UIImage *)photo
                        price:(CGFloat)price
                    photoType:(PhotoColorType )type;


@end

@interface LTSavePhotoTypingCellModel : LTSavePhotoCellModel

@end

NS_ASSUME_NONNULL_END
