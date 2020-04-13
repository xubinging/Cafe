//
//  PlatformMenuModel.m
//  Cafe
//
//  Created by leo on 2020/1/1.
//  Copyright © 2020 leo. All rights reserved.
//

#import "PlatformMenuModel.h"

@implementation PlatformMenuModel

//防止空值赋值出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

//从字典中获取类
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    PlatformMenuModel *model = [[PlatformMenuModel alloc] init];
    //对model进行批量赋值，将dict传入
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
