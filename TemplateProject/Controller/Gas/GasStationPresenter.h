//
//  GasStationPresenter.h
//  TemplateProject
//
//  Created by admin on 2020/7/13.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "BasePresenter.h"
#import "GasStationRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface GasStationPresenter : BasePresenter
buildMVPInPresenterH(GasStationRecord);

ProStrong NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
