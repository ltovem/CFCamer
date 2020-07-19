//
//  NSString+HG.h
//  HGInitiation
//
//  Created by __无邪_ on 2018/1/4.
//  Copyright © 2018年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HG)

- (CGFloat)heightWithFont:(UIFont *)font limitWidth:(CGFloat)width;
- (CGFloat)widthWithFont:(UIFont *)font limitHeight:(CGFloat)height;

- (CGSize)sizeWithFontSize:(CGFloat)fontSize limitSize:(CGSize)size lineSpace:(CGFloat)space;
- (CGSize)sizeWithLimitSize:(CGSize)size attributes:(NSDictionary *)attributes;
+ (NSDictionary *)contentAttributesWithFontSize:(CGFloat)size lineSpace:(CGFloat)space;

- (NSString *)hgMD5HexLower;
- (NSURL *)url;

- (NSString *)photoResize:(CGSize)size;

+ (NSString *)preferredLanguage;

//    1B(Byte 字节)=8bit，
//　　 1KB (Kilobyte 千字节)=1024B，
//　　 1MB (Megabyte 兆字节 简称“兆”)=1024KB，
//　　 1GB (Gigabyte 吉字节 又称“千兆”)=1024MB，
//　　 1TB (Trillionbyte 万亿字节 太字节)=1024GB，其中1024=2^10 ( 2 的10次方)，
//　　 1PB（Petabyte 千万亿字节 拍字节）=1024TB，
//　　 1EB（Exabyte 百亿亿字节 艾字节）=1024PB，
//　　 1ZB (Zettabyte 十万亿亿字节 泽字节)= 1024 EB,
//　　 1YB (Yottabyte 一亿亿亿字节 尧字节)= 1024 ZB,
//　　 1BB (Brontobyte 一千亿亿亿字节)= 1024 YB.
+ (NSString *)unitSymbolTransform:(unsigned long)value;

+ (NSString *)fileImageNameFromFileName:(NSString *)fileName;
//从路径中获得完整的文件名（带后缀）
- (NSString *)fileFullName;
//获得文件名（不带后缀）
- (NSString *)fileName;
//获得文件的后缀名（不带'.'）
- (NSString *)fileType;

+ (NSString *)generateMsgId;

- (NSString *)imageUrlWithSize:(CGSize)size;

@end
