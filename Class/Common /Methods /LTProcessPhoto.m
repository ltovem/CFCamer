//
// LTProcessPhoto.m
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


#import "LTProcessPhoto.h"
#import "LTQiNiuMethod.h"
#import "HTTPClient.h"
#import "LTFaceBodyModel.h"

@implementation LTProcessPhoto


+ (void)getClearImageWithData:(NSData *)data
                     fileName:(NSString * _Nullable)fileName
                      failure:(void(^)(NSError *_Nullable error))failure
                      success:(void(^)(UIImage * _Nullable image,  NSError * _Nullable error))successResponse
{
    [LTQiNiuMethod uploadWithData:data fileName:fileName progressHandler:^(BOOL success, NSString * _Nonnull errDesc, NSString * _Nonnull key, float present) {
        NSLog(@"上传进度percent == %.2f", present);
    } complete:^(NSString * _Nonnull key, NSDictionary * _Nonnull resp) {
        NSLog(@"%@", resp);
        if (resp ==nil) {
            failure(nil);
            return;
        }
        [HTTPClient.sharedInstance getQiNiuDowUrlWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
            
            NSString *url = responseData[@"data"][@"imageURL"];
            SDWebImageDownloader *download = [SDWebImageDownloader sharedDownloader];
            [download downloadImageWithURL:[url mj_url] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                successResponse(image,error);
            }];
        }];
        
    }];
}


+ (void)getClpedImageWithImage:(UIImage *)imageData
                      fileName:(NSString *)fileName
                       failure:(void(^)(NSError *_Nullable error,NSString *_Nullable msg))failure
                       success:(void(^)(UIImage * _Nullable image,  NSError * _Nullable error))successResponse

{
    [LTQiNiuMethod uploadWithData:UIImageJPEGRepresentation(imageData, 0.1) fileName:fileName progressHandler:^(BOOL success, NSString * _Nonnull errDesc, NSString * _Nonnull key, float present) {
        NSLog(@"上传进度percent == %.2f", present);
    } complete:^(NSString * _Nonnull key, NSDictionary * _Nonnull resp) {
        NSLog(@"%@----", resp);
        if (resp ==nil) {
            failure(nil,@"哎呀出错啦，重新试一下吧");
            return;
        }
        
        //        //关键点检测
        [HTTPClient.sharedInstance bodyPostureWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
            
            LTFaceBodyModel *model = [LTFaceBodyModel mj_objectWithKeyValues:responseData];
            
             CGFloat lef_x = 0;
             CGFloat lef_y = 0;
             CGFloat rig_x = 0;
             CGFloat rig_y = 0;
            FaceBodySattus status = [model getFaceBodyStatus];
//            status = FaceBodySattusEye;
            if ([model.humanCount floatValue] == 0) {
                //error 没检查到人脸
                failure(nil,@"没检查到人脸");
                
            }else if ([model.humanCount floatValue] == 1){
                if (status == FaceBodySattusShoudler) {
                    NSLog(@"肩膀");
                    lef_x = [model.left_shoudler.points_x floatValue];
                    lef_y = [model.left_shoudler.points_y floatValue];
                    rig_x = [model.right_shoudler.points_x floatValue];
                    rig_y = [model.right_eye.points_y floatValue];
                    
                    successResponse([LTProcessPhoto drawimageWithLeftX:lef_x l_y:lef_y r_x:rig_x r_y:rig_y image:[UIImage imageWithData:UIImageJPEGRepresentation(imageData, 1)]],nil);
                }else if (status == FaceBodySattusEye){
                    NSLog(@"yaning");
                    lef_x = [model.left_eye.points_x floatValue];
                    lef_y = [model.left_eye.points_y floatValue];
                    rig_x = [model.right_eye.points_x floatValue];
                    rig_y = [model.right_eye.points_y floatValue];
                    
                    successResponse([LTProcessPhoto drawimageWithEyeLeftX:lef_x l_y:lef_y r_x:rig_x r_y:rig_y image:[UIImage imageWithData:UIImageJPEGRepresentation(imageData, 1)]],nil);
                }else{
                    NSLog(@"error");
                    failure(nil,@"没有检测的正确的五官");
                }
            }else{
                //多个人脸
                failure(nil,@"照片中检测到多个人脸");
            }
        
        }];
        
    }];
}

+ (UIImage *)drawimageWithLeftX:(CGFloat )l_x
                            l_y:(CGFloat )l_y
                            r_x:(CGFloat)r_x
                            r_y:(CGFloat)r_y
                          image:(UIImage *)image{
    
    
    l_y = MAX(l_y, r_y);
    r_y = l_y;
    NSLog(@"x === %f y ===== %f",l_x * 1100,l_y * 1467);
    NSLog(@"x === %f y ===== %f",r_x * 1100,r_y * 1467);
    
    CGContextRef content = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 8,
                                                 0,
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextSetStrokeColorWithColor(content, [UIColor redColor].CGColor);
    
    CGFloat height = fabs(l_x - r_x)  * image.size.width * 1.4;
    CGFloat y1 = image.size.height * (1 - r_y);
    CGFloat y2 = y1 + height;
    if (y2 > image.size.height) {
        
        y1 = y1 + image.size.height - y2;
        y2 = image.size.height;
    }
    CGContextDrawImage(content, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    
    CGImageRef clpimage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(r_x *image.size.width, l_y * image.size.height - height, fabs(l_x - r_x) * image.size.width, height));
    //    CGContextAddLineToPoint(content, image.size.width * l_x, image.size.height * l_y);
    //    CGContextMoveToPoint(content, l_x * image.size.width,y1);
    //
    //    CGContextAddLineToPoint(content, image.size.width * r_x,y1);
    //    CGContextAddLineToPoint(content, image.size.width * r_x,y2);
    //    CGContextAddLineToPoint(content, image.size.width * l_x,y2);
    //    CGContextClosePath(content);
    //    CGContextStrokePath(content);
    //
    //
    //    CGImageRef refimage = CGBitmapContextCreateImage(content);
    
    return [UIImage imageWithCGImage:clpimage];
}
+ (UIImage *)drawimageWithEyeLeftX:(CGFloat )l_x
                            l_y:(CGFloat )l_y
                            r_x:(CGFloat)r_x
                            r_y:(CGFloat)r_y
                          image:(UIImage *)image{
    
    
    l_y = MAX(l_y, r_y);
    r_y = l_y;
    NSLog(@"x === %f y ===== %f",l_x * 1100,l_y * 1467);
    NSLog(@"x === %f y ===== %f",r_x * 1100,r_y * 1467);
    
    CGContextRef content = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 8,
                                                 0,
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextSetStrokeColorWithColor(content, [UIColor redColor].CGColor);
    
    CGFloat height = fabs(l_x - r_x)  * image.size.width * 6.6;
    height = MIN(height, image.size.height);
    CGFloat width = height / 1.4;
    width = MIN(width, image.size.width);
    CGFloat eyeWidth = fabs(r_x - l_x) * image.size.width;
    CGFloat y1 = image.size.height * (1 - r_y);
    CGFloat y2 = y1 + height;
    
    CGFloat wwwx = (width - eyeWidth) / 2.0 / image.size.width;
    r_x = r_x - wwwx;
    l_x = l_x + wwwx;
    
    if (y2 > image.size.height) {
        
        y1 = y1 + image.size.height - y2;
        y2 = image.size.height;
    }
    CGContextDrawImage(content, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    
    CGImageRef clpimage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(r_x *image.size.width, y1, width, height));
//        CGContextAddLineToPoint(content, image.size.width * l_x, image.size.height * l_y);
        CGContextMoveToPoint(content, l_x * image.size.width,y1);
    
        CGContextAddLineToPoint(content, image.size.width * r_x,y1);
        CGContextAddLineToPoint(content, image.size.width * r_x,y2);
        CGContextAddLineToPoint(content, image.size.width * l_x,y2);
        CGContextClosePath(content);
        CGContextStrokePath(content);
    
    
        CGImageRef refimage = CGBitmapContextCreateImage(content);
    
    return [UIImage imageWithCGImage:clpimage];
}
@end
