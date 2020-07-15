//
//  ExternMarco.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExternMarco : NSObject
//保存各个平台SDK的接入key等,部分常用枚举，结构体，及部分特殊用途数据
//一键登录secret
UIKIT_EXTERN NSString *const oneKeyLoginSecret;

//网络请求验证key
UIKIT_EXTERN NSString *const requestValidKey;

//网络请求验证域名
UIKIT_EXTERN NSString *const requestDomain;

//阿里oss提交key
UIKIT_EXTERN NSString *const aliAccessKey;

//阿里oss提交secret
UIKIT_EXTERN NSString *const aliAccessSecret;

//阿里oss提交域名
UIKIT_EXTERN NSString *const aliEndPoint;

//识别SDK的ak
UIKIT_EXTERN NSString *const aipRecognizeAK;

//识别SDK的sk
UIKIT_EXTERN NSString *const aipRecognizeSK;

//微信APPID
UIKIT_EXTERN NSString *const wxAppKey;

//微信APPsecret
UIKIT_EXTERN NSString *const wxAppSecret;

//qqAPPID
UIKIT_EXTERN NSString *const qqAppKey;

//qqAPPsecret
UIKIT_EXTERN NSString *const qqAppSecret;

//微博APPID
UIKIT_EXTERN NSString *const sinaAppKey;

//微博APPsecret
UIKIT_EXTERN NSString *const sinaAppSecret;

//分享回调URL
UIKIT_EXTERN NSString *const redirectURL;

//友盟APPkey
UIKIT_EXTERN NSString *const umAppKey;

//高德地图appkey
UIKIT_EXTERN NSString *const aMapKey;

//极光推送key
UIKIT_EXTERN NSString *const jPushAppKey;

//启动滑动宣传图
UIKIT_EXTERN NSArray *launchScrollImages;

//启动广告页倒计时长
UIKIT_EXTERN NSInteger adShowTime;

@end

NS_ASSUME_NONNULL_END
