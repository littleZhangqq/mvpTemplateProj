//
//  BasePresenter.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "BasePresenter.h"

@interface BasePresenter()

ProStrong NSMutableDictionary *requestNotes;
//同步阻塞，多个网络请求同时发生，后进入的需要等待前面的完成才能继续调用
ProUnsafe BOOL isRequesting;

@end

@implementation BasePresenter

- (void)task:(NSString *)url param:(NSDictionary *)param type:(RequestType)type{
    if (EqualNullString(url)) {
        NSLog(@"请配置请求的URL");
        return;
    }
    if (_isRequesting) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self task:url param:param type:type];
        });
        return;
    }
    _isRequesting = YES;
    if (!_requestNotes) {
        _requestNotes = [NSMutableDictionary dictionary];
    }
    if (param) {
        _requestNotes[url] = param;
    }
    [self taskBegin];
    [[NetWorkTool shareToolManager] requestWithMethod:Post param:param url:url andComplete:^(id  _Nonnull resp) {
         _isRequesting = NO;
        [self taskDone:resp fromUrl:url];
        if ([self.delegate respondsToSelector:@selector(handleSuccess)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate handleSuccess];
            });
        }else  if ([self.delegate respondsToSelector:@selector(handleSuccess:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate handleSuccess:url];
            });
        }
    } fail:^(NSInteger code, NSString * _Nonnull msg) {
         _isRequesting = NO;
        [self taskError:msg code:code];
        if ([self.delegate respondsToSelector:@selector(handleError:code:)]) {
            [self.delegate handleError:msg code:code];
        }else if ([self.delegate respondsToSelector:@selector(handleError:code:url:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate handleError:msg code:code url:url];
            });
        }
    }];
}

- (void)controllerDidLoad{}

- (void)controllerWillAppear{}

- (void)taskBegin{}

- (void)taskDone:(id)resp fromUrl:(nonnull NSString *)url{}

- (void)taskError:(NSString *)msg code:(NSInteger)code{}

- (void)reload:(NSString *)url{
    NSDictionary *param = _requestNotes[url];
    if (!param) {
        NSLog(@"未找到参数，请重新调用task方法请求");
        return;
    }
    [self task:url param:param type:Post];
}

@end
