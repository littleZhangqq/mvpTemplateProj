//
//  BasePresenter.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkTool.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PresenterDelegate <NSObject>

/// 页面有单个请求的成功处理
-(void)handleSuccess;

/// 页面有单个请求，如果出错走这个方法
/// @param msg 错误提示
/// @param code 错误码
-(void)handleError:(NSString *)msg code:(NSInteger)code;

/// 页面有多个请求都会走这个方法时，可根据URL来区分事件
/// @param url 事件名
-(void)handleSuccess:(NSString *)url;

/// 页面有多个请求都会走这个方法时，可根据URL来区分错误处理
/// @param msg 错误提示
/// @param code 错误码
/// @param url 事件名
-(void)handleError:(NSString *)msg code:(NSInteger)code url:(NSString *)url;

@end

//基类逻辑处理和网络层，链接controller和model，主要负责网络请求，回调数据处理。
@class BaseViewController;
@interface BasePresenter : NSObject

// 该控制流对应的视图控制器。有时可能在某个请求操作后调用控制器消失显示等等需要使用
ProWeak BaseViewController *controller;
ProStrong BaseRecord *record;
//代理方法，controller中刷新页面方法在这里
ProWeak id<PresenterDelegate> delegate;

//网络请求
-(void)task:(NSString *)url param:(NSDictionary *)param type:(RequestType)type;

/// 请求接口开始操作，可以加载loading，进度等等
-(void)taskBegin;

/// 请求接口完成
/// @param resp 是回调数据，可能为各种类型所以用ID
-(void)taskDone:(id)resp fromUrl:(NSString *)url;

/// 请求成功 但参数有错误或其他错误，code不是200
/// @param msg 错误提示
/// @param code 错误码
-(void)taskError:(NSString *)msg code:(NSInteger)code;

//每请求一次，都会把对应的新请求参数记录，如果重复调用。直接使用reload方法即可，外部不用重组参数
-(void)reload:(NSString *)url;

// 使P层跟控制器生命周期绑定，方便自定义网络请求的位置。 \
比如本来要在controller内的viewdidload请求或者viewwillappear里面发送请求\
现在在该presenter文件的下两个方法内执行也有同样的效果。进一步分离p层和v层代码
-(void)controllerDidLoad;

-(void)controllerWillAppear;

@end

NS_ASSUME_NONNULL_END
