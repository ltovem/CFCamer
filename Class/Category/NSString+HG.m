//
//  NSString+HG.m
//  HGInitiation
//
//  Created by __无邪_ on 2018/1/4.
//  Copyright © 2018年 __无邪_. All rights reserved.
//

#import "NSString+HG.h"

@implementation NSString (HG)

- (NSString *)photoResize:(CGSize)size {
    NSString *targetSize = [NSString stringWithFormat:@"%@x%@",@((NSInteger)size.width),@((NSInteger)size.height)];
    NSArray *paths = [self componentsSeparatedByString:@"."];
    NSString *type = [paths lastObject];
    NSString *preStr = [self substringToIndex:(self.length - type.length - 1)];
    
    return [NSString stringWithFormat:@"%@_%@.%@",preStr,targetSize,type];
}
- (NSString *)hgMD5HexLower {
    return [self md5String];
}
- (NSURL *)url {
    return [NSURL URLWithString:self];
}
- (CGFloat)heightWithFont:(UIFont *)font limitWidth:(CGFloat)width {
    return [self sizeWithFont:font limitSize:CGSizeMake(width, CGFLOAT_MAX)].height;
}
- (CGFloat)widthWithFont:(UIFont *)font limitHeight:(CGFloat)height {
    return [self sizeWithFont:font limitSize:CGSizeMake(height, CGFLOAT_MAX)].width;
}
- (CGSize)sizeWithFont:(UIFont *)font limitSize:(CGSize)size{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:size options:options attributes:attributes context:nil].size;
}
- (CGSize)sizeWithFontSize:(CGFloat)fontSize limitSize:(CGSize)size lineSpace:(CGFloat)space {
    NSDictionary *attributes = [NSString contentAttributesWithFontSize:fontSize lineSpace:space];
    return [self sizeWithLimitSize:size attributes:attributes];
}

- (CGSize)sizeWithLimitSize:(CGSize)size attributes:(NSDictionary *)attributes {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [self boundingRectWithSize:size options:options attributes:attributes context:nil].size;
}

+ (NSDictionary *)contentAttributesWithFontSize:(CGFloat)size lineSpace:(CGFloat)space {
    //参考 http://www.cocoachina.com/ios/20180329/22838.html
    UIFont *font = [UIFont systemFontOfSize:size];
    
    CGFloat lineHeight = font.lineHeight;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;
    paragraphStyle.lineSpacing = space - (font.lineHeight - font.pointSize);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    CGFloat baselineOffset = (lineHeight - font.lineHeight) / 4;
    [attributes setObject:@(baselineOffset) forKey:NSBaselineOffsetAttributeName];
    [attributes setObject:font forKey:NSFontAttributeName];
    
    return [attributes copy];
}



+ (NSString *)unitSymbolTransform:(unsigned long)value {
    double convertedValue = value;
    int multiplyFactor = 0;
    
    NSArray *units = [NSArray arrayWithObjects:@"bytes", @"KB", @"MB", @"GB", @"TB", @"PB", @"EB", @"ZB", @"BB", nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [units objectAtIndex:multiplyFactor]];//达不到最大，无须判断数组会越界
}

+ (NSString *)preferredLanguage {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSArray *allLanguages = [defaults objectForKey:@"AppleLanguages"];
//    NSString *preferredLang = [allLanguages firstObject];
//    return preferredLang;
    NSString *language = [NSLocale preferredLanguages].firstObject;
    return language;
}

+ (NSString *)fileImageNameFromFileName:(NSString *)fileName {
    NSString *type = [fileName fileType];
    
    if ([type containsString:@"pdf"]) {
        return @"file_pdf";
    }else if ([type containsString:@"doc"] || [type containsString:@"pages"]) {
        return @"file_word";
    }else if ([type containsString:@"xls"]) {
        return @"file_xls";
    }else if ([type containsString:@"txt"]) {
        return @"file_txt";
    }else if ([type containsString:@"ppt"]) {
        return @"file_ppt";
    }
    return @"file_unknown";
}

- (NSString *)fileFullName {
    NSString *target = [[self componentsSeparatedByString:@"?"] firstObject];
    return [target lastPathComponent];
}
- (NSString *)fileName {
    NSString *target = [[self componentsSeparatedByString:@"?"] firstObject];
    return [target stringByDeletingPathExtension];
}
- (NSString *)fileType {
    NSString *target = [[self componentsSeparatedByString:@"?"] firstObject];
    return [target pathExtension];
}

//+ (NSString *)generateMsgId {
//    //    46acL-79
//    NSTimeInterval timeStamp = [NSDate timestampNow];
//    return [NSString stringWithFormat:@"%@", @((long)timeStamp)];
//}

- (NSString *)imageUrlWithSize:(CGSize)size {
//    ?imageView2/1/w/300/h/300
    return [NSString stringWithFormat:@"?imageView2/1/w/%@/h/%@",@(size.width),@(size.height)];
}


@end
