//
//  MineEducationModel.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineEducationModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *country;          //国家
@property (nonatomic, copy) NSString *school;           //学校/机构名称
@property (nonatomic, copy) NSString *stage;            //教育阶段
@property (nonatomic, copy) NSString *startTime;        //开始时间
@property (nonatomic, copy) NSString *endTime;          //结束时间
@property (nonatomic, copy) NSString *degreeType;       //学位类型
@property (nonatomic, copy) NSString *major;            //专业
@property (nonatomic, copy) NSString *score;            //成绩
@property (nonatomic, copy) NSString *state;            //状态；应该是通过标志位判断的
@property (nonatomic, copy) NSString *showFlg;          //是否设为头像下方显示的院校

@property (nonatomic, copy) NSString *showLanguage;     //CH -- 中文；EN -- 英文

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
