//
//  CommonUtil.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "CommonUtil.h"
#import <sys/utsname.h>
#import <sys/sysctl.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AdSupport/AdSupport.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@implementation CommonUtil

+(void)save:(id)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)getValueFromKey:(NSString *)key{
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return value;
}

+(void)removeValueForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIViewController *)topViewController{
    UIViewController *resultVC;
    UIViewController *ctl = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    if ([ctl isKindOfClass:[UINavigationController class]]) {
        resultVC = [(UINavigationController *)ctl topViewController];
    } else if ([ctl isKindOfClass:[UITabBarController class]]) {
        resultVC = [(UITabBarController *)ctl selectedViewController];
    } else {
        resultVC = ctl;
    }
    
    while (resultVC.presentedViewController) {
        resultVC = resultVC.presentedViewController;
    }
    return resultVC;
}

+ (UIViewController*)currentViewController{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+(void)showAlertWithOneButton:(NSString *)title message:(NSString *)msg buttonTitle:(NSString *)btn leftBlock:(void(^)())leftBlock{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:btn style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        leftBlock();
        [[CommonUtil topViewController] setNeedsStatusBarAppearanceUpdate];
    }];
    
    [alertCtl addAction:leftAction];;
    
    [[CommonUtil topViewController] presentViewController:alertCtl animated:YES completion:nil];
}

+(UIAlertController *)showAlertWithTwoButton:(NSString *)title message:(NSString *)msg leftbuttonTitle:(NSString *)leftbtn leftBlock:(void(^)())leftBlock rightButtonTitle:(NSString *)rightButton rightBlock:(void(^)())rightBlock{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftbtn style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        leftBlock();
        [[CommonUtil topViewController] setNeedsStatusBarAppearanceUpdate];
    }];
    
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        rightBlock();
        [[CommonUtil topViewController] setNeedsStatusBarAppearanceUpdate];
    }];
    
    [alertCtl addAction:leftAction];
    [alertCtl addAction:rightAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CommonUtil topViewController] presentViewController:alertCtl animated:YES completion:^{
        }];
    });
    return alertCtl;
}

+ (NSString*)getPreferredLanguage{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    [self save:preferredLang forKey:@"language"];
    return preferredLang;
}

+(void)showActionSheetViewWithTitle:(NSString *)title msg:(NSString *)msg actionTitle:(NSString *)action1 andAction:(void(^)(UIAlertAction *action))actionBlock cancelAction:(NSString *)cancelTitle otherAction:(NSArray<NSString *> *)titleArr andOtherActionBlock:(NSArray <void(^)(UIAlertAction *action) > *)blockArray{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    if (action1) {
        UIAlertAction *first = [UIAlertAction actionWithTitle:action1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            actionBlock(action);
        }];
        [alertCtl addAction:first];
    }
    
    [alertCtl addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    if (titleArr.count > 0) {
        for (NSInteger i = 0; i<titleArr.count; i++) {
            [alertCtl addAction:[UIAlertAction actionWithTitle:titleArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (blockArray.count == 1) {
                    blockArray[0](action);
                }else{
                    blockArray[i](action);
                }
            }]];
        }
    }
//    [[CommonUtil topViewController].view bringSubviewToFront:alertCtl.view];
    [[CommonUtil topViewController] presentViewController:alertCtl animated:YES completion:nil];
}

+(UIImageView *)createImageWithSuper:(UIView *)view imageName:(NSString *)name mode:(UIViewContentMode)mode size:(void(^)(MASConstraintMaker *make))maker{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = mode;
    imageView.layer.masksToBounds = YES;
    if (name.length > 0) {
        imageView.image = [UIImage imageNamed:name];
    }
    [view addSubview:imageView];
    [imageView mas_makeConstraints:maker];
    return imageView;
}

+(UILabel *)createLabelWithSuper:(UIView *)view fontSize:(UIFont *)font text:(NSString *)text color:(UIColor *)color size:(void(^)(MASConstraintMaker *make))maker{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;
    label.font = font;
    [view addSubview:label];
    [label mas_makeConstraints:maker];
    return label;
}

+(UIView *)addLineForView:(UIView *)view lineColor:(UIColor *)color andMasonry:(void(^)(MASConstraintMaker *make))maker{
    UIView *line = [UIView new];
    line.backgroundColor = color;
    [view addSubview:line];
    [line mas_makeConstraints:maker];
    return line;
}

+(UIButton *)createBottomButtonFor:(UIView *)view andTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:0];
    btn.backgroundColor = ColorRGB(65, 140, 255);
    [btn setTitle:title forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = FONTSize(16) ;
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(view);
        make.height.mas_equalTo(50);
    }];
    return btn;
}

+(UIButton *)createButtonForView:(UIView *)view withButtonDetail:(void(^)( UIButton *sender))btnBlock andMasonry:(void(^)(MASConstraintMaker *make))maker andEvent:(void(^)(void))eventBlock{
    UIButton *btn = [UIButton buttonWithType:0];
    btnBlock(btn);
    [view addSubview:btn];
    [btn mas_makeConstraints:maker];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        eventBlock();
    }];
    return btn;
}

+ (NSString *)iphoneType{//
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"] ||
        [platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"] ||
        [platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";//iPhone11
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";//iPhone11Pro
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";//iPhone 11 Pro Max

    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    return platform;
}

//获取本地视频预览图
+(UIImage *)getLocalThumbnailImage:(NSURL *)videoURL{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;//按正确方向对视频进行截图,关键点是将AVAssetImageGrnerator对象的appliesPreferredTrackTransform属性设置为YES。
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

+(UIImage *)getNetThumbnailImage:(NSString *)videoURL completion:(void(^)(UIImage *image))block{
    SDImageCache *catch = [SDImageCache sharedImageCache];
    [catch queryCacheOperationForKey:videoURL done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
        if (image) {
            block(image);
        }else{
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
                AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
                gen.appliesPreferredTrackTransform = YES;
                CMTime time = CMTimeMakeWithSeconds(0.0, 600);
                NSError *error = nil;
                CMTime actualTime;
                CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
                UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
                CGImageRelease(image);
                [catch storeImageToMemory:thumb forKey:videoURL];
                block(thumb);
            });
        }
    }];
    return nil;
}

+ (NSDictionary *)deviceInfo{
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *uuid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return @{@"brand":@"iPhone",@"phonetype":[CommonUtil iphoneType],@"systemversion":[[UIDevice currentDevice] systemVersion],@"appversion":version,@"uuid":uuid};
}


@end
