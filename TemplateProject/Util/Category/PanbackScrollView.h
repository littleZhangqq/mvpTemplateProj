//
//  PanbackScrollView.h
//  Patients
//
//  Created by zhangqq on 2019/4/9.
//  Copyright © 2019 fuweihan00. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//uiscroll的一个类别，继承这个scroll是可以滑动返回的。
@interface PanbackScrollView : UIScrollView<UIGestureRecognizerDelegate>

@end

NS_ASSUME_NONNULL_END
