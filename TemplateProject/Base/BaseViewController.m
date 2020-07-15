//
//  BaseViewController.m
//  yqjy
//
//  Created by admin on 2019/8/27.
//  Copyright © 2019 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseViewController

/// 这个init方法是创建vc用的，意在说明当这个基类控制器绑定presenter和record后，要实现对应的代理，给对应的presenter.record、presenter.controller、presenter.delegate赋值，以后继承baseviewcontroller的子类统统可以使用里面的方法。而你子类具体绑定什么presenter和record这里不管，你要到具体的子类去实现
/// @param presenterCls 逻辑处理类
/// @param record 数据类
- (instancetype)initWithPresenter:(Class)presenterCls record:(BaseRecord *)record{
    if (self = [super init]) {
        self.presenter = [[presenterCls alloc] init];
        self.presenter.record = record;
        self.presenter.controller = self;
        self.presenter.delegate = self.presenter.controller;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    if (@available(iOS 11.0, *)) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [UIScrollView appearanceWhenContainedInInstancesOfClasses:@[[BaseViewController class]]].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        });
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setupNavation];
    [self.presenter controllerDidLoad];
    [self initData];
    [self initViews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getLineViewInNavigationBar:self.navigationController.navigationBar].hidden = NO;
    self.navigationController.delegate = self;
    NSLog(@"当前视图%@",[self class]);
    [self.presenter controllerWillAppear];
    [self initNavis];
}

-(void)setupNavation{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = COLOR(whiteColor);
    self.navigationController.navigationBar.barTintColor = COLOR(whiteColor);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"PingFang-SC-Medium" size:18],NSFontAttributeName ,nil];
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    self.backButton = [UIButton buttonWithType:0];
    self.backButton.frame = CGRectMake(0, 0, W(35), W(35));
    self.backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -W(17), 0, 0);
    [self.backButton setImage:LocalImage(@"shezhi_daohang_fanhui") forState:0];
    WEAK_SELF;
    [[self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf clickBackButton];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    if ([NetworkTools shareNetworkTools].shareManager.tasks.count > 0) {
//        [[NetworkTools shareNetworkTools].shareManager.tasks makeObjectsPerformSelector:@selector(cancel)];
//        [[Event getInstance] handleEvent:CANCEL_ALL_REQUEST data:nil];
//    }
}

-(void)setRightNaviBarWith:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color image:(NSString *)image{
    self.rightButton = [UIButton buttonWithType:0];
    [self.rightButton setTitle:title forState:0];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:font];
    [self.rightButton setTitleColor:color forState:0];
    if (image.length > 0) {
        [self.rightButton setImage:[UIImage imageNamed:image] forState:0];
    }
    self.rightButton.frame = CGRectMake(0, 0, 40, H(15));
    [self.rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[BaseViewController class]]) {
        BaseViewController * vc = (BaseViewController *)viewController;
        if (vc.hiddenNaviBar) {
            vc.view.mj_y = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        }else{
            vc.view.mj_y = NavHeight;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

-(void)clickBackButton{
    //通过判断self有没有present方式显示的父视图presentingViewController，有个bug，就是第一个界面present的，之后都push。在后面的界面也会误判成present，所以需要加一些判断：保证第一次present会dismiss回去，其他的都调用pop
    if (self.presentingViewController && self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if (![touch.view isKindOfClass:[UITextField class]] || ![touch.view isKindOfClass:[UITextView class]]) {
        [self.view endEditing:YES];
    }
}

-(void)clickRightButton{}
-(void)initData{}
-(void)initViews{}
-(void)initNavis{}

-(void)pushViewControlUseBaseMethod:(BaseViewController *)ctl animate:(BOOL)animate{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.navigationController.childViewControllers.count >= 1) {
            ctl.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController pushViewController:ctl animated:YES];
    });
}

- (UIImageView *)getLineViewInNavigationBar:(UIView *)view{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getLineViewInNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)getTabbarTopLineHidden:(BOOL)hide{
    if (self.tabBarController) {
        [self.tabBarController.tabBar setShadowImage:[UIImage new]];
        [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    }
}

- (void)dealloc{
    NSLog(@"当前页被释放：%@",[self class]);
}

@end
