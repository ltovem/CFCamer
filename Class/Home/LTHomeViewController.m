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

#import "LTTypingPhoto.h"
#import "LTWebViewController.h"
#import "LTEditPhotoViewController.h"


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
    
    
    
    
    
    
//
//        [LTQiNiuMethod uploadWithData:imageData fileName:[NSString stringWithFormat:@"%u9999--9.jpg",arc4random()] progressHandler:^(BOOL success, NSString * _Nonnull errDesc, NSString * _Nonnull key, float present) {
//            NSLog(@"上传进度percent == %.2f", present);
//        } complete:^(NSString * _Nonnull key, NSDictionary * _Nonnull resp) {
//            NSLog(@"%@", resp);
//    //        [HTTPClient.sharedInstance getQiNiuDowUrlWithName:resp[@"key"] complete:^(BOOL success, NSString *errDesc, id responseData) {
//    //            NSLog(@"%@========>>>>>>>>>====",responseData);
//    //        }];
//    //
//    //        //关键点检测
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
//
//        }];
    
    
    
    
    
    
    
    
//
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
//    for (int i = 0; i < 8; i ++) {
//        [self typeingWithPhoto:[UIImage imageNamed:@"puqiao"] photoType:i];
//        [NSThread sleepForTimeInterval:5];
//    }
//    UIImage *orginImage = [UIImage imageNamed:@"IMG_0821"];
//    [LTTypingPhoto typeingWithPhoto:orginImage photoType:LTPhotoTypeDriver typedImage:^(UIImage * _Nonnull typedImage) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIImage *image = [LTTypingPhoto drawWatherWithImage:typedImage watherSte:@"4567890"];
//            NSData *data = UIImageJPEGRepresentation(image, 1);
//            
//            if ([data writeToFile:@"/Users/ltove/Desktop/123456.jpeg" atomically:YES]) {
//                
//                NSLog(@"new image write success ");
//                
//                
//            }else{
//                NSLog(@"new image write failure ");
//            }
//            self.imageView.image = image;
//        });
//        
//        NSLog(@"%@nstread  @",[NSThread currentThread]);
//    }];
//    
    NSLog(@"1234567890-");
    
    LTEditPhotoViewController *webView = [LTEditPhotoViewController new];
    [self.navigationController pushViewController:webView animated:YES];
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



@end
