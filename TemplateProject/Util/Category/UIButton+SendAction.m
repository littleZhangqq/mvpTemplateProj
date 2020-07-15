//
//  UIButton+SendAction.m
//  yqjy
//
//  Created by admin on 2019/9/12.
//  Copyright © 2019 易起. All rights reserved.
//

#import "UIButton+SendAction.h"

const void *checkKey = @"theKey";

@implementation UIButton (SendAction)

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{

    [super sendAction:action to:target forEvent:event];
    if ([self isKindOfClass:[NSClassFromString(@"UIKeyboardDockItemButton") class]]) {
        return;
    }
    for (UIView *view in kKeyWindow.subviews) {
        [view endEditing:YES];
    }
}

- (BOOL)checkLogin{
    return [objc_getAssociatedObject(self, checkKey) boolValue];
}

- (void)setCheckLogin:(BOOL)checkLogin{
    objc_setAssociatedObject(self, checkKey, @(checkLogin), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)checkAndJumLogin{
    return objc_getAssociatedObject(self, @selector(checkAndJumLogin));
}

- (void)setCheckAndJumLogin:(BOOL)checkAndJumLogin{
    objc_setAssociatedObject(self, @selector(checkAndJumLogin), @(checkAndJumLogin), OBJC_ASSOCIATION_ASSIGN);
}

@end
