//
//  BaseView.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "BaseView.h"

@interface BaseView()

ProUnsafe ViewShowAnimatePostioned position;

@end

@implementation BaseView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initData];
        [self createMainView];
    }
    return self;
}

-(void)initData{}

-(void)createMainView{}

-(void)showViewWithAnimation:(ViewShowAnimatePostioned)position{
    self.hidden = NO;
    self.position = position;
    switch (position) {
        case ViewShowAnimatePostionedCenter:
        {
            [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.top).offset((screenHeight-self.bgView.mj_h)/2);
            }];
        }
            break;
        case ViewShowAnimatePostionedFromTop:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.bottom).offset(-(screenHeight-self.bgView.mj_h)/2);
                }];
            }
            break;
        case ViewShowAnimatePostionedFromLeft:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.right).offset(screenWidth-self.bgView.mj_w);
                }];
            }
            break;
        case ViewShowAnimatePostionedFromRight:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.left).offset(screenWidth-self.bgView.mj_w);
                }];
            }
            break;
        case ViewShowAnimatePostionedFromBottom:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.top).offset(screenHeight-self.bgView.mj_h);
                }];
            }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)showViewWithAnimation:(ViewShowAnimatePostioned)position endPoint:(CGPoint)p{
    self.hidden = NO;
    self.position = position;
    switch (position) {
        case ViewShowAnimatePostionedCenter:
        {
            [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.top).offset((screenHeight-self.bgView.mj_h)/2);
            }];
        }
            break;
        case ViewShowAnimatePostionedFromTop:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.bottom).offset(-p.y);
                }];
            }
            break;
        case ViewShowAnimatePostionedFromLeft:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.right).offset(-p.x);
                }];
            }
            break;
        case ViewShowAnimatePostionedFromRight:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.left).offset(p.x);
                }];
            }
            break;
        case ViewShowAnimatePostionedFromBottom:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.top).offset(p.y);
                }];
            }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)dismissView{
    switch (self.position) {
        case ViewShowAnimatePostionedCenter:
        {
            [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.top).offset(screenHeight);
            }];
        }
            break;
        case ViewShowAnimatePostionedFromTop:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.top).offset(-self.bgView.mj_h);
                }];
            }
            break;
        case ViewShowAnimatePostionedFromLeft:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.left);
                }];
            }
            break;
        case ViewShowAnimatePostionedFromRight:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.right);
                }];
            }
            break;
        case ViewShowAnimatePostionedFromBottom:
            {
                [self.bgView updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.top).offset(screenHeight);
                }];
            }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end
