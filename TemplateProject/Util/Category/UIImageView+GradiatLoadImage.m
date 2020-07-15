//
//  UIImageView+GradiatLoadImage.m
//  yqjy
//
//  Created by admin on 2019/9/25.
//  Copyright © 2019 易起. All rights reserved.
//

#import "UIImageView+GradiatLoadImage.h"

@implementation UIImageView (GradiatLoadImage)

-(void)gradientLoadWithImage:(UIImage *)image{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0f;
    animation.type = kCATransitionFade;
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"transition"];
    self.image = image;
    [self setNeedsLayout];
}

-(void)gradientLoadWithImage:(UIImage *)image withTime:(CGFloat)time{
    CATransition *animation = [CATransition animation];
    animation.duration = time;
    animation.type = kCATransitionFade;
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"transition"];
    self.image = image;
    [self setNeedsLayout];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.layer removeAnimationForKey:@"transition"];
}

#pragma mark - GIF图片加载
-(UIImage *)sd_animatedGIFWithName:(NSString *)gifName{
    NSString *path = [[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self sd_frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

-(void)sd_animatedGIFWithName:(NSString *)gifName1 forimv:(UIImageView *)imv{
    NSString *path = [[NSBundle mainBundle] pathForResource:gifName1 ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) {
        return;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    CGFloat time = 0;
    NSMutableArray *images = [NSMutableArray array];
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self sd_frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        time = duration;
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    imv.image = animatedImage;
    dispatch_after(time, dispatch_get_main_queue(), ^{
        imv.image = images[0];
    });
}

- (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}


@end
