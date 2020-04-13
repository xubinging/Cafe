//
//  MineActivityModel.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineActivityModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *name;             //社团/项目/活动名称
@property (nonatomic, copy) NSString *role;             //社团/项目/活动角色
@property (nonatomic, copy) NSString *startTime;        //开始时间
@property (nonatomic, copy) NSString *endTime;          //结束时间
@property (nonatomic, copy) NSString *content;          //内容

@property (nonatomic, copy) NSString *showLanguage;     //CH -- 中文；EN -- 英文

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
