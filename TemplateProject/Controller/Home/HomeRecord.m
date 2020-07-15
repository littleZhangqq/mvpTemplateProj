//
//  HomeRecord.m
//  TemplateProject
//
//  Created by admin on 2020/7/13.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "HomeRecord.h"

@implementation CouponRecord

@end

@implementation UpdateRecord


@end

@implementation AdRecord

@end

@implementation NewsRecord

@end

@implementation AppInitRecord

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"coupons":@"CouponRecord",
             @"ads":@"AdRecord"
    };
}

@end

@implementation BrandRecord


@end

@implementation HomeInviteRecord

@end

@implementation HomeRecord

+ (NSDictionary *)mj_objectClassInArray{
    return @{
        @"banners":@"AdRecord",
        @"brands":@"BrandRecord",
        @"news":@"NewsRecord",
        @"invites":@"HomeInviteRecord"
    };
}

@end
