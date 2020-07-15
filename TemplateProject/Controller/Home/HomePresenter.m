//
//  HomePresenter.m
//  TemplateProject
//
//  Created by admin on 2020/7/13.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "HomePresenter.h"
#import "HomeRecord.h"

@implementation HomePresenter
buildMVPInPresenterM;

- (void)controllerWillAppear{
    [self task:HOME_DATA param:@{} type:Post];
}

- (void)controllerDidLoad{
    [self task:APP_INIT param:@{} type:Post];
}

- (void)taskBegin{
    [LoadingView show];
}

- (void)taskDone:(id)resp fromUrl:(nonnull NSString *)url{
    [LoadingView dissmiss];
    if (EqualString(url, HOME_DATA)) {
        self.record = [HomeRecord mj_objectWithKeyValues:resp];
        [self task:HOME_COUPON param:@{} type:Post];
    }else if (EqualString(url, HOME_COUPON)){
        if ([resp isKindOfClass:[NSDictionary class]]) {
            self.record.couponArray = [NSMutableArray arrayWithArray:[CouponRecord mj_objectArrayWithKeyValuesArray:resp[@"coupons"]]];
        }
    }else if (EqualString(url, APP_INIT)){
        self.appRecord = [AppInitRecord mj_objectWithKeyValues:resp];
    }
}

@end
