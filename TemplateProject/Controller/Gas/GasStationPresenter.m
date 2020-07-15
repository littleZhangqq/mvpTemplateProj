//
//  GasStationPresenter.m
//  TemplateProject
//
//  Created by admin on 2020/7/13.
//  Copyright © 2020 zhangqiang. All rights reserved.
//

#import "GasStationPresenter.h"

@implementation GasStationPresenter
buildMVPInPresenterM;

- (void)controllerWillAppear{
    [self task:GAS_STATION_LIST param:@{@"position":@"",@"type":@"92#",@"brand_id":@"0",@"sort":@"1"} type:Post];
}

- (void)taskBegin{
    
}

- (void)taskDone:(id)resp fromUrl:(NSString *)url{
    self.dataArray = [NSMutableArray arrayWithArray:[GasStationRecord mj_objectArrayWithKeyValuesArray:resp]];
}

- (void)taskError:(NSString *)msg code:(NSInteger)code{
    [HBHUDTool showMessageCenter:msg];
}

@end
