//
// LTQiNiuMethod.h
// CFCamer
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2020/7/19.
// Copyright © 2020 LTOVE. All rights reserved.
//
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTQiNiuMethod : NSObject
- (NSString *)geiQiNiuThoken;
+ (void)uploadWithData:(NSData *)data
              fileName:( NSString * _Nullable )flieName
       progressHandler:(void(^)(BOOL success,NSString *errDesc,NSString *key,float present))progressHandler
              complete:(void(^)(NSString *key,NSDictionary *resp))complete;
@end

NS_ASSUME_NONNULL_END
