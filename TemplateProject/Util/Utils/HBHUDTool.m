//
//  HBHUDTool.m
//  xffpClient
//
//  Created by xfdc_003 on 2017/5/5.
//  Copyright © 2017年 com. xfdc. All rights reserved.
//

#import "HBHUDTool.h"

//  提示类型
typedef NS_ENUM(NSInteger, LCProgressHUDType){
    HBProgressHUDTypeJHLoading,                 //菊花
    HBProgressHUDTypeOnlyText,                  //文字底部显示
    HBProgressHUDTypeOnlyTextCenter,            //文字中间显示
    HBProgressHUDTypeSuccess,                   //成功
    HBProgressHUDTypeError,                     //失败
    HBProgressHUDTypeCustomAnimation            //自定义加载动画（序列帧实现）
};


@implementation HBHUDTool



+ (instancetype)shareInstance{
    
    static HBHUDTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HBHUDTool alloc] init];
    });
    return instance;
}


+ (void)show:(NSString *)msg inView:(UIView *)view type:(LCProgressHUDType) mytype{
    
    [self show:msg inView:view type:mytype customImgView:nil];
}


+ (void)show:(NSString *)msg inView:(UIView *)view type:(LCProgressHUDType)mytype customImgView:(UIImageView *)customImgView{
    
    if ([HBHUDTool shareInstance].HUD != nil) {
        [[HBHUDTool shareInstance].HUD hideAnimated:NO];
        [HBHUDTool shareInstance].HUD = nil;
    }
    
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    if (view == nil) view = [[UIApplication sharedApplication] delegate].window;
    [HBHUDTool shareInstance].HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [HBHUDTool shareInstance].HUD.backgroundColor = [UIColor clearColor];
    
    //  是否设置黑色背景
    [HBHUDTool shareInstance].HUD.bezelView.backgroundColor = [UIColor blackColor];
    [HBHUDTool shareInstance].HUD.contentColor = [UIColor whiteColor];
    
    [[HBHUDTool shareInstance].HUD setRemoveFromSuperViewOnHide:YES];
    if(msg)[HBHUDTool shareInstance].HUD.detailsLabel.text = msg;
    [HBHUDTool shareInstance].HUD.detailsLabel.font = [UIFont systemFontOfSize:16];
    
    switch (mytype) {
            
        case HBProgressHUDTypeOnlyText:
            [HBHUDTool shareInstance].HUD.mode = MBProgressHUDModeText;
            [[HBHUDTool shareInstance].HUD setMargin:15];
            [HBHUDTool shareInstance].HUD.offset = CGPointMake(0.f, MBProgressMaxOffset);
            break;
            
        case HBProgressHUDTypeJHLoading:
            [HBHUDTool shareInstance].HUD.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case HBProgressHUDTypeSuccess:
            [HBHUDTool shareInstance].HUD.mode = MBProgressHUDModeCustomView;
            [HBHUDTool shareInstance].HUD.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            break;
            
        case HBProgressHUDTypeError:
            [HBHUDTool shareInstance].HUD.mode = MBProgressHUDModeCustomView;
            [HBHUDTool shareInstance].HUD.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            break;
            
        case HBProgressHUDTypeOnlyTextCenter:
            [HBHUDTool shareInstance].HUD.mode = MBProgressHUDModeCustomView;
            break;
            
        default:
            break;
    }
}




+ (void)show{
    [self show:nil inView:nil type:HBProgressHUDTypeJHLoading];
}


+ (void)showInView:(UIView *)view{
    [self show:nil inView:view type:HBProgressHUDTypeJHLoading];
}


+ (void)showProgress:(NSString *)msg{
    [self show:msg inView:nil type:HBProgressHUDTypeJHLoading];
}


+ (void)showMessage:(NSString *) msg{
    [self show:msg inView:nil type:HBProgressHUDTypeOnlyText];
    [[HBHUDTool shareInstance].HUD hideAnimated:YES afterDelay:3.0];
}


+ (void)showMessageCenter:(NSString *) msg{
    [self show:msg inView:nil type:HBProgressHUDTypeOnlyTextCenter];
    [[HBHUDTool shareInstance].HUD hideAnimated:YES afterDelay:2.0];
}


+ (void)showProgress:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view type:HBProgressHUDTypeJHLoading];
}


+ (void)hide{
    if ([HBHUDTool shareInstance].HUD != nil) {
        [[HBHUDTool shareInstance].HUD hideAnimated:YES];
    }
}


+ (void)hideDelayTime:(NSInteger)delay{
    if ([HBHUDTool shareInstance].HUD != nil) {
        [[HBHUDTool shareInstance].HUD hideAnimated:YES afterDelay:delay];
    }
}


+ (void)showMessage:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view type:HBProgressHUDTypeOnlyText];
    [[HBHUDTool shareInstance].HUD hideAnimated:YES afterDelay:3.0];
}


+ (void)showMessageCenter:(NSString *) msg inView:(UIView *)view{
    [self show:msg inView:view type:HBProgressHUDTypeOnlyTextCenter];
    [[HBHUDTool shareInstance].HUD hideAnimated:YES afterDelay:3.0];
//    [[HBHUDTool shareInstance].HUD.contentColor = [UIColor whiteColor];
    
}

+ (void)showSuccess:(NSString *)msg{
    [self show:msg inView:nil type:HBProgressHUDTypeSuccess];
    [[HBHUDTool shareInstance].HUD hideAnimated:YES afterDelay:3.0];
}


+ (void)showSuccess:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view type:HBProgressHUDTypeSuccess];
    [[HBHUDTool shareInstance].HUD hideAnimated:YES afterDelay:3.0];
}


+ (void)showError:(NSString *)msg{
    [self show:msg inView:nil type:HBProgressHUDTypeError];
    [[HBHUDTool shareInstance].HUD hideAnimated:YES afterDelay:3.0];
}


+ (void)showError:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view type:HBProgressHUDTypeError];
    [[HBHUDTool shareInstance].HUD hideAnimated:YES afterDelay:3.0];
}

+(void)showLoading{
    //多个请求同时发起，会有多个mbprogresshud。留最后一个，同时代码里保证不要让多个请求同时进行。否则叠起来是黑色的难看。
    for (UIView *view in kKeyWindow.subviews) {
        if ([view isKindOfClass:[MBProgressHUD class]]) {
            [view removeFromSuperview];
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = ColorRGBA(0, 0, 0, 0.6);
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.activityIndicatorColor = COLOR(whiteColor);
    [hud showAnimated:YES];
}

+(void)hideLoading{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:kKeyWindow];
    if (hud) {
        [hud hideAnimated:YES];
        [hud removeFromSuperview];
    }else{
        [MBProgressHUD hideHUDForView:kKeyWindow animated:YES];
    }
}

@end
