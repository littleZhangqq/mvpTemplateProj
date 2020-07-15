//
//  XDYStringComponent.h
//  XDYCar
//
//  Created by zhangqiang on 2017/12/13.
//  Copyright © 2017年 xindongyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringOffset : NSObject

ProUnsafe CGFloat x;
ProUnsafe CGFloat y;

@end

@interface StringComponent : NSObject

typedef StringComponent *(^StringComponentChain)(id);

//get方法，获取组装后的富文本，直接赋值给label的attributetext即可
ProStrong NSMutableAttributedString *attribuString;

//字体
-(StringComponentChain)COMFont;

//文本，可以是字符串也可是html文本
-(StringComponentChain)COMText;

//bool值，传入文本是否采用HTML格式显示，带标签的HTML文本有时候比用富文本写更方便一些
-(StringComponentChain)COMHtml;

//颜色
-(StringComponentChain)COMColor;

//对齐格式
-(StringComponentChain)COMTextAlignment;

// 字间距
-(StringComponentChain)COMSeperateSpace;

// 行间距
-(StringComponentChain)COMLineSpace;

// text中使用富文本显示的位置，一个数组@[@(1),@(2)],里面俩NSNumber，分别是location和length
-(StringComponentChain)COMRange;

//设置阴影颜色
-(StringComponentChain)COMShadowColor;

// 阴影偏移距离
-(StringComponentChain)COMShadowOffSet;

// 模糊度
-(StringComponentChain)COMBlurRadius;

//icon
-(StringComponentChain)COMAttachImage;

//是否水平对齐基线
-(StringComponentChain)COMBaseLine;

// 中间的横线
-(StringComponentChain)COMStrikeLine;

//将两个该富文本对象进行拼接组装成新的富文本
-(StringComponent *)appendingStringWithString:(StringComponent *)com;

@end
