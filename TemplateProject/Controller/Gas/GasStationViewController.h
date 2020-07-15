//
//  GasStationViewController.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "BaseViewController.h"
#import "GasStationPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GasStationViewController : BaseViewController
buildMVPInControllerH(GasStationPresenter);

@end

NS_ASSUME_NONNULL_END
