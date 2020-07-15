//
//  UIImageView+GradiatLoadImage.h
//  yqjy
//
//  Created by admin on 2019/9/25.
//  Copyright © 2019 易起. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (GradiatLoadImage)<CAAnimationDelegate>

-(void)gradientLoadWithImage:(UIImage *)image;

-(void)gradientLoadWithImage:(UIImage *)image withTime:(CGFloat)time;

-(UIImage *)sd_animatedGIFWithName:(NSString *)gifName;

@end

NS_ASSUME_NONNULL_END
