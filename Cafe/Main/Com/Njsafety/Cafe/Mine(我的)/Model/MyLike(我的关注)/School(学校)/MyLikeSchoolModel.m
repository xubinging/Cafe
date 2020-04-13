//
//  MyLikeSchoolModel.m
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MyLikeSchoolModel.h"

@implementation MyLikeSchoolModel

//防止空值赋值出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

//从字典中获取类
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    MyLikeSchoolModel *model = [[MyLikeSchoolModel alloc] init];
    
    //对model进行批量赋值，将dict传入
    [model setValuesForKeysWithDictionary:dict];
    
    if(model.instnamecn == NULL) {
        model.instnamecn = @"";
    }
    if(model.instnameen == NULL) {
        model.instnameen = @"";
    }
    if(model.logo == NULL) {
        model.logo = @"";
    }
    if(model.officeId == NULL) {
        model.officeId = @"";
    }
    if(model.type == NULL) {
        model.type = @"";
    }
    if(model.displayName == NULL) {
        model.displayName = @"";
    }
    
    return model;
}

@end
