//
//  LaunchScrollViewController.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "LaunchScrollViewController.h"


@interface LaunchScrollViewController ()

@end

@implementation LaunchScrollViewController

- (void)initData{
    
}

- (void)initViews{
    if (isiPhoneXSeries) {
        launchScrollImages = @[@"first_1", @"second_1", @"third_1"];
    }else{
        launchScrollImages = @[@"first", @"second", @"third"];
    }
    UIScrollView *gui = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    gui.pagingEnabled = YES;
    gui.showsHorizontalScrollIndicator = NO;
    gui.showsVerticalScrollIndicator = NO;
    gui.bounces = NO;
    [self.view addSubview:gui];
    
    UIView *contentView = [UIView new];
    [gui addSubview:contentView];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.height.equalTo(gui);
    }];

    UIImageView *last;
    for (NSInteger i = 0; i < launchScrollImages.count; i ++) {
            UIImageView *imv = [CommonUtil createImageWithSuper:contentView imageName:launchScrollImages[i] mode:UIViewContentModeScaleAspectFill size:^(MASConstraintMaker * _Nonnull make) {
                make.size.equalTo(CGSizeMake(screenWidth, screenHeight));
                make.left.equalTo(contentView.left).offset(screenWidth*i);
            }];
            imv.userInteractionEnabled = YES;
            [contentView addSubview:imv];
        
            [CommonUtil createButtonForView:imv withButtonDetail:^(UIButton * _Nonnull sender) {
                sender.backgroundColor = ColorRGB(0, 182, 42);
                sender.layer.cornerRadius = W(11);
                sender.layer.masksToBounds = YES;
                [sender setTitle:i == launchScrollImages.count-1 ? @"立即开启" : @"下一步"  forState:0];
                [sender setTitleColor:COLOR(whiteColor) forState:0];
                sender.titleLabel.font = FONT_CUSTOM(17);
            } andMasonry:^(MASConstraintMaker * _Nonnull make) {
                make.centerX.equalTo(imv);
                make.bottom.equalTo(-H(20)-BOTTOM);
                make.size.equalTo(CGSizeMake(W(146), W(46)));
            } andEvent:^{
                if (i != launchScrollImages.count-1) {
                    [gui setContentOffset:CGPointMake(screenWidth*(i+1), 0) animated:YES];
                }else{
                    [CommonModel shareInstance].alreadyLogin = @(1);
                    RootTabbarViewController *tabVC = [[RootTabbarViewController alloc]init];
                    [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
                }
            }];
            last = imv;
    }
    [contentView updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(last);
    }];
}

@end
