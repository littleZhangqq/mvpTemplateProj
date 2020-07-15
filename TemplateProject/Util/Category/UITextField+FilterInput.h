//
//  UITextField+FilterInput.h
//  yqjy
//
//  Created by admin on 2019/10/10.
//  Copyright © 2019 易起. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (FilterInput)<UITextFieldDelegate>

- (BOOL)inputNumberAndLeaveTwoSmallNumFor:(UITextField *)textField range:(NSRange)range replacementString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
