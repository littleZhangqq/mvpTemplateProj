//
//  GasStationRecord.h
//  TemplateProject
//
//  Created by admin on 2020/7/13.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "BaseRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface GasStationRecord : BaseRecord

ProCopy NSString *address;
ProCopy NSString *city;
ProCopy NSString *close_desc;
ProCopy NSString *discount;
ProCopy NSString *distance;
ProCopy NSString *id;
ProCopy NSString *name;
ProCopy NSString *position;
ProCopy NSString *price;
ProCopy NSString *thumb;
ProCopy NSString *is_open;
ProCopy NSString *is_top;

@end

NS_ASSUME_NONNULL_END
