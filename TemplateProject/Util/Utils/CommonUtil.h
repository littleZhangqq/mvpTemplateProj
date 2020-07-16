//
//  CommonUtil.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

inline static void placeHolder(UITextField *view,NSString *holder,UIColor *color,UIFont *font){
    if (@available(iOS 13,*)) {
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:holder attributes:@{NSForegroundColorAttributeName : ColorRGB(173, 173, 173),NSFontAttributeName:font}];
        view.attributedPlaceholder = placeholderString;
    }else{
        view.placeholder = holder;
        [view setValue:font forKeyPath:@"_placeholderLabel.font"];
        [view setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    }
}

inline static void configStatusBarStyle(UIStatusBarStyle style){
    if (@available(iOS 13,*)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    }else{
        [UIApplication sharedApplication].statusBarStyle = style;
    }
}

inline static void removeSubviewsFrom(UIView *view){
    do {
        UIView *sub = view.subviews.lastObject;
        [sub removeFromSuperview];
    } while (view.subviews.count);
}

inline static CGFloat W(CGFloat w){
    return (screenWidth*(w))/375.0;
}

inline static CGFloat H(CGFloat h){
//    return (screenWidth/375)*h;
    if(isiPhoneXSeries){
        return (h*(screenHeight-34))/667.0;
    }
    return (screenHeight*(h))/667.0;
}

@interface CommonUtil : NSObject

+(void)save:(id)value forKey:(NSString *)key;
+(id)getValueFromKey:(NSString *)key;
+(void)removeValueForKey:(NSString *)key;
+(UIViewController *)topViewController;
+ (UIViewController*)currentViewController;
+(void)showAlertWithOneButton:(NSString *)title message:(NSString *)msg buttonTitle:(NSString *)btn leftBlock:(void(^)(void))leftBlock;
+(UIAlertController *)showAlertWithTwoButton:(NSString *)title message:(NSString *)msg leftbuttonTitle:(NSString *)leftbtn leftBlock:(void(^)(void))leftBlock rightButtonTitle:(NSString *)rightButton rightBlock:(void(^)(void))rightBlock;
+ (NSString*)getPreferredLanguage;
+(void)showActionSheetViewWithTitle:(NSString *)title msg:(NSString *)msg actionTitle:(NSString *)action1 andAction:(void(^)(UIAlertAction *action))actionBlock cancelAction:(NSString *)cancelTitle otherAction:(NSArray<NSString *> *)titleArr andOtherActionBlock:(NSArray <void(^)(UIAlertAction *action) > *)blockArray;
+(UILabel *)createLabelWithSuper:(UIView *)view fontSize:(UIFont *)font text:(NSString *)text color:(UIColor *)color size:(void(^)(MASConstraintMaker *make))maker;
+(UIImageView *)createImageWithSuper:(UIView *)view imageName:(NSString *)name mode:(UIViewContentMode)mode size:(void(^)(MASConstraintMaker *make))maker;
+(UIView *)addLineForView:(UIView *)view lineColor:(UIColor *)color andMasonry:(void(^)(MASConstraintMaker *make))maker;
+(UIButton *)createBottomButtonFor:(UIView *)view andTitle:(NSString *)title;
+(UIButton *)createButtonForView:(UIView *)view withButtonDetail:(void(^)( UIButton *sender))btnBlock andMasonry:(void(^)(MASConstraintMaker *make))maker andEvent:(void(^)(void))eventBlock;
+ (NSString *)iphoneType;
+(UIImage *)getLocalThumbnailImage:(NSURL *)videoURL;
+(UIImage *)getNetThumbnailImage:(NSString *)videoURL completion:(void(^)(UIImage *image))block;
+(NSDictionary *)deviceInfo;

@end

NS_ASSUME_NONNULL_END
