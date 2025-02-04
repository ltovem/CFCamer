//
//  UIImage+Luban_iOS_Extension_h.h
//  Luban-iOS
//
//  Created by guo on 2017/7/20.
//  Copyright © 2017年 guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Luban_iOS_Extension_h)

+ (NSData *)lubanCompressImage:(UIImage *)image;
+ (NSData *)lubanCompressImage:(UIImage *)image withMask:(NSString *)maskName;
+ (NSData *)lubanCompressImage:(UIImage *)image withCustomImage:(NSString *)imageName;
+ (UIImage *)lubangetCompressImage:(UIImage *)image withMask:(NSString *)maskName;

/// 更换背景颜色
/// @param image image
/// @param color color
+ (UIImage *)coverImageWithImage:(UIImage *)image
                           color:(UIColor *)color;
@end
