//
//  MineDetailCommonModel.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineDetailCommonModel.h"

@implementation MineDetailCommonModel

//防止空值赋值出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

//从字典中获取类
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    MineDetailCommonModel *model = [[MineDetailCommonModel alloc] init];
    
    //对model进行批量赋值，将dict传入
    [model setValuesForKeysWithDictionary:dict];
//    model.aboutme = [dict objectForKey:@"aboutme"];
//    model.sex = [dict objectForKey:@"sex"];
//    model.headportrait = [dict objectForKey:@"headportrait"];
    if(model.aboutme == NULL) {
        model.aboutme = @"";
    }
    if(model.sex == NULL) {
        model.sex = @"";
    }
    if(model.headportrait == NULL) {
        model.headportrait = @"";
    }
    if(model.username == NULL) {
        model.username = @"";
    }
    if(model.identify == NULL) {
        model.identify = @"";
    }
    if(model.nameCn == NULL) {
        model.nameCn = @"";
    }
    if(model.nameEn == NULL) {
        model.nameEn = @"";
    }
    if(model.birthdate == NULL) {
        model.birthdate = @"";
    }
    if(model.city == NULL) {
        model.city = @"";
    }
    if(model.tourStudyCountry == NULL) {
        model.tourStudyCountry = @"";
    }
    if(model.country == NULL) {
        model.country = @"";
    }
    if(model.internationalSchool == NULL) {
        model.internationalSchool = @"";
    }
    if(model.cooperativeSchoolType == NULL) {
        model.cooperativeSchoolType = @"";
    }
    if(model.domesticPreparatoryType == NULL) {
        model.domesticPreparatoryType = @"";
    }
    if(model.phonenumber == NULL) {
        model.phonenumber = @"";
    }
    if(model.email == NULL) {
        model.email = @"";
    }
    return model;
}

@end
