//
// LTIMConfigDefine.h
// qianXun
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2018/10/16.
// Copyright © 2018年 LTOVE. All rights reserved.
//
    

#ifndef LTIMConfigDefine_h
#define LTIMConfigDefine_h

//################信鸽#########


#define ColorRightBar [UIColor color333333]
#define greenRightBar [UIColor colorWithOx:@"#43ab2e"]
#define bluecolor [UIColor colorWithRed:67 /255.0 green:142.0 / 255 blue:219.0 /255 alpha:1]
// magin

#define maginLeft 10
#define maginRight -10
#define maginTop 10
#define maginButtom -10

#define roomServer @"conference"
#define headCacheTime 3600 //头像缓存时间  s
#define noInfoViewOffset -60
#define searchBarHight 55.0f
#pragma mark -notificationWithName
#define DidReceiveIq @"didreceiveiq"
#define DidReceiveInviteReply @"inviReply"
#define netStatusKey @"netStatusKey"
// tabBar
#define HearImageHeightAndWidth 45

// 字体

#define LTTitleFont [UIFont systemFontOfSize:17]
#define LTsubTitleFont [UIFont systemFontOfSize:15]
#define LTthreeTitleFont [UIFont systemFontOfSize:13]
// 字体颜色

#define LTtitleColor [UIColor colorWithRead:0 green:0 blue:0]
#define LTsubtitleColor [UIColor colorWithRead:102 green:102 blue:102]
#define LTthreetitleColor [UIColor colorWithRead:142 green:142 blue:147]
// home Alert Menu
#define HomeAlertMenuColor [UIColor colorWithRead:62 green:59 blue:77]
#define HomeAlertMenuWidth 127

#define HomeAlertMenuTitleColor [UIColor colorWithRead:254 green:254 blue:254]
#define HomeAlertMenuTitleFont [UIFont systemFontOfSize:14]
#define HomeAlertMenuCellHeight 30

#define GrayBackTableGround [UIColor colorWithRead:235 green:235 blue:235]
#define GrayBackGround [UIColor colorWithRead:245 green:245 blue:246]
#define GrayLineColor [UIColor colorWithRead:221 green:221 blue:221]
#define GrayTextColor [UIColor colorWithRead:101 green:101 blue:101]
//head icon
#define HeadIconBackGroundColor [UIColor colorWithRead:218 green:219 blue:221]

#define QXseparatorColor [UIColor colorWithOx:@"#d7d7d7"]









//#define     IS_IPHONEX              ([UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f)

#pragma mark - # 屏幕尺寸
#define     SCREEN_SIZE                 [UIScreen mainScreen].bounds.size
//#define     SCREEN_WIDTH                SCREEN_SIZE.width
//#define     SCREEN_HEIGHT               SCREEN_SIZE.height

#pragma mark - # 常用控件高度
#define     SEARCHBAR_HEIGHT            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0") ? 52.0f : 44.0f)
#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#define     SAFEAREA_INSETS     \
({   \
UIEdgeInsets edgeInsets = UIEdgeInsetsZero; \
if (@available(iOS 11.0, *)) {      \
edgeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;     \
}   \
edgeInsets;  \
})\

#define     SAFEAREA_INSETS_BOTTOM      (SAFEAREA_INSETS.bottom)

//#pragma mark - # 设备(屏幕)类型
//#define     SCRREN_IPHONE4              (SCREEN_HEIGHT >= 480.0f)           // 320 * 480
//#define     SCRREN_IPHONE5              (SCREEN_HEIGHT >= 568.0f)           // 320 * 568
//#define     SCRREN_IPHONE6              (SCREEN_HEIGHT >= 667.0f)           // 375 * 667
//#define     SCRREN_IPHONE6P             (SCREEN_HEIGHT >= 736.0f)           // 414 * 736


#pragma mark - # 系统方法简写
/// 广播中心
#define     TLNotificationCenter        [NSNotificationCenter defaultCenter]
/// 用户自定义数据
#define     TLUserDefaults              [NSUserDefaults standardUserDefaults]
/// URL
#define     TLURL(urlString)            [NSURL URLWithString:urlString]
/// 图片
#define     TLImage(imageName)          (imageName ? [UIImage imageNamed:imageName] : nil)
#define     TLPNG(X)                    [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"png"]]
#define     TLJPG(X)                    [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"jpg"]]
/// 字符串
#define     TLNoNilString(str)          (str.length > 0 ? str : @"")
/// 方法名
#define     TLStirngFormSelector(s)     [[NSString alloc] initWithUTF8String:sel_getName(s)]
/// 颜色
#define     RGBColor(r, g, b)           [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define     RGBAColor(r, g, b, a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define     HexColor(color)             [UIColor colorWithRed:((float)((color & 0xFF0000) >> 16))/255.0 green:((float)((color & 0xFF00) >> 8))/255.0 blue:((float)(color & 0xFF))/255.0 alpha:1.0]
#define     HexAColor(color, a)         [UIColor colorWithRed:((float)((color & 0xFF0000) >> 16))/255.0 green:((float)((color & 0xFF00) >> 8))/255.0 blue:((float)(color & 0xFF))/255.0 alpha:a]

/// 国际化
#define     LOCSTR(str)                 NSLocalizedString(str, nil)


#pragma mark - # 快捷方法
/// PushVC
#define     PushVC(vc)                  {\
[vc setHidesBottomBarWhenPushed:YES];\
[self.navigationController pushViewController:vc animated:YES];\
}

/// 方法交换
#define     TLExchangeMethod(oldSEL, newSEL) {\
Method oldMethod = class_getInstanceMethod(self, oldSEL);\
Method newMethod = class_getInstanceMethod(self, newSEL);\
method_exchangeImplementations(oldMethod, newMethod);\
}\

#pragma mark - # 多线程
#define     TLBackThread(block)         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define     TLMainThread(block)         dispatch_async(dispatch_get_main_queue(), block)
#define     TLMainBarrier(block)        dispatch_barrier_async(dispatch_get_main_queue(), block)
#define     TLMainAfter(x, block)       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_main_queue(), block);

#pragma mark - # 循环引用消除
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object)     autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object)     autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object)     try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object)     try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object)   autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object)   autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object)   try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object)   try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
#define     TLWeakSelf(type)            __weak typeof(type) weak##type = type;
#define     TLStrongSelf(type)          __strong typeof(type) strong##type = type;

#pragma mark - # XCode
#define     XCODE_VERSION_8_LATER       __has_include(<UserNotifications/UserNotifications.h>)

#pragma mark - # 系统版本
#define     SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define     SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define     SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define     SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#endif /* LTIMConfigDefine_h */
