//
//  HomeViewController.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "BaseViewController.h"
#import "HomePresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : BaseViewController
buildMVPInControllerH(HomePresenter);

@end

NS_ASSUME_NONNULL_END
