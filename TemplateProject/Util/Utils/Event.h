//
//  Event.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum: NSInteger{
    EventDispatchPriorityLow = -1,
    EventDispatchPriorityDefault = 0,
    EventDispatchPriorityHigh = 1,
}EventDispatchPriority;

//布尔值 表示是否持续监听，如果否，执行完毕删除，如果是的话内部cb一直留着
typedef BOOL(^EventCallback)(NSString *evt, __weak id data);

@interface Event : NSObject

+(instancetype)getInstance;

-(void)handleEvent:(NSString *)event data:(__weak id)data;
-(void)addEvent:(NSString *)event priority:(EventDispatchPriority)priority cb:(EventCallback)cb;

@end
NS_ASSUME_NONNULL_END
