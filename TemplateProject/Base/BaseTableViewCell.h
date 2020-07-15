//
//  BaseTableViewCell.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

ProStrong UIView *bgView;

-(void)createMainView;

-(void)updateCellWithRecord:(id)record;

@end

NS_ASSUME_NONNULL_END
