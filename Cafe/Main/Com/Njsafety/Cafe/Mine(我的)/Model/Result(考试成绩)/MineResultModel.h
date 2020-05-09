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

@property (nonatomic, copy) NSString *showLanguage; //CH -- 中文；EN -- 英文

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
