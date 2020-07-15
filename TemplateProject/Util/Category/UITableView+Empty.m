//
//  UITableView+Empty.m
//  XDYCar
//
//  Created by zhangqq on 2017/2/6.
//  Copyright © 2017年 张强. All rights reserved.
//

#import "UITableView+Empty.h"


@implementation UITableView (Empty)

+(void)load
{
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //交换reloadData方法
//        method_exchangeImplementations(class_getInstanceMethod(self, @selector(reloadData)), class_getInstanceMethod(self, @selector(lx_reloadData)));
//        
//        //交换insertSections方法
//        method_exchangeImplementations(class_getInstanceMethod(self,@selector(insertSections:withRowAnimation:)),class_getInstanceMethod(self,@selector(lx_insertSections:withRowAnimation:)));
//        
//        //交换insertRowsAtIndexPaths方法
//        method_exchangeImplementations(class_getInstanceMethod(self, @selector(insertRowsAtIndexPaths:withRowAnimation:)),  class_getInstanceMethod(self, @selector(lx_insertRowsAtIndexPaths:withRowAnimation:)));
//        
//        //交换deleteSections方法
//        method_exchangeImplementations(class_getInstanceMethod(self,@selector(deleteSections:withRowAnimation:)),class_getInstanceMethod(self,@selector(lx_deleteSections:withRowAnimation:)));
//        
//        //交换deleteRowsAtIndexPaths方法
//        method_exchangeImplementations(class_getInstanceMethod(self,@selector(deleteRowsAtIndexPaths:withRowAnimation:)),class_getInstanceMethod(self,@selector(lx_deleteRowsAtIndexPaths:withRowAnimation:)));
//    });
    
    
}

- (void)reloadAllData{
    [self reloadData];
    [self reloadPlaceoholderLabel];
}

//reloadData
//-(void)lx_reloadData
//{
//    [self lx_reloadData];
//
//    [self reloadPlaceoholderLabel];
//}
//
////insert
//-(void)lx_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
//{
//    [self lx_insertSections:sections withRowAnimation:animation];
//    [self reloadPlaceoholderLabel];
//}
//
//-(void)lx_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
//{
//    [self lx_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
//    [self reloadPlaceoholderLabel];
//}
//
////delete
//-(void)lx_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
//{
//    [self lx_deleteSections:sections withRowAnimation:animation];
//    [self reloadPlaceoholderLabel];
//}
//
//-(void)lx_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
//{
//    [self lx_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
//    [self reloadPlaceoholderLabel];
//}

#pragma mark -- 重新设置数据
-(void)reloadPlaceoholderLabel
{
    //计算行数
    NSInteger rows = 0;
    for (int i = 0; i <  self.numberOfSections; i ++) {
        
        rows += [self numberOfRowsInSection:i];
    }
    
    //如果没有数据 或者字符串为空 就不显示
    if (rows > 0 ) {
        if (self.holderImage != nil) {
            self.holderImage.hidden = YES;
        }
        if (self.placeholderLabel != nil) {
            self.placeholderLabel.hidden = YES;
        }
        return;
    }

    //是否有偏移
    CGFloat height = self.contentInset.top;
    
    CGFloat labelHeight = 60;

    
    //判断是否有头
    if (self.tableHeaderView) {
        height += self.tableHeaderView.frame.size.height;
    }
    
//    if (height < self.frame.size.height/2.0-labelHeight) {
//        height = self.frame.size.height/2.0-labelHeight;
//    }else {
//        height += 30;
//    }
    height = self.frame.size.height/2.0;
    //显示提示内容的label
//    self.placeholderLabel = [[UILabel alloc] init];
    
    self.placeholderLabel.frame = CGRectMake(0, height, self.frame.size.width, labelHeight);
    
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.text =  self.placeholder.length !=0 ? self.placeholder : @"";
    self.placeholderLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.placeholderLabel];
    
    [self.holderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.placeholderLabel.mas_top).offset(-H(5));
    }];
    self.placeholderLabel.hidden = NO;
    self.holderImage.hidden = NO;
}

#pragma mark -- getter & setter
-(NSString *)placeholder
{
    return objc_getAssociatedObject(self, @selector(placeholder));
}

-(void)setPlaceholder:(NSString *)placeholder
{
    objc_setAssociatedObject(self, @selector(placeholder), placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)placeholderLabel{
     UILabel *label =  objc_getAssociatedObject(self, @selector(placeholderLabel));
    if (!label) {
        label = [UILabel new];
        label.font = FONT_PingFangBold(17);
        label.textColor = ColorRGB(51, 51, 51);
        objc_setAssociatedObject(self, @selector(placeholderLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        label.hidden = YES;
    }
    return label;
}

-(void)setPlaceholderLabel:(UILabel *)placeholderLabel
{
    objc_setAssociatedObject(self, @selector(placeholderLabel), placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)holderImage{
    UIImageView *imv =  objc_getAssociatedObject(self, @selector(holderImage));
    if (!imv) {
        imv = [CommonUtil createImageWithSuper:self imageName:@"emptyBox" mode:UIViewContentModeScaleAspectFit size:^(MASConstraintMaker *make) {
        }];
        imv.contentMode = UIViewContentModeScaleAspectFill;
        objc_setAssociatedObject(self, @selector(holderImage), imv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        imv.hidden = YES;
    }
    return imv;
}

@end
