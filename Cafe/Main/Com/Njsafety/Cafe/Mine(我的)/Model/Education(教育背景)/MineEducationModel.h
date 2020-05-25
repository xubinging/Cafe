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

@property (nonatomic, copy) NSString *accountId;        //用户id
@property (nonatomic, copy) NSString *country;          //国家
@property (nonatomic, copy) NSString *addTime;          //创建时间
@property (nonatomic, copy) NSString *countryName;      //国家名
@property (nonatomic, copy) NSString *countryNameEn;    //国家英文名
@property (nonatomic, copy) NSString *degreeType;       //学位类型
@property (nonatomic, copy) NSString *displayHome;      //是否显示在头像下方（0:不显示 1:显示
@property (nonatomic, copy) NSString *examType;         //考试类型
@property (nonatomic, copy) NSString *grades;           //成绩
@property (nonatomic, copy) NSString *graduationDate;   //毕业时间
@property (nonatomic, copy) NSString *highSchoolId;     //预置高中数据ID
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *insId;            //学校/机构Id
@property (nonatomic, copy) NSString *institutionName;  //学校/机构名称
@property (nonatomic, copy) NSString *level;            //教育阶段
@property (nonatomic, copy) NSString *major;            //专业
@property (nonatomic, copy) NSString *otherCountry;     //其他国家
@property (nonatomic, copy) NSString *startTime;        //开始时间
@property (nonatomic, copy) NSString *status;           //状态
@property (nonatomic, copy) NSString *universityId;     //预置大学数据ID

@property (nonatomic, copy) NSString *showFlg;          //是否设为头像下方显示的院校
@property (nonatomic, copy) NSString *showLanguage;     //CH -- 中文；EN -- 英文

@property (nonatomic, copy) NSString *actionType;  

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END


//accountId = 1165;
//addTime = 1588845217000;
//country = 100000;
//countryName = "\U4e2d\U56fd";
//countryNameEn = "Mainland China";
//degreeType = "";
//displayHome = 1;
//examType = Gaokao;
//grades = 120;
//graduationDate = "2020.06.30";
//highSchoolId = 1;
//id = 366;
//insId = "";
//institutionName = "\U5317\U4eac\U5e02\U7b2c\U4e8c\U4e2d\U5b66";
//level = 1;
//major = "";
//otherCountry = "";
//startDate = "2020.05.01";
//status = "\U5728\U8bfb Currently studying";
//universityId = "";
