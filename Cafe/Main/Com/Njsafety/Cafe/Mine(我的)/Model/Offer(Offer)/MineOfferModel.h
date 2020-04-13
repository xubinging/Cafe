//
//  MineOfferModel.h
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineOfferModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *country;              //国家
@property (nonatomic, copy) NSString *school;               //学校名称
@property (nonatomic, copy) NSString *stage;                //就读阶段
@property (nonatomic, copy) NSString *major;                //专业
@property (nonatomic, copy) NSString *agentCompany;         //代办公司
@property (nonatomic, copy) NSString *internationalSchool;  //就读国际学校

@property (nonatomic, copy) NSString *gpa;                  //平均分

@property (nonatomic, copy) NSDictionary *TOEFLDic;         //TOEFL
@property (nonatomic, copy) NSDictionary *IELTSDic;         //IELTS
@property (nonatomic, copy) NSDictionary *GREDic;           //GRE
@property (nonatomic, copy) NSDictionary *GMATDic;          //GMAT
@property (nonatomic, copy) NSDictionary *SATDic;           //SAT
@property (nonatomic, copy) NSDictionary *ACTDic;           //ACT

@property (nonatomic, copy) NSString *content;              //内容

@property (nonatomic, copy) NSString *showLanguage;         //CH -- 中文；EN -- 英文

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
