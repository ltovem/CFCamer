//
//  HGHTTPConfiguration.h
//  HGInitiation
//
//  Created by __无邪_ on 2017/12/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

#ifndef HGHTTPConfiguration_h
#define HGHTTPConfiguration_h

#define kHTTPEnvironmentISTest 1   //0:正式服务器，1:测试服务器，2:本地

/********************下面是服务器接口地址********************/
#if (0 == kHTTPEnvironmentISTest)
#define BASE_API_URL @"https://qxmg.qdingnet.com/api/"
#define XMPPServerDomain @"qx.qdingnet.com"
#define XGAppId  2200320202
#define XGAppKey @"I2Q87GVYF14F"
#define XMPPServerPort 5222

#elif (1 == kHTTPEnvironmentISTest)
#define BASE_API_URL @"http://192.168.31.126/"
#define XMPPServerDomain @"dev-qxim.qdingnet.cn"
#define XGAppId  2200320202
#define XGAppKey @"I2Q87GVYF14F"
#define XMPPServerPort 5222

#else
#define BASE_API_URL @"http://10.39.73.150:8089/api/"
#define XMPPServerDomain @"10.39.73.150"
#define XGAppId  2200318792
#define XGAppKey @"I1874SZEXK7D"
#define XMPPServerPort 5222

#endif

#define XMPPMucService @"@conference." XMPPServerDomain

#define kCacheExpiryTimeForHTTPRequest 7 * 24 * 60 * 60;
#define kHTTPTimeoutIntervalForRequest 20
#define kBuglyAppKey @"0313e1b220"
#define kXunFeiAppKey @"5c0dcd81"
#define kBaiduAK @"W9c11fTmfBSjYQvwvAtAq4jGj9ibCUU6"

#define kSystemMessageTargetId @"admin"

#define misAppCodeApi @"https://mis-mmp.qdingnet.com/ajax/user/getAppCode"

#endif /* HGHTTPConfiguration_h */

