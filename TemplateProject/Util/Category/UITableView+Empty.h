//
//  UITableView+Empty.h
//  XDYCar
//
//  Created by zhangqq on 2017/2/6.
//  Copyright © 2017年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Empty)

@property (nonatomic,copy) NSString *placeholder; /**< 提示字符串 */
@property (nonatomic,strong) UIImageView *holderImage;
@property (nonatomic,strong) UILabel *placeholderLabel; /**< 占位文字label */

-(void)reloadAllData;

@end
