//
//  NetWorkTool.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "NetWorkTool.h"

@interface NetWorkTool()

ProStrong AFHTTPSessionManager *manager;
ProCopy void(^succBlock)(id data);
ProCopy void(^failBlock)(NSInteger code,NSString *msg);

@end

@implementation NetWorkTool

+(instancetype)shareToolManager{
    static dispatch_once_t onceToken;
    static NetWorkTool *tool = nil;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 10.f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _manager;
}

-(NSString *)configUrl:(NSString *)link{
    if (![link hasPrefix:@"http"]) {
        return [NSString stringWithFormat:@"%@%@",[CommonModel shareInstance].hostUrl,link];
    }else{
        return link;
    }
}

-(void)requestWithMethod:(RequestType)type param:(NSDictionary *)dic url:(NSString *)link andComplete:(void(^)(id resp))succBlock fail:(void(^)(NSInteger code,NSString *msg))failBlock{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"无网络，请查看网络设置");
            return;
        }
    }];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValuesForKeysWithDictionary:dic];
    [param setValuesForKeysWithDictionary:[CommonUtil deviceInfo]];
    param[@"token"] = @"";
    param[@"timestamp"] = [NSString stringWithFormat:@"%ld",time(NULL)];
    param[@"key"] = requestValidKey;
    param[@"sign"] = [NSString md5:[NSString stringWithFormat:@"%@%@%@",[NSString md5:[NSString stringWithFormat:@"%ld",time(NULL)]],requestValidKey,requestDomain]];
    if (!param[@"token"] && !EqualNullString([CommonModel shareInstance].userRecord.token)) {
        param[@"token"] = [CommonModel shareInstance].userRecord.token;
    }
    
    self.succBlock = succBlock;
    self.failBlock = failBlock;
    
    if (type == Post) {
        [[NetWorkTool shareToolManager].manager POST:[[NetWorkTool shareToolManager] configUrl:link] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleResponse:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error.description);
        }];
    }else{
        
    }
}

-(void)handleResponse:(id)response{
    BaseRecord *record = [BaseRecord mj_objectWithKeyValues:response];
    if (record.code == 200) {
        self.succBlock(record.data);
    }else if (record.code == 100203){
        [CommonUtil showAlertWithTwoButton:@"下线通知" message:record.msg leftbuttonTitle:@"退出" leftBlock:^{
            
        } rightButtonTitle:@"重新登录" rightBlock:^{
            
        }];
    }else if (record.code == 100215 || record.code == 100216 || record.code == 100217){
        [CommonUtil showAlertWithTwoButton:@"通知" message:record.msg leftbuttonTitle:@"退出" leftBlock:^{
            
        } rightButtonTitle:@"重新登录" rightBlock:^{
            
        }];
    }else{
        NSLog(@"%@",record.msg);
        self.failBlock(record.code,record.msg);
    }
}

@end
