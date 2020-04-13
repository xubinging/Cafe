//
//  AvalonsoftAreaPickerModel.m
//  Cafe
//
//  Created by leo on 2020/2/12.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftAreaPickerModel.h"

@implementation AvalonsoftAreaPickerModel

//防止空值赋值出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

//从字典中获取类
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    AvalonsoftAreaPickerModel *model = [[AvalonsoftAreaPickerModel alloc] init];
    
    //对model进行批量赋值，将dict传入
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
