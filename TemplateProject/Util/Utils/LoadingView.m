//
//  LoadingView.m
//  yqjy
//
//  Created by admin on 2019/9/25.
//  Copyright © 2019 易起. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

ProStrong UIImageView *animateView;
ProStrong UIView *bgView;
ProStrong UILabel *titleLabel;

@end

@implementation LoadingView

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static LoadingView *view;
    dispatch_once(&onceToken, ^{
        view = [[self alloc] init];
    });
    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createMainView];
    }
    return self;
}

-(void)createMainView{
    self.backgroundColor = COLOR(clearColor);
    _bgView = [UIView new];
    _bgView.backgroundColor = COLOR(clearColor);
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.masksToBounds = YES;
    [self addSubview:_bgView];
    
    [_bgView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(CGSizeMake(W(110), H(87)));
    }];
    
    _animateView = [CommonUtil createImageWithSuper:_bgView imageName:@"" mode:UIViewContentModeScaleAspectFit size:^(MASConstraintMaker * _Nonnull make) {
        make.centerX.equalTo(_bgView);
        make.top.equalTo(H(12));
        make.size.equalTo(CGSizeMake(45, 45));
    }];
    
    _titleLabel = [CommonUtil createLabelWithSuper:_bgView fontSize:FONTSize(14) text:@"" color:COLOR(whiteColor) size:^(MASConstraintMaker * _Nonnull make) {
        make.centerX.equalTo(_bgView);
        make.bottom.equalTo(-H(10));
    }];
    
    NSMutableArray *imgArray = [NSMutableArray array];
    for (NSInteger i = 0; i<11; i++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"loading%ld",i+1] ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
        [imgArray addObject:image];
    }
    
    _animateView.animationImages = imgArray;
    _animateView.animationDuration = 1;
    _animateView.animationRepeatCount = 0;
    [_animateView startAnimating];
}

+(void)show{
    [LoadingView showInView:kKeyWindow];
}

+(void)showInView:(UIView *)view{
    [LoadingView showInView:view andMsg:@""];
}

+(void)showInView:(UIView *)view andMsg:(NSString *)msg{
    [self showInView:view andMsg:msg showBg:NO];
}

+ (void)showWithoutAnimation{
    [kKeyWindow addSubview:[LoadingView shareInstance]];
    [[LoadingView shareInstance] makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(kKeyWindow);
    }];
    [LoadingView shareInstance].bgView.backgroundColor = COLOR(clearColor);
    [LoadingView shareInstance].animateView.hidden = YES;
    [LoadingView shareInstance].titleLabel.text = @"";
}

+(void)showInView:(UIView *)view andMsg:(NSString *)msg showBg:(BOOL)show{
    [view addSubview:[LoadingView shareInstance]];
    [[LoadingView shareInstance] makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    if (show) {
        [LoadingView shareInstance].bgView.backgroundColor = COLOR(blackColor);
    }else{
        [LoadingView shareInstance].bgView.backgroundColor = COLOR(clearColor);
    }
    [LoadingView shareInstance].titleLabel.text = msg;
}

+(void)dissmiss{
    [[LoadingView shareInstance] removeFromSuperview];
}

@end
