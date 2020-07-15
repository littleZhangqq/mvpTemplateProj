//
//  HomePresenter.h
//  TemplateProject
//
//  Created by admin on 2020/7/13.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "BasePresenter.h"
#import "HomeRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePresenter : BasePresenter
buildMVPInPresenterH(HomeRecord);

ProStrong AppInitRecord *appRecord;

@end

NS_ASSUME_NONNULL_END
