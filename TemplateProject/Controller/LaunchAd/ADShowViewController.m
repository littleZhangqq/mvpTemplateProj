//
//  ADShowViewController.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "ADShowViewController.h"

@interface ADShowViewController ()

ProStrong UIImageView *adView;
ProStrong UIButton *countBtn;
ProStrong NSTimer *countTimer;
ProUnsafe NSInteger count;
ProCopy NSString *filePath;

@end

@implementation ADShowViewController

- (void)initData{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)initViews{
    // 1.广告图片
    _adView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _adView.userInteractionEnabled = YES;
    _adView.contentMode = UIViewContentModeScaleAspectFill;
    _adView.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
    [_adView addGestureRecognizer:tap];
    
    // 2.跳过按钮
    CGFloat btnW = 60;
    CGFloat btnH = 30;
    _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - btnW - 24, NavBarHeight, btnW, btnH)];
    [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%ld", adShowTime] forState:UIControlStateNormal];
    _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
    _countBtn.layer.cornerRadius = 4;
    
    [self.view addSubview:_adView];
    [self.view addSubview:_countBtn];
    
    [_adView sd_setImageWithURL:[NSURL URLWithString:[CommonModel shareInstance].adCache] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            _adView.image = image;
            [self show];
        }
    }];
}

- (NSTimer *)countTimer{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (void)pushToAd{
    [self dismiss];
}

- (void)countDown{
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%ld",_count] forState:UIControlStateNormal];
    if (_count <= 0) {
        [self dismiss];
    }
}

- (void)show{
    if (adShowTime<=0) {
        return;
    }
    [self startTimer];
}

- (void)startTimer{
    _count = adShowTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

- (void)startCoundown{
    __block NSInteger timeout = adShowTime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countBtn setTitle:[NSString stringWithFormat:@"跳过%ld",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

// 移除广告页面
- (void)dismiss{
    [self.countTimer invalidate];
    self.countTimer = nil;
    kKeyWindow.rootViewController = [RootTabbarViewController new];
}

@end
