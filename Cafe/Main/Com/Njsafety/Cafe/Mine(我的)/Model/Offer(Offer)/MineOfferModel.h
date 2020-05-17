//
//  MineOfferModel.h
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineOfferModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *country;                      //国家
@property (nonatomic, copy) NSString *schoolNameEn;                 //学校名称
@property (nonatomic, copy) NSString *level;                        //就读等级
@property (nonatomic, copy) NSString *majorName;                    //专业
@property (nonatomic, copy) NSString *agencyCompanyName;            //代办公司
@property (nonatomic, copy) NSString *internationalSchoolName;      //就读国际学校


@property (nonatomic, strong) MineResultModel *toeflScore;                //TOEFL
@property (nonatomic, strong) MineResultModel *ieltsScore;                //IELTS
@property (nonatomic, strong) MineResultModel *greScore;                  //GRE
@property (nonatomic, strong) MineResultModel *gmatScore;                 //GMAT
@property (nonatomic, strong) MineResultModel *satScore;                  //SAT
@property (nonatomic, strong) MineResultModel *ssatScore;                 //SSAT
@property (nonatomic, strong) MineResultModel *actScore;                  //ACT

@property (nonatomic, copy) NSString *gpaScore;                      //GPA成绩
@property (nonatomic, copy) NSString *gpaDate;                      //GPA就读时间


@property (nonatomic, copy) NSString *content;              //内容
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *showLanguage;         //CH -- 中文；EN -- 英文

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END


