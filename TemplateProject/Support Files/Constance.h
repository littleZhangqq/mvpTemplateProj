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
#define IMAGE_HOST @"https://yiqi-shenyang-test.oss-cn-beijing.aliyuncs.com/"
#define BucketName @"yiqi-shenyang-test"

#else
#define APP_HOST @"https://api.lnyqcm.com/v2/"
#define IMAGE_HOST @"https://yiqi-shenyang.oss-cn-beijing.aliyuncs.com/"
#define BucketName @"yiqi-shenyang"

#endif

#if DEBUG
#define NSLog(...) printf("%s\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define SAFE_AREA_TOP ((iPhoneX || iPhoneXM || iPhoneXR)? 88.f:64.f)
#define SAFE_AREA_BOTTOM ((iPhoneX || iPhoneXM || iPhoneXR) ? 83.f:49.f)
#define SAFE_BOTTOM ((iPhoneX || iPhoneXM || iPhoneXR) ? SCREEN_HEIGHT - 88 - 83: SCREEN_HEIGHT - 64 - 49)
#define BOTTOM ((iPhoneX || iPhoneXM || iPhoneXR) ? 34 : 0)
#define TOP ((iPhoneX || iPhoneXM || iPhoneXR) ? 24 :0)
#define DHTOP ((iPhoneX || iPhoneXM || iPhoneXR) ? 44 :20)

#define MainWidthScale [UIScreen mainScreen].bounds.size.width/375
#define DesignWidth 375.0f
#define ScaleTransForm CGAffineTransformMakeScale(MainWidthScale, MainWidthScale)
#define LineColor    RGBCOLOR(230,230,230)//分割线 6


#define VERSION_INFO_CURRENT @"currentversion"


#define LocalImage(a)  [UIImage imageNamed:a]

#define ProStrong @property (nonatomic, strong)
#define ProUnsafe @property (nonatomic, unsafe_unretained)
#define ProWeak @property (nonatomic, weak)
#define ProCopy @property (nonatomic, copy)

#define ProLabel(a) @property (nonatomic, strong) UILabel *a;
#define ProImageView(a) @property (nonatomic, strong) UIImageView *a;
#define ProButton(a) @property (nonatomic, strong) UIButton *a;
#define ProView(a) @property (nonatomic, strong) UIView *a;
#define ProTableView(a) @property (nonatomic, strong) UITableView *a;
#define ProScrollView(a) @property (nonatomic, strong) UIScrollView *a;

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF    __weak typeof(self) weakSelf = self;
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf;

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

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
#define BottomSafeHeight (isiPhoneXSeries?34.0f:0.0f) //底部安全高度

#define appMPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])

// 是否大于IOS11
#define isIOS11                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=11.0)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define COLOR_RGB(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]


//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]
//一些缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

#define buildMVPInControllerH(presenterCls)   @property (nonatomic, strong) presenterCls *presenter;
#define buildMVPInControllerM   @dynamic presenter;

#define buildMVPInPresenterH(recordCls)   @property (nonatomic, strong) recordCls *record;
#define buildMVPInPresenterM   @dynamic record;

#endif /* Constance_h */
