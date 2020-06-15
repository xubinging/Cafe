//
//  MineJobModel.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineJobModel.h"

@implementation MineJobModel

//防止空值赋值出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

//从字典中获取类
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    MineJobModel *model = [[MineJobModel alloc] init];
    
    //对model进行批量赋值，将dict传入
    [model setValuesForKeysWithDictionary:dict];
    
    NSString *ID = dict[@"id"];
    if ([ID isKindOfClass:[NSString class]]) {
        model.ID = ID;
    } else {
        model.ID = [NSString stringWithFormat:@"%@",ID];
    }
    
    NSString *date = dict[@"workStartDate"];
    if ([date isKindOfClass:[NSString class]]) {
        model.workStartDate = [_F ConvertStrToDate:date];
    } else {
        date = [NSString stringWithFormat:@"%@",date];
        model.workStartDate = [_F ConvertStrToDate:date];
    }
    
    NSString *date2 = dict[@"workEndDate"];
    if ([date2 isKindOfClass:[NSString class]]) {
        model.workEndDate = [_F ConvertStrToDate:date2];
    } else {
        date2 = [NSString stringWithFormat:@"%@",date2];
        model.workEndDate = [_F ConvertStrToDate:date2];
    }
    
    NSString *Description = dict[@"description"];
    model.Description = Description;
    
    return model;
}

@end
