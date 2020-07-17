//
//  HomeViewController.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "HomeViewController.h"
#import "UpdateView.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

ProStrong UpdateView *updateView;
ProStrong UITableView *tableView;
ProStrong UILabel *topLabel;
ProStrong UIButton *btn1;
ProStrong UIButton *btn2;

@end

@implementation HomeViewController
buildMVPInControllerM;//为presenter自动生成get方法

- (void)initNavis{
    self.title = @"Home";
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)initViews{
    self.hiddenNaviBar = YES;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.contentInset = UIEdgeInsetsMake(screenWidth, 0, 0, 0);
    [self.view addSubview:_tableView];

    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    UIView *topView = [UIView new];
    topView.backgroundColor = COLOR(cyanColor);
    topView.frame = CGRectMake(0, -screenWidth, screenWidth, screenWidth);
    [_tableView addSubview:topView];
    
    [_tableView bringSubviewToFront:topView];
    [self.tableView addSubview:topView];
    
    _topLabel = [CommonUtil createLabelWithSuper:topView fontSize:FONT_CUSTOM(15) text:@"" color:COLOR(blackColor) size:^(MASConstraintMaker * _Nonnull make) {
        make.left.equalTo(100);
        make.top.equalTo(50);
    }];
    _topLabel.userInteractionEnabled = YES;
    self.updateView.hidden = YES;
    
    _btn1 = [CommonUtil createButtonForView:topView withButtonDetail:^(UIButton * _Nonnull sender) {
        [sender setTitle:@"btn1" forState:0];
        [sender setTitleColor:COLOR(blackColor) forState:0];
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(40);
    }];
    
    _btn2 = [CommonUtil createButtonForView:topView withButtonDetail:^(UIButton * _Nonnull sender) {
        [sender setTitle:@"btn2" forState:0];
        [sender setTitleColor:COLOR(blackColor) forState:0];
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(topView);
        make.right.equalTo(-40);
    }];
}

-(void)updateTopView{
    _topLabel.text = @"2222";
    [CommonUtil createLabelWithSuper:_tableView fontSize:FONT_CUSTOM(15) text:self.presenter.appRecord.ios.msg color:COLOR(orangeColor) size:^(MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(-W(45));
        make.centerX.equalTo(_tableView);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.presenter.record.brands.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return W(45);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return ({
        UIView *view = [UIView new];
        view.backgroundColor = COLOR(yellowColor);
        view;
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return W(100);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BrandRecord *brand = self.presenter.record.brands[indexPath.row];
    cell.textLabel.text = brand.name;
    return cell;
}

#pragma mark 网络请求代理
- (void)handleSuccess:(NSString *)url{
    if (EqualString(url, HOME_DATA)) {
        //显示主页数据
        [_tableView reloadData];
    }else if (EqualString(url, APP_INIT)){
        //显示更新弹窗
        [self.updateView showViewWithAnimation:ViewShowAnimatePostionedCenter];
    }else if (EqualString(url, HOME_COUPON)){
        //更新顶部数据
        [self updateTopView];
    }
}

- (void)handleError:(NSString *)msg code:(NSInteger)code{
    [HBHUDTool showMessageCenter:msg];
}

- (UpdateView *)updateView{
    if (!_updateView) {
        _updateView = [[UpdateView alloc] init];
    }
    return _updateView;
}

- (void)handleTapEvent:(UIView *)view{
    if (view == _btn1) {
        NSLog(@"btn1点击了");
    }else if (view == _btn2){
        NSLog(@"btn2点击了");
    }else if (view == _topLabel){
        NSLog(@"label点击了");
    }
}

@end
