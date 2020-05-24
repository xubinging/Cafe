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
    
    
    NSString *programStartDate = dict[@"programStartDate"];
    if ([programStartDate isKindOfClass:[NSString class]]) {
        model.programStartDate = programStartDate;
    } else {
        model.programStartDate = [NSString stringWithFormat:@"%@",programStartDate];;
    }
    
    NSString *programEndDate = dict[@"programEndDate"];
    if ([programEndDate isKindOfClass:[NSString class]]) {
        model.programEndDate = programEndDate;
    } else {
        model.programEndDate = [NSString stringWithFormat:@"%@",programEndDate];;
    }
    
    return model;
}

@end
