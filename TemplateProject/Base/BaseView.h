//
//  BaseView.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum: NSUInteger{
    ViewShowAnimatePostionedFromBottom,
    ViewShowAnimatePostionedFromLeft,
    ViewShowAnimatePostionedFromRight,
    ViewShowAnimatePostionedFromTop,
    ViewShowAnimatePostionedCenter,
}ViewShowAnimatePostioned;

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

ProStrong UIView *bgView;

-(instancetype)init NS_DESIGNATED_INITIALIZER;
-(instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

//数据
-(void)initData;
//布局控件
-(void)createMainView;

//bgview显示方式，不带p是以宽高为基准进行显示，带p按照给定的p和枚举进行显示，具体看内部实现
-(void)showViewWithAnimation:(ViewShowAnimatePostioned)position;
-(void)showViewWithAnimation:(ViewShowAnimatePostioned)position endPoint:(CGPoint)p;
-(void)dismissView;

@end

NS_ASSUME_NONNULL_END
