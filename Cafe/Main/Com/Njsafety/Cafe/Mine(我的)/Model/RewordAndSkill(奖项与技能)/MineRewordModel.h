//
//  MineRewordModel.h
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//
//  奖项

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineRewordModel : NSObject

//定义属性
@property (nonatomic, copy) NSString *awardName;             //名称
@property (nonatomic, copy) NSString *awardDate;             //日期
@property (nonatomic, copy) NSString *rankOrLevel;           //等级
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *showLanguage;     //CH -- 中文；EN -- 英文

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
