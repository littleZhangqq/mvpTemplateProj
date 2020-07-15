//
//  UpdateView.m
//  TemplateProject
//
//  Created by admin on 2020/7/15.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "UpdateView.h"

@implementation UpdateView

- (void)initData{
    
}

- (void)createMainView{
    WEAK_SELF;
    self.backgroundColor = ColorRGBA(0, 0, 0, 0.4);
    [kKeyWindow addSubview:self];
    
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(kKeyWindow);
    }];
    
    self.bgView = [UIView new];
    self.bgView.backgroundColor = COLOR(whiteColor);
    [self addSubview:self.bgView];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(W(200), W(300)));
        make.top.equalTo(self.bottom);
    }];
    
    [CommonUtil createButtonForView:self.bgView withButtonDetail:^(UIButton * _Nonnull sender) {
        [sender setTitle:@"关闭" forState:0];
        [sender setTitleColor:COLOR(blackColor) forState:0];
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.right.top.equalTo(self.bgView);
    } andEvent:^{
        [weakSelf dismissView];
    }];
}

@end
