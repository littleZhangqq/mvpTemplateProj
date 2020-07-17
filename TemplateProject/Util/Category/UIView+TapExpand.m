//
//  UIView+TapExpand.m
//  TemplateProject
//
//  Created by admin on 2020/7/17.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "UIView+TapExpand.h"

@implementation UIView (TapExpand)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([[CommonUtil topViewController] isKindOfClass:[BaseViewController class]]) {
           BaseViewController *ctl = (BaseViewController *)[CommonUtil topViewController];
           if ([ctl.presenter.delegate respondsToSelector:@selector(handleTapEvent:)]) {
               [ctl.presenter.delegate handleTapEvent:touches.anyObject.view];
           }
       }else if ([[CommonUtil topViewController] isKindOfClass:[RootNavigationViewController class]]){
           RootNavigationViewController *navi = (RootNavigationViewController *)[CommonUtil topViewController];
           if ([navi.viewControllers.lastObject isKindOfClass:[BaseViewController class]]) {
               BaseViewController *ctl = (BaseViewController *)navi.viewControllers.lastObject;
               if ([ctl.presenter.delegate respondsToSelector:@selector(handleTapEvent:)]) {
                   [ctl.presenter.delegate handleTapEvent:touches.anyObject.view];
               }
           }
       }else{
           [super touchesBegan:touches withEvent:event];
       }
}

@end
