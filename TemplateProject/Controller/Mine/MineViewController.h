//
//  MineViewController.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "BaseViewController.h"
#import "MinePresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineViewController : BaseViewController
buildMVPInControllerH(MinePresenter);

@end

NS_ASSUME_NONNULL_END