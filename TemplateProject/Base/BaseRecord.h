//
//  BaseRecord.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//基类数据，使用mjextension进行数据解析，如果数据需其他操作如重组或赋值等，也要在record的子类内进行 不要在presenter和viewcontroller内进行。
@interface BaseRecord : NSObject

ProCopy NSString *msg;
ProUnsafe NSInteger code;
ProStrong id data;

@end

NS_ASSUME_NONNULL_END
