//
//  Event.m
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "Event.h"

@interface Event()

ProStrong NSMutableDictionary *eventTargetDic;
ProStrong NSMutableArray *eventArray;
ProUnsafe BOOL isDispatching;

@end

@implementation Event

- (instancetype)init{
    self = [super init];
    if (self) {
        _eventTargetDic = [NSMutableDictionary dictionary];
        _eventArray = [NSMutableArray array];
        _isDispatching = NO;
    }
    return self;
}

+(instancetype)getInstance{
    static Event *event = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        event = [[self alloc] init];
    });
    return event;
}

-(void)getTargetEvent:(NSString *)evt{
    
}

-(void)handleEvent:(NSString *)event data:(__weak id)data{
    _isDispatching = YES;
    NSMutableArray *array = _eventTargetDic[event];
    //一个事件发生，所有监听到该事件的地方都执行一次，执行后按需保留或删除
    if (array.count > 0) {
        EventCallback cb = [array lastObject];
        BOOL result = cb(event,data);
        if (!result) {
            [array removeObject:cb];
        }else{
        }
    }
}

-(void)addEvent:(NSString *)event priority:(EventDispatchPriority)priority cb:(EventCallback)cb{
    NSMutableArray *array = _eventTargetDic[event];
    if (!array) {
        array = [NSMutableArray array];
    }
    if (cb) {
        [array addObject:cb];
    }
    _eventTargetDic[event] = array;
}

@end
