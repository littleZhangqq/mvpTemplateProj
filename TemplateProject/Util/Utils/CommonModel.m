//
//  CommonModel.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel

#define CREATE_SETGET_UTILS_M(type, param, upperFirstParam)  \
\
@synthesize param;                                      \
-(void)set##upperFirstParam:(type)p##param{                     \
param = p##param;                                           \
[CommonUtil save:param forKey:@#param];                             \
}                                                               \
\
-(type)param{                                                   \
if(!param){                                                 \
type saved = [CommonUtil getValueFromKey:@#param];                        \
if (saved) {                                            \
param = saved;                                      \
}                                                       \
}                                                           \
return param;                                               \
}

CREATE_SETGET_UTILS_M(NSString *,accountNo , AccountNo);
CREATE_SETGET_UTILS_M(NSString *, passWord, PassWord);
CREATE_SETGET_UTILS_M(NSNumber *, alreadyLogin, AlreadyLogin);
CREATE_SETGET_UTILS_M(NSString *, adCache, AdCache);
CREATE_SETGET_UTILS_M(NSNumber *, showAd, ShowAd);
CREATE_SETGET_UTILS_M(NSData *, loginData, LoginData);


+(instancetype)shareInstance{
    static CommonModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[self alloc] init];
    });
    return model;
}

-(NSMutableArray *)hostArray{
    if (!_hostArray) {
        _hostArray = @[
            @{@"name":@"正式环境",@"URL":@"https://api.lnyqcm.com/v2/",@"image":@"https://yiqi-shenyang.oss-cn-beijing.aliyuncs.com"},
            @{@"name":@"测试环境",@"URL":@"https://www.yiqijiayou00598.com/v2/",@"image":@"https://yiqi-shenyang-test.oss-cn-beijing.aliyuncs.com"},
            @{@"name":@"当前环境",@"URL":@"测试环境"}.mutableCopy
                       ].mutableCopy;
    }
    return _hostArray;
}

-(NSString *)hostUrl{
    if (!_hostUrl) {
        _hostUrl = APP_HOST;
    }
    return _hostUrl;
}

-(NSString *)imageHost{
    if (!_imageHost) {
        _imageHost = IMAGE_HOST;
        }

    return _imageHost;
}

- (UserRecord *)userRecord{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[CommonModel shareInstance].loginData];
}

@end
