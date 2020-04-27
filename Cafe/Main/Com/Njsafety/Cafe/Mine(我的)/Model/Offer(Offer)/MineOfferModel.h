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

@property (nonatomic, copy) NSString *country;                      //国家
@property (nonatomic, copy) NSString *schoolNameEn;               //学校名称
@property (nonatomic, copy) NSString *level;                        //就读等级
@property (nonatomic, copy) NSString *majorName;                    //专业
@property (nonatomic, copy) NSString *agencyCompanyName;            //代办公司
@property (nonatomic, copy) NSString *internationalSchoolName;      //就读国际学校


///TODO:xubing 此处平台下发的是字符串类型，不符，应下发字典类型数据。
@property (nonatomic, copy) NSDictionary *examScorea;                //TOEFL
@property (nonatomic, copy) NSDictionary *examScoreb;                //IELTS
@property (nonatomic, copy) NSDictionary *examScorec;                 //GRE
@property (nonatomic, copy) NSDictionary *examScored;                 //GMAT
@property (nonatomic, copy) NSDictionary *examScoree;                 //SAT
@property (nonatomic, copy) NSDictionary *examScoref;                 //SSAT
@property (nonatomic, copy) NSDictionary *examScoreg;                 //ACT

@property (nonatomic, copy) NSString *gpaScore;                       //GPA成绩

@property (nonatomic, copy) NSString *content;              //内容

@property (nonatomic, copy) NSString *showLanguage;         //CH -- 中文；EN -- 英文

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END


