//
//  MineOfferModel.m
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineOfferModel.h"

@implementation MineOfferModel

//防止空值赋值出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

//从字典中获取类
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    MineOfferModel *model = [[MineOfferModel alloc] init];
    
    //对model进行批量赋值，将dict传入
    [model setValuesForKeysWithDictionary:dict];
    
    NSString *ID = dict[@"id"];
    if ([ID isKindOfClass:[NSString class]]) {
        model.ID = ID;
    } else {
        model.ID = [NSString stringWithFormat:@"%@",ID];
    }
    
    if (![dict[@"toeflScore"] isEqual:[NSNull null]]) {
        model.toeflScore = [MineResultModel modelWithDict: dict[@"toeflScore"]];
    }
    
    if (![dict[@"ieltsScore"] isEqual:[NSNull null]]) {
        model.ieltsScore = [MineResultModel modelWithDict: dict[@"ieltsScore"]];
    }
    
    if (![dict[@"greScore"] isEqual:[NSNull null]]) {
        model.greScore = [MineResultModel modelWithDict: dict[@"greScore"]];
    }

    if (![dict[@"gmatScore"] isEqual:[NSNull null]]) {
        model.gmatScore = [MineResultModel modelWithDict: dict[@"gmatScore"]];
    }

    if (![dict[@"satScore"] isEqual:[NSNull null]]) {
        model.satScore = [MineResultModel modelWithDict: dict[@"satScore"]];
    }

    if (![dict[@"ssatScore"] isEqual:[NSNull null]]) {
        model.ssatScore = [MineResultModel modelWithDict: dict[@"ssatScore"]];
    }

    if (![dict[@"actScore"] isEqual:[NSNull null]]) {
        model.actScore = [MineResultModel modelWithDict: dict[@"actScore"]];
    }

    return model;
}

@end
