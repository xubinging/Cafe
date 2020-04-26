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
    
    ///TODO:xubing 建议平台不要使用 id 字段，可用大写 ID，同时下发的数据类型，建议用字符串
    NSString *ID = dict[@"id"];
    if ([ID isKindOfClass:[NSString class]]) {
        model.ID = ID;
    } else {
        model.ID = [NSString stringWithFormat:@"%@",ID];
    }
    
    ///TODO:xubing 建议平台不要使用description字段
    NSString *Description = dict[@"description"];
    model.Description = Description;
    
    return model;
}

@end
