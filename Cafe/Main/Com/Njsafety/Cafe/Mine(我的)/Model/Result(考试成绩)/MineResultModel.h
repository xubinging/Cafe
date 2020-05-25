//
//  MineResultModel.h
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineResultModel : NSObject

//考试类型:类型1->TOEFL，类型2->IELTS，类型3->GRE，类型4->GMAT，类型5->SAT，类型6->SSAT，类型7->ACT
@property (nonatomic, copy) NSString *examType;
@property (nonatomic, copy) NSString *examDate;           //考试日期
@property (nonatomic, copy) NSString *address;            //考试地点
@property (nonatomic, copy) NSString *examOrgan;          //机构
@property (nonatomic, copy) NSString *scoreA;
@property (nonatomic, copy) NSString *scoreB;
@property (nonatomic, copy) NSString *scoreC;
@property (nonatomic, copy) NSString *scoreD;
@property (nonatomic, copy) NSString *scoreE;
@property (nonatomic, copy) NSString *examScore;          //总分
@property (nonatomic, copy) NSString *scoreFile;


@property (nonatomic, copy) NSString *accountId;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *areaType;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *countryName;
@property (nonatomic, copy) NSString *provincesCode;
@property (nonatomic, copy) NSString *provincesName;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *insid;
@property (nonatomic, copy) NSString *username;


@property (nonatomic, copy) NSString *totalScoreTitle;
@property (nonatomic, copy) NSString *scoreATitle;
@property (nonatomic, copy) NSString *scoreBTitle;
@property (nonatomic, copy) NSString *scoreCTitle;
@property (nonatomic, copy) NSString *scoreDTitle;
@property (nonatomic, copy) NSString *scoreETitle;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) NSString *showLanguage; //CH -- 中文；EN -- 英文

@property (nonatomic, copy) NSString *actionType;

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END



//addTime = 1589186890000;
//address = "\U5185\U8499\U53e4\U81ea\U6cbb\U533a\U8d64\U5cf0\U5e02";
//areaType = 1;
//cityCode = 150400;
//cityName = "\U8d64\U5cf0\U5e02";
//countryCode = "";
//countryName = "";
//delSign = 0;
//examDate = "2020-05-13";
//examOrgan = sgrgwg;
//examScore = 120;
//examType = 1;
//id = A81858A4994442F79304440C6AD26AA6;
//insid = 4350;
//modTime = "<null>";
//nickname = zhuzhaolong;
//operator = "<null>";
//postId = "<null>";
//presentFlag = "<null>";
//provincesCode = 150000;
//provincesName = "\U5185\U8499\U53e4\U81ea\U6cbb\U533a";
//remarks = "<null>";
//scoreA = 30;
//scoreB = 30;
//scoreC = 30;
//scoreD = 30;
//scoreE = "";
//scoreF = "<null>";
//scoreFile = "group1/M00/00/2C/Mes7UV65ESqAevcnAAkYBIl5muQ428.jpg";
//scoreG = "<null>";
//scoreH = "<null>";
//scoreI = "<null>";
//scoreJ = "<null>";
//status = "<null>";
//username = zhuzhaolong;
