//
//  QXGlobalMacro_h.h
//  QXun_iOS
//
//  Created by __无邪_ on 2018/11/6.
//  Copyright © 2018 __无邪_. All rights reserved.
//

#ifndef QXGlobalMacro_h_h
#define QXGlobalMacro_h_h

#define IS_IPHONEX \
({BOOL isNotchScreen = NO;\
if (@available(iOS 11.0, *)) {\
isNotchScreen = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isNotchScreen);})

//#define IS_IPHONEX ({BOOL isNotchScreen = NO;\
//    if (@available(iOS 11.0, *)) {isNotchScreen = !(UIEdgeInsetsEqualToEdgeInsets([[UIApplication sharedApplication] delegate].window.safeAreaInsets, UIEdgeInsetsZero));\
//    }\
//    (isNotchScreen);})

// 只代表屏幕尺寸大小，不代表具体设备
#define IS_IPHONE4      ((int)[UIScreen mainScreen].bounds.size.height == 480)//320w
#define IS_IPHONE5      ((int)[UIScreen mainScreen].bounds.size.height == 568)//320w
#define IS_IPHONE6      ((int)[UIScreen mainScreen].bounds.size.height == 667)//375w
#define IS_IPHONE_PLUS  ((int)[UIScreen mainScreen].bounds.size.height == 736)//414w
#define IS_IPHONEX_SERIES IS_IPHONEX

/// 操作系统版本号，只获取第二级的版本号，例如 10.3.1 只会得到 10.3
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])

// 是否横竖屏
// 用户界面横屏了才会返回YES
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
// 无论支不支持横屏，只要设备横屏了，就会返回YES
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

// 屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

// 屏幕宽度，跟横竖屏无关
#define DEVICE_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define DEVICE_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)


// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算)
#define STATUS_BAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
// navigationBar相关frame
#define NAV_BAR_HEIGHT (IS_LANDSCAPE ? 32 : 44)
#define NAVandSTATUS_BAR_HEIHGT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
#define TAB_BAR_HEIGHT ((IS_IPHONEX ? (IS_LANDSCAPE ? 53 : 83) : (IS_LANDSCAPE ? 32 : 44)))
#define DANGER_BOTTOM_AREA_HEIGHT ((IS_IPHONEX ? (IS_LANDSCAPE ? 32 : 34) : (IS_LANDSCAPE ? 0 : 0)))


#define QXPixelOne (1 / [[UIScreen mainScreen] scale])

#define UIFontMake(size) [UIFont systemFontOfSize:size]
#define UIFontItalicMake(size) [UIFont italicSystemFontOfSize:size] // 斜体只对数字和字母有效，中文无效
#define UIFontBoldMake(size) [UIFont boldSystemFontOfSize:size]
#define UIFontBoldWithFont(_font) [UIFont boldSystemFontOfSize:_font.pointSize]
#define UIColorMake(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]


#define WeakObject(obj)   __weak typeof(obj) weakObject = obj;
#define StrongObject(obj) __strong typeof(obj) strongObject = weakObject;
#define WS(weakSelf)      __weak __typeof(&*self)weakSelf = self;


#define SafeStr(str)          (str.length > 0 ? str : @"")
#define NumStr(num)           [NSString stringWithFormat:@"%@",@(num)]

/////////// 国际化

#define i18n_Text(key)  NSLocalizedString(key,"")


////////// 单例
// .h
#define singleton_interface(class) + (instancetype)shared##class;

// .m
#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
if (_instance == nil) { \
_instance = [[class alloc] init]; \
} \
\
return _instance; \
}

/////////// 标识

#define ApplicationUUID @"QXAPPUUID" //每次第一次安装会生成一个设备标识，用于消息同步
#define AudioPlayerWhisperIdentifier @"AudioPlayerWhisperIdentifier" //是否开启听筒播放
#define MSGSyncSeqID @"MSGSyncSeqID" //消息同步ID

/////////// 日志

static const NSUInteger ddLogLevel = DDLogLevelAll;//定义日志级别

//DDLogError(@"DDLogError");      // red
//DDLogWarn(@"DDLogWarn");        // orange
//DDLogDebug(@"DDLogDebug");      // green
//DDLogInfo(@"DDLogInfo");        // pink
//DDLogVerbose(@"DDLogVerbose");  // gray

////复杂点的
//#ifdef DEBUG
//#define NSLog(format, ...) do { \
//fprintf(stderr, "<%s : %d> %s\n", \
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
//__LINE__, __func__); \
//(NSLog)((format), ##__VA_ARGS__); \
//fprintf(stderr, \
//"\n" \
//);} while (0)
//#else
//#define NSLog(...)
//#endif

////简单点的
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s[%d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...)
#endif


//BLYLogError(fmt, ...)
//BLYLogWarn(fmt, ...)
//BLYLogInfo(fmt, ...)
//BLYLogDebug(fmt, ...)
//BLYLogVerbose(fmt, ...)




#endif /* QXGlobalMacro_h_h */
