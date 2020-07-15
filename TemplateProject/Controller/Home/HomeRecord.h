//
//  HomeRecord.h
//  TemplateProject
//
//  Created by admin on 2020/7/13.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "BaseRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponRecord : BaseRecord

ProCopy NSString *cp_quota;
ProCopy NSString *validity_time;
ProCopy NSString *start_validity_time;
ProCopy NSString *full_amount;
ProCopy NSString *name;
ProCopy NSString *category;
ProUnsafe NSInteger type;
ProUnsafe NSInteger id;
ProUnsafe NSInteger m_id;
ProUnsafe BOOL is_enable;
ProUnsafe BOOL canChoose;
ProUnsafe BOOL isSelected;
ProUnsafe BOOL showIncrease;
ProUnsafe BOOL origin_enable;
ProUnsafe BOOL origin_canChoose;
ProUnsafe BOOL origin_Selected;
ProUnsafe BOOL origin_Increase;
ProUnsafe NSInteger showType;

@end

@interface UpdateRecord : BaseRecord

ProCopy NSString *ver;
ProCopy NSString *url;
ProCopy NSString *msg;
ProCopy NSString *force;

@end

@interface AdRecord : BaseRecord

ProCopy NSString *id;
ProCopy NSString *path;
ProCopy NSString *desc;
ProCopy NSString *url_type;
ProCopy NSString *link;
ProCopy NSString *params;
ProUnsafe NSInteger is_once;

@end

@interface NewsRecord : BaseRecord

ProCopy NSString *id;
ProCopy NSString *news_title;
ProCopy NSString *news_path;
ProCopy NSString *params;
ProCopy NSString *news_link;
ProCopy NSString *url_type;

@end

@interface AppInitRecord : BaseRecord

ProStrong NSArray *coupons;
ProCopy NSString *red_bag;
ProCopy NSString *app_mode;
ProStrong NSArray *app_city;
ProStrong NSArray *ads;
ProStrong UpdateRecord *ios;
ProUnsafe BOOL is_call_coupons;

@end

@interface BrandRecord : BaseRecord

ProUnsafe NSInteger id;
ProCopy NSString *name;
ProCopy NSString *sub_name;
ProCopy NSString *logo;
ProCopy NSString *shop_link;

@end

@interface HomeInviteRecord : BaseRecord

ProUnsafe NSInteger status;
ProUnsafe NSInteger sum;
ProUnsafe NSInteger current;
ProUnsafe NSInteger id;
ProCopy NSString *title;
ProCopy NSString *thumb;
ProUnsafe NSInteger total;
ProUnsafe NSInteger get_num;
ProCopy NSString *desc;
ProCopy NSString *tags;
ProUnsafe NSInteger receiveTask;
ProUnsafe NSInteger islogin;
ProUnsafe NSInteger row;

@end

@interface HomeRecord : BaseRecord

ProStrong NSArray *banners;
ProStrong NSArray *news;
ProStrong NSArray *invites;
ProStrong NSArray *brands;
ProCopy NSString *avatar;
ProCopy NSString *oil_fee;
ProCopy NSString *last_time_fee;
ProUnsafe NSInteger islogin;
ProCopy NSString *count_earn;
ProCopy NSString *task_earn;
ProCopy NSString *station_desc;
ProCopy NSString *station_id;
ProUnsafe NSInteger receiveTask;
ProCopy NSString *login_tip;

ProStrong NSMutableArray *couponArray;

@end

NS_ASSUME_NONNULL_END
