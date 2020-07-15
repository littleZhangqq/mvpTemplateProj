//
//  AppDelegate+Service.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "AppDelegate+Service.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UMAnalytics/MobClick.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "RootTabbarViewController.h"

@interface AppDelegate()<WXApiDelegate>

@end

@implementation AppDelegate (Service)

- (void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = COLOR(whiteColor);
    [self.window makeKeyAndVisible];
    [CommonModel shareInstance].showAd = @(1);
    [CommonModel shareInstance].adCache = @"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg";
    BOOL showAd = [[CommonModel shareInstance].alreadyLogin boolValue] && [CommonModel shareInstance].adCache && [[CommonModel shareInstance].showAd boolValue];
    if (showAd) {
        [self showAd];
    }else if(![[CommonModel shareInstance].alreadyLogin boolValue]){
        [self showLaunchScroll];
    }else{
        self.window.rootViewController = [[RootTabbarViewController alloc] init];
    }
}

- (void)configThirdPlatform{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
        manager.enable = YES;
        manager.shouldResignOnTouchOutside = YES;
        manager.shouldToolbarUsesTextFieldTintColor = YES;
        manager.keyboardDistanceFromTextField = 80;
        manager.enableAutoToolbar = YES;
        
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:wxAppKey appSecret:wxAppSecret redirectURL:nil];
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:qqAppKey  appSecret:qqAppSecret redirectURL:nil];
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:sinaAppKey  appSecret:sinaAppSecret redirectURL:redirectURL];
        
        [WXApi registerApp:wxAppKey];
//        [UMConfigure initWithAppkey:umAppKey channel:APPTYPE == 0 ?@"TEST":@"App Store"];
        [MobClick setScenarioType:E_UM_NORMAL];
        [MobClick setCrashReportEnabled:YES];
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        [self configPushService];
    });
}

-(void)showLaunchScroll{
    self.window.rootViewController = [NSClassFromString(@"LaunchScrollViewController") new];
}

-(void)showAd{
    self.window.rootViewController = [NSClassFromString(@"ADShowViewController") new];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self alipayHandleResult:[resultDic[@"resultStatus"] integerValue]];
        }];
        return YES;
    }else if ([url.host isEqualToString:@"pay"]){
        return [WXApi handleOpenURL:url delegate:self];
    }else{
    }
    return YES;
}

#pragma mark 微信支付的代理方法//MARK:支付宝支付回调
- (void)onResp:(BaseResp *)resp{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d",resp.errCode];
    if ([resp isKindOfClass:[PayResp class]]) {
        // 支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:
                strMsg =@"支付成功";
                break;
            case WXErrCodeCommon:
                strMsg =@"普通错误";
                break;
            case WXErrCodeUserCancel:
                strMsg =@"取消支付";
                break;
            case WXErrCodeSentFail:
                strMsg =@"发送失败";
                break;
            case WXErrCodeUnsupport:
                strMsg =@"微信不支持";
                break;
            case WXErrCodeAuthDeny:
                strMsg =@"授权失败";
                break;
            default:
                break;
        }
        NSLog(@"strMsg");
    }
}

#pragma mark 支付宝支付回调
-(void)alipayHandleResult:(NSInteger)code{
    switch (code) {
        case 9000:
            NSLog(@"支付宝支付成功");
            break;
        case 8000:
            NSLog(@"正在处理中")
            break;
        case 4000:
            NSLog(@"订单支付失败");
            break;
        case 5000:
            NSLog(@"重复请求");
            break;
        case 6001:
            NSLog(@"中途取消");
            break;
        case 6002:
            NSLog(@"网络连接出错");
            break;
        case 6004:
            NSLog(@"请查询商户订单列表中订单的支付状态");
            break;
        default:
            NSLog(@"其它支付错误");
            break;
    }
}

@end
