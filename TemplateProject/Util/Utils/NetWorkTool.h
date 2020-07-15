//
//  NetWorkTool.h
//  TemplateProject
//
//  Created by admin on 2020/7/10.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum :NSUInteger{
    Post,
    Get,
    Put,
    Delete,
    Upload
}RequestType;

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkTool : NSObject

+(instancetype)shareToolManager;

-(void)requestWithMethod:(RequestType)type param:(NSDictionary *)dic url:(NSString *)link andComplete:(void(^)(id resp))succBlock fail:(void(^)(NSInteger code,NSString *msg))failBlock;

@end

NS_ASSUME_NONNULL_END
