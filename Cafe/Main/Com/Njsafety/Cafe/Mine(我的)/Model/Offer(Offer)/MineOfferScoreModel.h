//
//  MineOfferScoreModel.h
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineOfferScoreModel : NSObject

//定义属性
@property (nonatomic, copy) NSString *scoreType;            //分数类别

@property (nonatomic, copy) NSString *totalScoreTitle;      //总分
@property (nonatomic, copy) NSString *totalScore;

@property (nonatomic, copy) NSString *scoreOneTitle;        //分数一
@property (nonatomic, copy) NSString *scoreOne;

@property (nonatomic, copy) NSString *scoreTwoTitle;        //分数二
@property (nonatomic, copy) NSString *scoreTwo;

@property (nonatomic, copy) NSString *scoreThreeTitle;      //分数三
@property (nonatomic, copy) NSString *scoreThree;

@property (nonatomic, copy) NSString *scoreFourTitle;       //分数四
@property (nonatomic, copy) NSString *scoreFour;

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
