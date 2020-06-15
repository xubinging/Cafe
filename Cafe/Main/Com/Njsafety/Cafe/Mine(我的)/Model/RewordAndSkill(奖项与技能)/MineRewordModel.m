//
//  MineRewordModel.m
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//
//  奖项

#import "MineRewordModel.h"

@implementation MineRewordModel

//防止空值赋值出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

//从字典中获取类
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    MineRewordModel *model = [[MineRewordModel alloc] init];
    
    //对model进行批量赋值，将dict传入
    [model setValuesForKeysWithDictionary:dict];
    
    NSString *ID = dict[@"id"];
    if ([ID isKindOfClass:[NSString class]]) {
        model.ID = ID;
    } else {
        model.ID = [NSString stringWithFormat:@"%@",ID];
    }
    
    NSString *date = dict[@"skillDate"];
    if ([date isKindOfClass:[NSString class]]) {
        model.awardDate = [_F ConvertStrToDate:date];
    } else {
        date = [NSString stringWithFormat:@"%@",date];
        model.awardDate = [_F ConvertStrToDate:date];
    }
    
    return model;
}

@end
