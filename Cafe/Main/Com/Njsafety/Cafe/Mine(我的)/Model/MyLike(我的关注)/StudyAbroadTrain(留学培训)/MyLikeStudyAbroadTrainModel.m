//
//  MyLikeStudyAbroadTrainModel.m
//  Cafe
//
//  Created by gexy on 2020/3/16.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MyLikeStudyAbroadTrainModel.h"

@implementation MyLikeStudyAbroadTrainModel

//防止空值赋值出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

//从字典中获取类
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    MyLikeStudyAbroadTrainModel *model = [[MyLikeStudyAbroadTrainModel alloc] init];
    
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
