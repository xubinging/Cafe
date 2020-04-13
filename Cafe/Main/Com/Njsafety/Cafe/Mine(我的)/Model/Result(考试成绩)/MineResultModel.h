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

//定义属性
@property (nonatomic, assign) NSInteger resultIndex;
@property (nonatomic, copy) NSString *resultType;           //考试类型
@property (nonatomic, copy) NSString *resultDate;           //考试日期
@property (nonatomic, copy) NSString *resultLocation;       //考试地点
@property (nonatomic, copy) NSString *resultOrg;            //机构
@property (nonatomic, copy) NSString *resultL;              //L
@property (nonatomic, copy) NSString *resultS;              //S
@property (nonatomic, copy) NSString *resultR;              //R
@property (nonatomic, copy) NSString *resultW;              //W
@property (nonatomic, copy) NSString *resultScore;          //总分
@property (nonatomic, copy) NSString *showLanguage; //CH -- 中文；EN -- 英文

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
