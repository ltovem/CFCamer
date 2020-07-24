//
// LTHomeViewController.m
// CFCamer
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2020/7/8.
// Copyright © 2020 LTOVE. All rights reserved.
//


#import "LTHomeViewController.h"

#import "QDUIKitViewController.h"
#import "LTCameraViewController.h"
#import <QiniuSDK.h>
//#import "LTHTTPService.h"
#import "HTTPClient.h"
#import "LTQiNiuMethod.h"
#import "UIImage+Luban_iOS_Extension_h.h"
#import <TZImagePickerController/TZImagePickerController.h>

#import <QMUIZoomImageView.h>


typedef NS_ENUM(NSUInteger, LTPhotoType) {
    LTPhotoTypeNomal1,
    LTPhotoTypeNomal2,
    LTPhotoTypeSmall1,
    LTPhotoTypeSmall2,
    LTPhotoTypeBig1,
    LTPhotoTypeBig2,
    LTPhotoTypeDriver,
    LTPhotoTypeStudentIdCard,
    LTPhotoTypeUSASing,
    
};
typedef NS_ENUM(NSUInteger, LTTypingType) {
    LTTypingTypeV,
    LTTypingTypeH,
    
};
@interface LTHomeViewController ()<UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,copy)NSString *name;
@end

@implementation LTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.title = @"ddd";
    self.name = @"timg11";
    self.imageView = [[UIImageView alloc]init];
    [self.view addSubview:self.imageView];
    QMUIZoomImageView *view = [[QMUIZoomImageView alloc]init];
    [view.imageView setImage:[UIImage imageNamed:@"56789"]];
    [view showLoading];
    view.frame = self.view.bounds;
    
    //    self.view.backgroundColor = [UIColor qmui_colorFromColor:[UIColor yellowColor] toColor:[UIColor greenColor] progress:0.8];
    
    //    self.imageView.image = [QMUIZoomImageView qmuii]
    //    [self.view addSubview:view];
    // Do any additional setup after loading the view.
    self.imageView.frame = CGRectMake(0, 0, 400, 500);
    self.imageView.contentMode = UIViewContentModeScaleToFill;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    LTCameraViewController *view = [LTCameraViewController new];
    QDUIKitViewController *view = [QDUIKitViewController new];
    view.title = @"haha";
    self.hidesBottomBarWhenPushed = NO;
    //    [self.navigationController pushViewController:view animated:YES];
    //    [view setModalPresentationStyle:UIModalPresentationOverFullScreen];
    //    [self presentViewController:view animated:YES completion:nil];
    
    //    NSString *token = @"Iq7fn4u5EwlcBMhCYpj2n1KocCukSfRUBB2vr9gU:ImdyTCRheRdtZc5BWKR3TYiFKTA=:eyJzY29wZSI6InB1YmxpY2x0b3ZlIiwiZGVhZGxpbmUiOjE1OTUxNjgwOTd9";
    //    UIImage *image = [UIImage imageNamed:@"homebannerinface"];
    //    NSData *imageData = UIImagePNGRepresentation(image);
    //    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    //
    ////    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    //    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
    //        NSLog(@"上传进度percent == %.2f", percent);
    //    }
    //                                                                 params:nil
    //                                                               checkCrc:NO
    //                                                     cancellationSignal:nil];
    //
    //    NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
    //    [upManager putData:imageData key:@"homebannerinface.jpg" token:token
    //    complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
    //    NSLog(@"%@", info);
    //    NSLog(@"%@", resp);
    //    } option:uploadOption];
    
    //    [HTTPClient.sharedInstance getQiNiuToken:^(BOOL success, NSString *errDesc, id responseData) {
    //        NSLog(@"%@",responseData);
    //    }];
    //    LTQiNiuMethod *qi = [LTQiNiuMethod new];
    //    NSString *tokens = [qi geiQiNiuThoken];
    //    NSLog(@"%@>>>>>>>>",tokens);
    
    UIImage *image = [UIImage imageNamed:self.name];
    //    NSData *imageData = UIImagePNGRepresentation(image);
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    //    UIImage *coverimage = [self coloredImage:image red:0 /255.0 green:123/255.0 blue:123/255.0 alpa:0.5];
    //    UIImage *coverimage = [self imageFromColor:[UIColor yellowColor] size:image.size image:image];
    UIImage *coverimage = [UIImage coverImageWithImage:image color:[self RandomColor]];
    //    self.imageView.image = [UIImage imageWithData:imageData];
    //    self.imageView.image = [coverimage qmui_imageWithTintColor:[UIColor yellowColor]];
    //    [self.imageView sizeToFit];
    //    self.imageView.tintColor = [UIColor yellowColor];
    //    NSData *writedata = UIImageJPEGRepresentation(coverimage, 0.7);
    //    if ([writedata writeToFile:@"/Users/ltove/Desktop/zjz.png" atomically:YES]) {
    //        NSLog(@"写入成功");
    //    }
    //    [LTQiNiuMethod uploadWithData:imageData fileName:[NSString stringWithFormat:@"%u9999--9.jpg",arc4random()] progressHandler:^(BOOL success, NSString * _Nonnull errDesc, NSString * _Nonnull key, float present) {
    //        NSLog(@"上传进度percent == %.2f", present);
    //    } complete:^(NSString * _Nonnull key, NSDictionary * _Nonnull resp) {
    //        NSLog(@"%@", resp);
    ////        [HTTPClient.sharedInstance getQiNiuDowUrlWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
    ////            NSLog(@"%@========>>>>>>>>>====",responseData);
    ////        }];
    //
    //        //关键点检测
    //        [HTTPClient.sharedInstance bodyPostureWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
    ////            NSLog(@"人像处理结果  ：：：%@========>>>>>>>>>====",[responseData mj_JSONString]);
    ////            NSDictionary *dic = [responseData mj_JSONObject];？
    ////            if ([dic writeToFile:@"/Users/ltove/Desktop/json.plist" atomically:YES]) {
    ////                NSLog(@"json 写入成功");
    ////            }
    //
    //            NSArray *outputs = responseData[@"data"][@"outputs"];
    //            NSArray * results = outputs.firstObject[@"results"];
    //            NSArray *bodies = results.firstObject[@"bodies"];
    //            __block CGFloat lef_x = 0;
    //            __block CGFloat lef_y = 0;
    //            __block CGFloat rig_x = 0;
    //            __block CGFloat rig_y = 0;
    //            [bodies enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    ////                NSLog(@"index= %lu %@\n",(unsigned long)idx,obj[@"label"]);
    //                if ([obj[@"label"] isEqualToString:@"left_shoudler"]) {
    //                    NSArray *positions = obj[@"positions"];
    //                    NSDictionary *dic = positions.firstObject;
    //                    NSArray *points = dic[@"points"];
    //                    lef_x = [points[0] floatValue];
    //                    lef_y = [points[1] floatValue];
    //
    //                }else if ([obj[@"label"] isEqualToString:@"right_shoudler"]) {
    //                    NSArray *positions = obj[@"positions"];
    //                    NSDictionary *dic = positions.firstObject;
    //                    NSArray *points = dic[@"points"];
    //                    rig_x = [points[0] floatValue];
    //                    rig_y = [points[1] floatValue];
    //
    //                }
    //            }];
    //
    //            NSLog(@"x === %f y ===== %f",lef_x * 1100,lef_y * 1467);
    //            NSLog(@"x === %f y ===== %f",rig_x * 1100,rig_y * 1467);
    //            [self drawimageWithLeftX:lef_x l_y:lef_y r_x:rig_x r_y:rig_y];
    //        }];
    //
    //    }];
    
    //    TZImagePickerController *imagevc = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    //
    //
    //    imagevc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
    //        self.imageView.image = photos.firstObject;
    //        UIImage *image = photos.firstObject;
    //        NSData *data = UIImagePNGRepresentation(image);
    //        PHAsset *asset = assets.firstObject;
    //        NSLog(@"%f--%f",image.size.width,image.size.height);
    //        self.imageView.image = image;
    //        [[TZImageManager manager]  getOriginalPhotoWithAsset:assets.firstObject completion:^(UIImage *photo, NSDictionary *info) {
    //            NSData *images = UIImagePNGRepresentation(photo);
    ////            self.imageView.image = photo;
    //            NSLog(@"--==--==%f--%f",photo.size.width,photo.size.height);
    //            if ([images writeToFile:@"/Users/ltove/Desktop/img.png" atomically:YES]) {
    //                NSLog(@"写入成功");
    //            }
    //        }];
    //
    //    };
    //    imagevc.allowCrop = YES;
    //    imagevc.scaleAspectFillCrop = NO;
    //    imagevc.isSelectOriginalPhoto = YES;
    //    imagevc.photoWidth = 2400;
    //    imagevc.photoPreviewMaxWidth = 2400;
    //    imagevc.notScaleImage = NO;
    //    imagevc.scaleAspectFillCrop = YES;
    ////    imagevc.
    ////    imagevc.needCircleCrop = YES;
    ////    imagevc.circleCropRadius = 200;
    ////    imagevc.showSelectBtn = YES;
    ////    imagevc.ph
    //    imagevc.cropRect = CGRectMake(imagevc.cropRect.origin.x, imagevc.cropRect.origin.y, imagevc.cropRect.size.width, 368);
    //    NSLog(@"%f",imagevc.cropRect.size.width);
    //    imagevc.cropViewSettingBlock = ^(UIView *cropView) {
    ////        cropView.center = self.view.center;
    ////        cropView.backgroundColor = [UIColor yellowColor];
    //        UIImageView *imagev = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"camera_idphoto_tip_renxiang"]];
    //        imagev.frame = cropView.bounds;
    //        imagev.tintColor = [UIColor darkGrayColor];
    //        imagev.contentMode = UIViewContentModeScaleAspectFit;
    ////        imagev.backgroundColor = [UIColor darkGrayColor];
    //        [cropView addSubview:imagev];
    //
    //    };
    //    imagevc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    //    [self presentViewController:imagevc animated:YES completion:nil];
    
    //    [self drawimageWithLeftX:0.875 l_y:0.79891306161880493 r_x:0.1527777761220932 r_y:0.78260868787765503];
    
//    [self drawImageWithWidth:1795 height:1205];
    for (int i = 0; i < 8; i ++) {
        [self typeingWithPhoto:[UIImage imageNamed:@"puqiao"] photoType:i];
        [NSThread sleepForTimeInterval:5];
    }
//    [self typeingWithPhoto:[UIImage imageNamed:@"timg1"] photoType:LTPhotoTypeBig1];
    
}

-(UIColor*)RandomColor {
    
        return   [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
}

- (void)getClearImageWithData:(NSData *)data{
    [LTQiNiuMethod uploadWithData:data fileName:[NSString stringWithFormat:@"%u9999--9.jpg",arc4random()] progressHandler:^(BOOL success, NSString * _Nonnull errDesc, NSString * _Nonnull key, float present) {
        NSLog(@"上传进度percent == %.2f", present);
    } complete:^(NSString * _Nonnull key, NSDictionary * _Nonnull resp) {
        NSLog(@"%@", resp);
        [HTTPClient.sharedInstance getQiNiuDowUrlWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
            NSLog(@"%@========>>>>>>>>>====",responseData);
            NSString *url = responseData[@"data"][@"imageURL"];
            SDWebImageDownloader *download = [SDWebImageDownloader sharedDownloader];
            [download downloadImageWithURL:[url mj_url] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                //                    UIImage *rhImage = [UIImage coverImageWithImage:<#(UIImage *)#> color:<#(UIColor *)#>]
                [self coverImageWithImage:image];
                if ([data writeToFile:@"/Users/ltove/Desktop/12345.png" atomically:YES]) {
                    NSLog(@"clear image 写入成功");
                }
            }];
        }];
        
        //关键点检测
        //            [HTTPClient.sharedInstance bodyPostureWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
        //    //            NSLog(@"人像处理结果  ：：：%@========>>>>>>>>>====",[responseData mj_JSONString]);
        //    //            NSDictionary *dic = [responseData mj_JSONObject];？
        //    //            if ([dic writeToFile:@"/Users/ltove/Desktop/json.plist" atomically:YES]) {
        //    //                NSLog(@"json 写入成功");
        //    //            }
        //
        //                NSArray *outputs = responseData[@"data"][@"outputs"];
        //                NSArray * results = outputs.firstObject[@"results"];
        //                NSArray *bodies = results.firstObject[@"bodies"];
        //                __block CGFloat lef_x = 0;
        //                __block CGFloat lef_y = 0;
        //                __block CGFloat rig_x = 0;
        //                __block CGFloat rig_y = 0;
        //                [bodies enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //    //                NSLog(@"index= %lu %@\n",(unsigned long)idx,obj[@"label"]);
        //                    if ([obj[@"label"] isEqualToString:@"left_shoudler"]) {
        //                        NSArray *positions = obj[@"positions"];
        //                        NSDictionary *dic = positions.firstObject;
        //                        NSArray *points = dic[@"points"];
        //                        lef_x = [points[0] floatValue];
        //                        lef_y = [points[1] floatValue];
        //
        //                    }else if ([obj[@"label"] isEqualToString:@"right_shoudler"]) {
        //                        NSArray *positions = obj[@"positions"];
        //                        NSDictionary *dic = positions.firstObject;
        //                        NSArray *points = dic[@"points"];
        //                        rig_x = [points[0] floatValue];
        //                        rig_y = [points[1] floatValue];
        //
        //                    }
        //                }];
        //
        //                NSLog(@"x === %f y ===== %f",lef_x * 1100,lef_y * 1467);
        //                NSLog(@"x === %f y ===== %f",rig_x * 1100,rig_y * 1467);
        //                [self drawimageWithLeftX:lef_x l_y:lef_y r_x:rig_x r_y:rig_y];
        //            }];
        
    }];
}

- (void)coverImageWithImage:(UIImage *)image{
    UIImage *coImage = [UIImage coverImageWithImage:image color:[self RandomColor]];
    self.imageView.image = coImage;
    NSData *data = UIImagePNGRepresentation(coImage);
    if ([data writeToFile:@"/Users/ltove/Desktop/123456.png" atomically:YES]) {
        NSLog(@"cover color image save success");
    }
}

- (void)typeingWithPhoto:(UIImage *)photo
               photoType:(LTPhotoType)type{
    CGFloat width = 1795;
    CGFloat height = 1205;
    CGFloat codeWidth = 500;//条码宽度
    CGFloat codeHeight = 40;//条码高度
    
    CGFloat sepWidth = 20; //分割线宽度
    
    CGFloat maginWidth = 10;//外边距
    CGFloat clpLineWidth = 40;//最小的标志线宽度
    CGFloat clpLineHeight = clpLineWidth;
    CGFloat padding = 10;
    
    CGFloat contentWidth = width - 2 * (maginWidth + clpLineWidth + padding);
    CGFloat contentHeight = height - 2 * (maginWidth + clpLineWidth + padding) - codeHeight;
    
    
    CGFloat VVcount = 0;
    CGFloat VHcount = 0;
    CGFloat HVcount = 0;
    CGFloat HHcount = 0;
    LTTypingType typingType = LTTypingTypeV;
    CGSize photoSize = [self getPhotoSizeWithPhotoType:type];
    VVcount = floor((contentWidth + sepWidth) / (photoSize.width + sepWidth));
    VHcount = floor((contentHeight + sepWidth) / (photoSize.height + sepWidth));
    HVcount = floor((contentWidth + sepWidth) / (photoSize.height + sepWidth));
    HHcount = floor((contentHeight + sepWidth) / (photoSize.width + sepWidth));
    NSLog(@"%ld ----- %f\n",(long)VVcount,VHcount);
    NSLog(@"%ld ----- %f",(long)HVcount,HHcount);
//    CGFloat lineWidth = 0;
//    CGFloat outheight = 0;
    CGImageRef refPhoto = photo.CGImage;
    if (VVcount * VHcount < HVcount * HHcount) {
        typingType = LTTypingTypeH;
        VVcount = HVcount;
        VHcount = HHcount;
        photoSize = CGSizeMake(photoSize.height, photoSize.width);
        refPhoto = [self rotateImageWithImage:photo];
        NSLog(@"横排");
    }else if(VVcount * VHcount == HVcount * HHcount){
        CGFloat w1 = contentWidth - (VVcount - 1) * sepWidth - VVcount * photoSize.width;
        CGFloat w2 = contentWidth - (HVcount - 1) * sepWidth - HVcount * photoSize.height;
        CGFloat h1 = contentHeight - (VHcount - 1) * sepWidth - VHcount * photoSize.height;
        CGFloat h2 = contentHeight - (HHcount - 1) * sepWidth - HHcount * photoSize.width;
        if (MAX(w1, w2) / MIN(w1, w2) > MAX(h1, h2) / MIN(h1, h2)) {
            typingType = LTTypingTypeH;
            VVcount = HVcount;
            VHcount = HHcount;
            photoSize = CGSizeMake(photoSize.height, photoSize.width);
            refPhoto = [self rotateImageWithImage:photo];
        }
        NSLog(@"竖排");
    }
    
    
    CGFloat lineWidth = (VVcount - 1) * sepWidth + VVcount * photoSize.width;
    CGFloat outheight = (VHcount - 1) * sepWidth + VHcount * photoSize.height;
    
    clpLineWidth = (width - lineWidth) / 2.0;
    clpLineHeight = (height - outheight) / 2.0;
    
    NSLog(@"width %f -- height %f",contentWidth,contentHeight);
    
    CGColorSpaceRef colorSpec = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 8,
                                                 0, colorSpec,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    
    
    
    CGImageRef tiaoMaImage = [self generateBarCodeImage:@"12345678901234567890"];
    
    

    CGImageRef HClpImage = [self drawHClpLineWith:clpLineWidth height:outheight imageHeigh:photoSize.height HCount:VHcount maginWidth:maginWidth sepLineWidth:sepWidth];
    
    //左边剪裁标志线
    CGContextDrawImage(context, CGRectMake( clpLineWidth / 2 , codeHeight + clpLineHeight, clpLineWidth / 2, outheight), HClpImage);
    //右边剪裁标志线
    CGContextDrawImage(context, CGRectMake(maginWidth * 2 + clpLineWidth  + lineWidth, codeHeight + clpLineHeight, clpLineWidth / 2, outheight), HClpImage);
    
    CGImageRef VClpImage = [self drawHVlpLineWithHeight:clpLineHeight width:lineWidth imageWidth:photoSize.width VCount:VVcount maginWidth:maginWidth sepLineWidth:sepWidth];
    
    //上边剪裁标志线
    CGContextDrawImage(context, CGRectMake(maginWidth + clpLineWidth, codeHeight + clpLineHeight * 0.4 - maginWidth, lineWidth, clpLineHeight * 0.6), VClpImage);
    //下边剪裁标志线
    CGContextDrawImage(context, CGRectMake(maginWidth + clpLineWidth, codeHeight + outheight + maginWidth + clpLineHeight, lineWidth, clpLineHeight * 0.6), VClpImage);
//    CGContextDrawImage(context, CGRectMake(maginWidth * 2 + clpLineWidth  + lineWidth, codeHeight + clpLineHeight, clpLineWidth / 2, outheight), VClpImage);
    
    //绘制二维码
    CGContextDrawImage(context,
                       CGRectMake((width - codeWidth) / 2, maginWidth, codeWidth, codeHeight),
                       tiaoMaImage);
    

//    VVcount = 4;
//    VHcount = 3;
    
    CGImageRef lineImage = [self drowimageLineWithImage:refPhoto width:photoSize.width height:photoSize.height sepLineWidth:sepWidth outWidth:lineWidth count:VVcount];
    CGImageRef contentImage = [self drawContentWithLineImage:lineImage lineHeight:photoSize.height lineWidth:lineWidth sepLineWidth:sepWidth outHeight:outheight lineCount:VHcount];
    
    CGContextDrawImage(context, CGRectMake(maginWidth + clpLineWidth, codeHeight + clpLineHeight, lineWidth, outheight), contentImage);
    
    CGImageRef refImage = CGBitmapContextCreateImage(context);
    self.imageView.image = [UIImage imageWithCGImage:refImage];
    NSData *data = UIImageJPEGRepresentation([UIImage imageWithCGImage:refImage], 1);
    
    if ([data writeToFile:@"/Users/ltove/Desktop/123456.jpeg" atomically:YES]) {
        
        NSLog(@"new image write success ");
        
        
    }else{
        NSLog(@"new image write failure ");
    }
}


- (CGImageRef)drawHClpLineWith:(CGFloat)width
                        height:(CGFloat)height
                    imageHeigh:(CGFloat)imageHeigh
                        HCount:(NSInteger)Hcount
                    maginWidth:(CGFloat)maginWidth
                  sepLineWidth:(CGFloat)sepLineWidth{
    CGContextRef content = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 8,
                                                 0,
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextSetRGBStrokeColor(content, 1, 0, 0, 1);
    CGContextSetLineWidth(content, 0.5);
    for (int i = 0; i < Hcount; i++) {
        CGContextMoveToPoint(content,maginWidth , i * (imageHeigh + sepLineWidth));
        CGContextAddLineToPoint(content,  width, i * (imageHeigh + sepLineWidth));
        
        CGContextMoveToPoint(content,maginWidth + width / 2.3 , i * (imageHeigh + sepLineWidth) + 20);
        CGContextAddLineToPoint(content,  maginWidth + width / 2.3, i * (imageHeigh + sepLineWidth) - 10);
        
        CGContextMoveToPoint(content,maginWidth , i * (imageHeigh + sepLineWidth) + imageHeigh);
        CGContextAddLineToPoint(content,  width, i * (imageHeigh + sepLineWidth) + imageHeigh);
        
        CGContextMoveToPoint(content,maginWidth + width / 2 , i * (imageHeigh + sepLineWidth) + imageHeigh + 10);
        CGContextAddLineToPoint(content,  maginWidth + width / 2, i * (imageHeigh + sepLineWidth) + imageHeigh - 30);
    }
    CGContextStrokePath(content);
    
    return CGBitmapContextCreateImage(content);
}
- (CGImageRef)drawHVlpLineWithHeight:(CGFloat)width
                        width:(CGFloat)height
                    imageWidth:(CGFloat)imageHeigh
                        VCount:(NSInteger)Hcount
                    maginWidth:(CGFloat)maginWidth
                  sepLineWidth:(CGFloat)sepLineWidth{
    CGContextRef content = CGBitmapContextCreate(NULL,
                                                 height,
                                                 width,
                                                 8,
                                                 0,
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextSetRGBStrokeColor(content, 1, 0, 0, 1);
    CGContextSetLineWidth(content, 0.5);
    for (int i = 0; i < Hcount; i++) {
        CGContextMoveToPoint(content,i * (imageHeigh + sepLineWidth) , maginWidth);
        CGContextAddLineToPoint(content,  i * (imageHeigh + sepLineWidth), width);
        
        CGContextMoveToPoint(content,i * (imageHeigh + sepLineWidth) -10 , width / 2 );
        CGContextAddLineToPoint(content,  i * (imageHeigh + sepLineWidth) + 20, width  / 2);
        
        CGContextMoveToPoint(content,i * (imageHeigh + sepLineWidth) + imageHeigh , maginWidth);
        CGContextAddLineToPoint(content,  i * (imageHeigh + sepLineWidth) + imageHeigh, width);
        
        CGContextMoveToPoint(content,i * (imageHeigh + sepLineWidth) + imageHeigh - 30 , width / 2.3 );
        CGContextAddLineToPoint(content,  i * (imageHeigh + sepLineWidth) + imageHeigh + 10, width  / 2.3);
    }
    CGContextStrokePath(content);
    
    return CGBitmapContextCreateImage(content);
}

- (CGImageRef)drawContentWithLineImage:(CGImageRef)lineImage
                            lineHeight:(CGFloat)lineHeight
                             lineWidth:(CGFloat)lineWidth
                          sepLineWidth:(CGFloat)sepLineWidth
                             outHeight:(CGFloat)outHeight
                             lineCount:(NSInteger)lineCount{
    
    CGContextRef content = CGBitmapContextCreate(NULL,
                                                 lineWidth,
                                                 outHeight,
                                                 8,
                                                 0,
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    for (int i = 0; i < lineCount; i++) {
        CGContextDrawImage(content, CGRectMake(0, i * (lineHeight + sepLineWidth), lineWidth, lineHeight), lineImage);
    }
    
    return CGBitmapContextCreateImage(content);
    
}

//绘制一行照片
- (CGImageRef )drowimageLineWithImage:(CGImageRef)image
                                width:(CGFloat)width
                               height:(CGFloat)height
                         sepLineWidth:(CGFloat)sepLineWidth
                             outWidth:(CGFloat)outWidth
                                count:(NSInteger)count{
    CGContextRef content = CGBitmapContextCreate(NULL,
                                                 outWidth,
                                                 height,
                                                 8,
                                                 0,
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    for (int i = 0; i < count; i++) {
        CGContextDrawImage(content, CGRectMake(i * (width + sepLineWidth), 0, width, height), image);
    }
    
    return CGBitmapContextCreateImage(content);
}

/// 照片旋转90度，横排
/// @param image image
- (CGImageRef)rotateImageWithImage:(UIImage *)image{
    
    return [self image:image rotation:UIImageOrientationRight];
    
}

- (CGImageRef )image:(UIImage *)image rotation:(UIImageOrientation)orientation {

    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;

    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
        break;
        case UIImageOrientationRight:
            rotate = -M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
        break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
        break;
    }

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);

    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
//    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
//    return newPic;
    return CGBitmapContextCreateImage(context);
}

/// 分割字符串
/// @param str 源
/// @param count 每组数量
- (NSString *)stringWithCharmCount:(NSString *)str
                             count:(NSInteger)count
{
    //将要分割的字符串变为可变字符串
    NSMutableString *countMutStr = [[NSMutableString alloc]initWithString:str];
    //字符串长度
    NSInteger length = countMutStr.length;
    //除数
    NSInteger divisor = length/count;
    //余数
    NSInteger remainder = length%count;
    //有多少个逗号
    NSInteger commaCount;
    if (remainder == 0) {   //当余数为0的时候，除数-1==逗号数量
        commaCount = divisor - 1;
    }else{  //否则 除数==逗号数量
        commaCount = divisor;
    }
    //根据逗号数量，for循环依次添加逗号进行分隔
    for (int i = 1; i<commaCount+1; i++) {
        [countMutStr insertString:@" " atIndex:length - i * count];
    }
    return countMutStr;
}

/// 生成订单二维码
/// @param source 订单号 123456789   image w:h 25:4
- (CGImageRef )generateBarCodeImage:(NSString *)source

{
    //    height = width * 0.45;
    CGFloat width = 500 * 2 + 10;
    CGFloat height = 40;
    // 注意生成条形码的编码方式
    NSData *data = [source dataUsingEncoding: NSASCIIStringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    // 设置生成的条形码的上，下，左，右的margins的值
    [filter setValue:[NSNumber numberWithInteger:0] forKey:@"inputQuietSpace"];
    
    CIImage *ciimage = filter.outputImage;
    
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:ciimage fromRect:ciimage.extent];
    
    // Initialize a graphics context in iOS.
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 8,
                                                 0,
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    // Set the text matrix.
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    // Create a path which bounds the area where you will be drawing text.
    // The path need not be rectangular.
    CGMutablePathRef path = CGPathCreateMutable();
    
    // In this simple example, initialize a rectangular path.
    CGRect bounds = CGRectMake(width / 2.0 + 5, 0.0, width / 2, 40);
    CGPathAddRect(path, NULL, bounds );
    
    // Initialize a string.
    
    
    // Create a mutable attributed string with a max length of 0.
    // The max length is a hint as to how much internal storage to reserve.
    // 0 means no hint.
    
    
    
    // Copy the textString into the newly created attrString
    
    
    // Create a color that will be added as an attribute to the attrString.
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    
    CGColorSpaceRelease(rgbColorSpace);
    source = [NSString stringWithFormat:@"number:%@",[self stringWithCharmCount:source count:4]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:source];
    
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:28] range:NSMakeRange(0, source.length)];
    
    //    CFMutableAttributedStringRef attrString  = (__bridge CFMutableAttributedStringRef)(attr);
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attr);
    //    CFRelease(attrString);
    
    // Create a frame.
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, 0), path, NULL);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    //线条的宽度
    
    CGContextSetLineWidth(context, 6);
    // Draw the specified frame in the given context.
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, height);
    CGContextAddLineToPoint(context, width, height);
    CGContextAddLineToPoint(context, width, 0);
    CGContextClosePath(context);
    CGContextSetRGBFillColor(context, 1, 0, 0, 0.8);
    CGContextAddRect(context, CGRectMake(0, 0, width, height));
    //    CGContextStrokePath(context);
    
    
    CTFrameDraw(frame, context);
    CGContextDrawImage(context, CGRectMake(0, 0, width / 2, 40), cgImage);
    
    CGImageRef reImage = CGBitmapContextCreateImage(context);
    
    // Release the objects we used.
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
    return reImage;
    
}

- (void)drawimageWithLeftX:(CGFloat )l_x
                       l_y:(CGFloat )l_y
                       r_x:(CGFloat)r_x
                       r_y:(CGFloat)r_y{
    
    
    l_y = MAX(l_y, r_y);
    r_y = l_y;
    NSLog(@"x === %f y ===== %f",l_x * 1100,l_y * 1467);
    NSLog(@"x === %f y ===== %f",r_x * 1100,r_y * 1467);
    UIImage *image = [UIImage imageNamed:self.name];
    self.imageView.image = image;
    CGContextRef content = CGBitmapContextCreate(NULL, image.size.width, image.size.height, 8, 0, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextSetStrokeColorWithColor(content, [UIColor redColor].CGColor);
    
    //线条的宽度
    
    CGContextSetLineWidth(content, 6);
    
    //    CGContextTranslateCTM(content, 0, image.size.height);
    //    CGContextScaleCTM(content, 1, -1);
    CGFloat height = fabs(l_x - r_x)  * image.size.width * 1.4;
    CGFloat y1 = image.size.height * (1 - r_y);
    CGFloat y2 = y1 + height;
    if (y2 > image.size.height) {
        
        y1 = y1 + image.size.height - y2;
        y2 = image.size.height;
    }
    NSLog(@"height %f",height);
    CGContextDrawImage(content, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    
    CGImageRef clpimage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(r_x *image.size.width, l_y * image.size.height - height, fabs(l_x - r_x) * image.size.width, height));
    //    CGContextAddLineToPoint(content, image.size.width * l_x, image.size.height * l_y);
    CGContextMoveToPoint(content, l_x * image.size.width,y1);
    
    CGContextAddLineToPoint(content, image.size.width * r_x,y1);
    CGContextAddLineToPoint(content, image.size.width * r_x,y2);
    CGContextAddLineToPoint(content, image.size.width * l_x,y2);
    CGContextClosePath(content);
    CGContextStrokePath(content);
    
    
    CGImageRef refimage = CGBitmapContextCreateImage(content);
    
    self.imageView.image = [UIImage imageWithCGImage:refimage];
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:refimage], 0.3);
    if ([imageData writeToFile:@"/Users/ltove/Desktop/1234.png" atomically:YES]) {
        NSLog(@"写如此高");
    }
    NSData *clpData = UIImageJPEGRepresentation([UIImage imageWithCGImage:clpimage], 0.3);
    [self getClearImageWithData:clpData];
    if ([UIImagePNGRepresentation([UIImage imageWithCGImage:clpimage]) writeToFile:@"/Users/ltove/Desktop/12345.png" atomically:YES]) {
        NSLog(@"clp 写入成功");
        self.imageView.image = [UIImage imageWithCGImage:clpimage];
    }else{
        NSLog(@"clp 写入shibai");
    }
    
    
}

//- (void)typeingWithPhoto:(UIImage *)photo
//               photoType:(LTPhotoType)type
//             contentSize:(CGSize)contentSize{
//    CGFloat seplieWidth = 20;
//}

/// 获取照片尺寸
/// @param type 照片类型
- (CGSize)getPhotoSizeWithPhotoType:(LTPhotoType)type{
    CGSize size = CGSizeZero;
    switch (type) {
        case LTPhotoTypeNomal1:
            size = CGSizeMake(295, 413);
            break;
        case LTPhotoTypeNomal2:
            size = CGSizeMake(413, 579);
            break;
        case LTPhotoTypeSmall1:
            size = CGSizeMake(260, 378);
            break;
        case LTPhotoTypeSmall2:
            size = CGSizeMake(413, 531);
            break;
        case LTPhotoTypeBig1:
            size = CGSizeMake(389, 566);
            break;
        case LTPhotoTypeBig2:
            size = CGSizeMake(413, 625);
            break;
        case LTPhotoTypeDriver:
            size = CGSizeMake(259, 377);
            break;
        case LTPhotoTypeStudentIdCard:
            size = CGSizeMake(295, 413);
            break;
        case LTPhotoTypeUSASing:
            size = CGSizeMake(413, 531);
            break;
            
        default:
            break;
    }
    
    return size;
}

@end
