//
//  WebViewController.m
//  TemplateProject
//
//  Created by admin on 2020/7/18.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKNavigationDelegate,WKScriptMessageHandler>

ProStrong WKWebView *webView;
ProStrong UIProgressView *progressView;

@end

@implementation WebViewController

- (void)initNavis{
}

- (void)initData{
    
}

- (void)initViews{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //webview于js交互，点击web页的按钮会触发js这个方法，在本viewcontroller的代理里写上客户端做的事情。
    [config.userContentController addScriptMessageHandler:self name:@"xxxxx"];

    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.webView];
        
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.progressView];
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 0)];
        _progressView.tintColor = [UIColor cyanColor];
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && EqualString(keyPath, @"estimatedProgress")) {
        CGFloat new = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.progressView.hidden = NO;
        [self.progressView setProgress:new animated:YES];
        if (new == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    self.title = webView.title?:@"网页标题";
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
    return;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    [CommonUtil showAlertWithOneButton:@"" message:message buttonTitle:@"好的" leftBlock:^{
        completionHandler();
    }];
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if (EqualString(message.name, @"payNow")) {
        NSDictionary *dic;
        if ([message.body isKindOfClass:[NSString class]]) {
            dic = [message.body mj_JSONObject];
        }else if ([message.body isKindOfClass:[NSDictionary class]]){
            dic = message.body;
        }else{
            [HBHUDTool showMessageCenter:@"js数据错误，请稍后重试"];
            return;
        }
        //做你该做的事情
    }
}


@end
