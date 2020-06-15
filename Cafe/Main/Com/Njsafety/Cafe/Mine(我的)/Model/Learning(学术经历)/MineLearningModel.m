//
//  MineLearningModel.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineLearningModel.h"

@implementation MineLearningModel

//防止空值赋值出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

//从字典中获取类
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    MineLearningModel *model = [[MineLearningModel alloc] init];
    
    //对model进行批量赋值，将dict传入
    [model setValuesForKeysWithDictionary:dict];
    
    NSString *ID = dict[@"id"];
    if ([ID isKindOfClass:[NSString class]]) {
        model.ID = ID;
    } else {
        model.ID = [NSString stringWithFormat:@"%@",ID];
    }
    
    NSString *date = dict[@"programStartDate"];
    if ([date isKindOfClass:[NSString class]]) {
        model.programStartDate = [_F ConvertStrToDate:date];
    } else {
        date = [NSString stringWithFormat:@"%@",date];
        model.programStartDate = [_F ConvertStrToDate:date];
    }
    
    NSString *date2 = dict[@"programEndDate"];
    if ([date2 isKindOfClass:[NSString class]]) {
        model.programEndDate = [_F ConvertStrToDate:date2];
    } else {
        date2 = [NSString stringWithFormat:@"%@",date2];
        model.programEndDate = [_F ConvertStrToDate:date2];
    }
    
    return model;
}

@end
