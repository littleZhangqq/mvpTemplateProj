//
//  Constance.h
//  TemplateProject
//
//  Created by admin on 2020/7/9.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#ifndef Constance_h
#define Constance_h

#if DEBUG
#define APP_HOST @"https://www.yiqijiayou00598.com/v2/"
#define IMAGE_HOST @""
#define BucketName @""

#else
#define APP_HOST @""
#define IMAGE_HOST @""
#define BucketName @""

#endif

#if DEBUG
#define NSLog(...) printf("%s\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define LocalImage(a)  [UIImage imageNamed:a]

#define ProStrong @property (nonatomic, strong)
#define ProUnsafe @property (nonatomic, unsafe_unretained)
#define ProWeak @property (nonatomic, weak)
#define ProCopy @property (nonatomic, copy)

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF    __weak typeof(self) weakSelf = self;
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf;

//字体适配调整
#define FONTSize(i) [UIFont systemFontOfSize:i]
#define FONT_BOLD(a) [UIFont boldSystemFontOfSize:a]
#define FONT_SC(a) [UIFont fontWithName:@"PingFang SC" size:a]
#define FONT_PingFangBold(a) [UIFont fontWithName:@"PingFangSC-Semibold" size:a]
#define FONT_CUSTOM(a) [UIFont fontWithName:@"PingFang-SC-Medium" size:a]
#define FONT_Regular(a) [UIFont fontWithName:@"PingFang-SC-Regular" size:a]

#define COLOR(Costom)         ([UIColor Costom])
#define NameColor(name)          ([UIColor colorNamed:name])
#define ColorRGB(R,G,B)     [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1.0f]
#define ColorRGBA(R,G,B,A)     [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

#define EqualString(a,b) [a isEqualToString:b]
#define EqualObj(a,b) [a isEqual:b]
#define EqualNullString(a) (!a || [a isEqualToString:@""])

#define isiPhoneX CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)
#define isiPhoneXSM CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)
#define isiPhoneXR CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size)
#define isiPhoneXSeries (isiPhoneX || isiPhoneXSM || isiPhoneXR)

#define kStatusBarHeight (isiPhoneXSeries?44.0f:20.0f)//状态栏高度
#define NavBarHeight 44.0f
#define kTabBarHeight (isiPhoneXSeries?83.0f:49.0f) //底部tabbar高度
#define NavHeight (kStatusBarHeight + NavBarHeight) //整个导航栏高度


#define COLOR_RGB(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]

#define kKeyWindow          [UIApplication sharedApplication].keyWindow

#define buildMVPInControllerH(presenterCls)   @property (nonatomic, strong) presenterCls *presenter;
#define buildMVPInControllerM   @dynamic presenter;

#define buildMVPInPresenterH(recordCls)   @property (nonatomic, strong) recordCls *record;
#define buildMVPInPresenterM   @dynamic record;

#endif /* Constance_h */
