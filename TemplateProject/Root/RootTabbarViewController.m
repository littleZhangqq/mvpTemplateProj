//
//  RootTabbarViewController.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "RootTabbarViewController.h"
#import "RootNavigationViewController.h"
#import "HomeViewController.h"
#import "GasStationViewController.h"
#import "ExchangeViewController.h"
#import "MineViewController.h"

@interface RootTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation RootTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setUpAllChildViewController];
}

-(void)setUpAllChildViewController{
    HomeViewController *homeVC = [[HomeViewController alloc] initWithPresenter:[NSClassFromString(@"HomePresenter") class] record:[NSClassFromString(@"HomeRecord") new]];
    RootNavigationViewController *navi1 = [self setupChildViewController:homeVC title:@"首页" imageName:@"weixuanzhong_shouye" seleceImageName:@"xuanzhong_shouye"];
    
    GasStationViewController *gas = [[GasStationViewController alloc] initWithPresenter:[NSClassFromString(@"GasStationPresenter") class] record:[NSClassFromString(@"GasStationRecord") new]];
    RootNavigationViewController *navi2 = [self setupChildViewController:gas title:@"加油" imageName:@"weixunzhong_jiayou" seleceImageName:@"xuanzhong_jiayou"];
    
    ExchangeViewController *exchange = [[ExchangeViewController alloc] initWithPresenter:[NSClassFromString(@"ExchangePresenter") class] record:[NSClassFromString(@"ExchangeRecord") new]];
    RootNavigationViewController *navi3 = [self setupChildViewController:exchange title:@"易兑" imageName:@"weixuanzhong_jifen" seleceImageName:@"xuanzhong_jifen"];
    
    MineViewController *mineVC = [[MineViewController alloc] initWithPresenter:[NSClassFromString(@"MinePresenter") class] record:[NSClassFromString(@"UserRecord") new]];
    RootNavigationViewController *navi4 = [self setupChildViewController:mineVC title:@"我的" imageName:@"weixuanzhong_wode" seleceImageName:@"xuanzhong_wode"];
    
    self.viewControllers = @[navi1,navi2,navi3,navi4];
}

-(RootNavigationViewController *)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.navigationController.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:201/255.0 green:202/255.0 blue:211/255.0 alpha:1.0];
    textAttrs[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [controller.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //设置默认文字大小
    [controller.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0];
    [controller.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    //设置选中文字大小
    textAttrs[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    [controller.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    RootNavigationViewController *nav = [[RootNavigationViewController alloc]initWithRootViewController:controller];
    return nav;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    NSLog(@"选中 %ld",tabBarController.selectedIndex);
}

@end
