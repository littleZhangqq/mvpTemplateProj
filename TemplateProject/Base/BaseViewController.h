//
//  BaseViewController.h
//  yqjy
//
//  Created by admin on 2019/8/27.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//基类V层，里面可以创建视图，完成显示更新页面等工作
@interface BaseViewController : UIViewController<PresenterDelegate>

ProStrong UIButton *backButton;
ProStrong UIButton *rightButton;
ProUnsafe BOOL hiddenNaviBar;
ProStrong BasePresenter *presenter;

-(void)initData;
-(void)initViews;
-(void)initNavis;

-(instancetype)init;
- (instancetype)initWithPresenter:(Class)presenterCls record:(BaseRecord *)record;
-(void)pushViewControlUseBaseMethod:(BaseViewController *)ctl animate:(BOOL)animate;
-(void)setRightNaviBarWith:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color image:(NSString *)image;
- (void)clickBackButton;
-(void)clickRightButton;
-(void)handleTapEvent:(UIView *)view;
- (UIImageView *)getLineViewInNavigationBar:(UIView *)view;
-(void)getTabbarTopLineHidden:(BOOL)hide;

@end

NS_ASSUME_NONNULL_END
