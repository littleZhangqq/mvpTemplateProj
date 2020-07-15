//
//  CommonModel.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonModel : NSObject

#define CREATE_SETGET_UTILS_H(type,strongOrWeak,name) \
\
@property (nonatomic,strongOrWeak) type name;


//存储的账号密码
CREATE_SETGET_UTILS_H(NSString *, strong, accountNo);
CREATE_SETGET_UTILS_H(NSString *, strong, passWord);
CREATE_SETGET_UTILS_H(NSNumber *, strong, alreadyLogin);
CREATE_SETGET_UTILS_H(NSString *, strong, adCache);
CREATE_SETGET_UTILS_H(NSNumber *, strong, showAd);
CREATE_SETGET_UTILS_H(NSData *, strong, loginData);

+(instancetype)shareInstance;

// 后台服务器地址
@property (nonatomic, strong) NSMutableArray *hostArray;
// 当前使用的服务器地址
@property (nonatomic, copy) NSString *hostUrl;

@property (nonatomic, copy) NSString *imageHost;

@property (nonatomic, strong) UserRecord *userRecord;

@end

NS_ASSUME_NONNULL_END
