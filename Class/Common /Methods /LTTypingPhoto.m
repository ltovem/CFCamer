//
// LTTypingPhoto.m
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


#import "LTTypingPhoto.h"
#import <AFNetworking/AFURLSessionManager.h>


static dispatch_queue_t get_tped_queue() {
    static dispatch_queue_t tped_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tped_queue = dispatch_queue_create("com.ltove.pyting", DISPATCH_QUEUE_SERIAL);
    });
    
    return tped_queue;
}

static void tyed_async(dispatch_block_t block) {
    dispatch_async(get_tped_queue(), block);
}

@implementation LTTypingPhoto


+ (UIImage *)typeingWithPhoto:(UIImage *)photo
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
    CGSize photoSize = [LTTypingPhoto getPhotoSizeWithPhotoType:type];
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
        refPhoto = [LTTypingPhoto rotateImageWithImage:photo];
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
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, CGRectMake(0, 0, width, height));
    //        CGContextStrokePath(context);
    
    CGImageRef tiaoMaImage = [LTTypingPhoto generateBarCodeImage:@"12345678901234567890"];
    
    
    
    CGImageRef HClpImage = [LTTypingPhoto drawHClpLineWith:clpLineWidth height:outheight imageHeigh:photoSize.height HCount:VHcount maginWidth:maginWidth sepLineWidth:sepWidth];
    
    //左边剪裁标志线
    CGContextDrawImage(context, CGRectMake( clpLineWidth / 2 , codeHeight + clpLineHeight, clpLineWidth / 2, outheight), HClpImage);
    //右边剪裁标志线
    CGContextDrawImage(context, CGRectMake(maginWidth * 2 + clpLineWidth  + lineWidth, codeHeight + clpLineHeight, clpLineWidth / 2, outheight), HClpImage);
    
    CGImageRef VClpImage = [LTTypingPhoto drawHVlpLineWithHeight:clpLineHeight width:lineWidth imageWidth:photoSize.width VCount:VVcount maginWidth:maginWidth sepLineWidth:sepWidth];
    
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
    
    CGImageRef lineImage = [LTTypingPhoto drowimageLineWithImage:refPhoto width:photoSize.width height:photoSize.height sepLineWidth:sepWidth outWidth:lineWidth count:VVcount];
    CGImageRef contentImage = [LTTypingPhoto drawContentWithLineImage:lineImage lineHeight:photoSize.height lineWidth:lineWidth sepLineWidth:sepWidth outHeight:outheight lineCount:VHcount];
    
    CGContextDrawImage(context, CGRectMake(maginWidth + clpLineWidth, codeHeight + clpLineHeight, lineWidth, outheight), contentImage);
    
    CGImageRef refImage = CGBitmapContextCreateImage(context);
    //    self.imageView.image = [UIImage imageWithCGImage:refImage];
    
    
    
    
    return [UIImage imageWithCGImage:refImage];
    
    
}

+ (void)typeingWithPhoto:(UIImage *)photo
               photoType:(LTPhotoType)type
              typedImage:(void(^)(UIImage *typedImage))typed{
    
    __block UIImage * returnImage = nil;
    tyed_async(^{
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
        CGSize photoSize = [LTTypingPhoto getPhotoSizeWithPhotoType:type];
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
            refPhoto = [LTTypingPhoto rotateImageWithImage:photo];
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
        CGContextSetRGBFillColor(context, 1, 1, 1, 1);
        CGContextFillRect(context, CGRectMake(0, 0, width, height));
        //        CGContextStrokePath(context);
        
        CGImageRef tiaoMaImage = [LTTypingPhoto generateBarCodeImage:@"12345678901234567890"];
        
        
        
        CGImageRef HClpImage = [LTTypingPhoto drawHClpLineWith:clpLineWidth height:outheight imageHeigh:photoSize.height HCount:VHcount maginWidth:maginWidth sepLineWidth:sepWidth];
        
        //左边剪裁标志线
        CGContextDrawImage(context, CGRectMake( clpLineWidth / 2 , codeHeight + clpLineHeight, clpLineWidth / 2, outheight), HClpImage);
        //右边剪裁标志线
        CGContextDrawImage(context, CGRectMake(maginWidth * 2 + clpLineWidth  + lineWidth, codeHeight + clpLineHeight, clpLineWidth / 2, outheight), HClpImage);
        
        CGImageRef VClpImage = [LTTypingPhoto drawHVlpLineWithHeight:clpLineHeight width:lineWidth imageWidth:photoSize.width VCount:VVcount maginWidth:maginWidth sepLineWidth:sepWidth];
        
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
        
        CGImageRef lineImage = [LTTypingPhoto drowimageLineWithImage:refPhoto width:photoSize.width height:photoSize.height sepLineWidth:sepWidth outWidth:lineWidth count:VVcount];
        CGImageRef contentImage = [LTTypingPhoto drawContentWithLineImage:lineImage lineHeight:photoSize.height lineWidth:lineWidth sepLineWidth:sepWidth outHeight:outheight lineCount:VHcount];
        
        CGContextDrawImage(context, CGRectMake(maginWidth + clpLineWidth, codeHeight + clpLineHeight, lineWidth, outheight), contentImage);
        
        CGImageRef refImage = CGBitmapContextCreateImage(context);
        //    self.imageView.image = [UIImage imageWithCGImage:refImage];
        
        returnImage = [UIImage imageWithCGImage:refImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            typed(returnImage);
        });
        
    });
    //    return returnImage;
    
    
}

+ (CGImageRef)drawHClpLineWith:(CGFloat)width
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
+ (CGImageRef)drawHVlpLineWithHeight:(CGFloat)width
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

+ (CGImageRef)drawContentWithLineImage:(CGImageRef)lineImage
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
+ (CGImageRef )drowimageLineWithImage:(CGImageRef)image
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
+ (CGImageRef)rotateImageWithImage:(UIImage *)image{
    
    return [LTTypingPhoto image:image rotation:UIImageOrientationRight];
    
}

+ (CGImageRef )image:(UIImage *)image rotation:(UIImageOrientation)orientation {
    
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
+ (NSString *)stringWithCharmCount:(NSString *)str
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
+ (CGImageRef )generateBarCodeImage:(NSString *)source

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
/// 获取照片尺寸
/// @param type 照片类型
+ (CGSize)getPhotoSizeWithPhotoType:(LTPhotoType)type{
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

+ (UIImage *)drawWatherWithImage:(UIImage *)image
                       watherSte:(NSString *)str{
    return [LTTypingPhoto draWatherWithImage:image watherStr:str color:[UIColor redColor] font:[UIFont systemFontOfSize:38] angle:M_PI_4];
}

+ (UIImage *)draWatherWithImage:(UIImage *)image
                      watherStr:(NSString *)str
                          color:(UIColor *)color
                           font:(UIFont *)font
                          angle:(CGFloat)angle{
    CGContextRef content = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 8,
                                                 0,
                                                 CGColorSpaceCreateDeviceRGB(),
                                                 kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Big);
    [LTTypingPhoto drawMaskWithString:str context:content radius:0 angle:0 colour:color font:font slantAngle:angle size:image.size];
    return [UIImage new];
}

+ (void) drawMaskWithString:(NSString *)str context:(CGContextRef)context radius:(CGFloat)radius angle:(CGFloat)angle colour:(UIColor *)colour font:(UIFont *)font slantAngle:(CGFloat)slantAngle size:(CGSize)size{
    // *******************************************************
    // This draws the String str centred at the position
    // specified by the polar coordinates (r, theta)
    // i.e. the x= r * cos(theta) y= r * sin(theta)
    // and rotated by the angle slantAngle
    // *******************************************************
    
    // Set the text attributes
    NSDictionary *attributes = @{NSForegroundColorAttributeName:colour,
                                 NSFontAttributeName:font};
    // Save the context
    CGContextSaveGState(context);
    // Undo the inversion of the Y-axis (or the text goes backwards!)
    CGContextScaleCTM(context, 1, -1);
    // Move the origin to the centre of the text (negating the y-axis manually)
    CGContextTranslateCTM(context, radius * cos(angle), -(radius * sin(angle)));
    // Rotate the coordinate system
    CGContextRotateCTM(context, -slantAngle);
    // Calculate the width of the text
    CGSize offset = [str sizeWithAttributes:attributes];
    // Move the origin by half the size of the text
    CGContextTranslateCTM (context, -offset.width / 2, -offset.height / 2); // Move the origin to the centre of the text (negating the y-axis manually)
    // Draw the text
    
    NSInteger width  = ceil(cos(slantAngle)*offset.width);
    NSInteger height = ceil(sin(slantAngle)*offset.width);
    
    NSInteger row    = size.height/(height+100.0);
    NSInteger coloum = size.width/(width+100.0)>6?:6;
    CGFloat xPoint   = 0;
    CGFloat yPoint   = 0;
    for (NSInteger index = 0; index < row*coloum; index++) {
        
        xPoint = (index%coloum) *(width+100.0)-[UIScreen mainScreen].bounds.size.width;
        yPoint = (index/coloum) *(height+100.0);
        [str drawAtPoint:CGPointMake(xPoint, yPoint) withAttributes:attributes];
        xPoint += -[UIScreen mainScreen].bounds.size.width;
        yPoint += -[UIScreen mainScreen].bounds.size.height;
        [str drawAtPoint:CGPointMake(xPoint, yPoint) withAttributes:attributes];
    }
    
    // Restore the context
    CGContextRestoreGState(context);
}

@end
