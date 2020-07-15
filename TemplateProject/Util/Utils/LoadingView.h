//
//  LoadingView.h
//  yqjy
//
//  Created by admin on 2019/9/25.
//  Copyright © 2019 易起. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingView : UIView

+(void)show;
+(void)showWithoutAnimation;
+(void)showInView:(UIView *)view;
+(void)showInView:(UIView *)view andMsg:(NSString *)msg;
+(void)showInView:(UIView *)view andMsg:(NSString *)msg showBg:(BOOL)show;
+(void)dissmiss;

@end

NS_ASSUME_NONNULL_END
