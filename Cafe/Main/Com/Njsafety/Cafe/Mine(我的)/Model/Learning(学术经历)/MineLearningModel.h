//
//  MineLearningModel.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineLearningModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *accountId;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *programName;             //项目名称
@property (nonatomic, copy) NSString *programRole;             //项目角色
@property (nonatomic, copy) NSString *programStartDate;        //开始时间
@property (nonatomic, copy) NSString *programEndDate;          //结束时间
@property (nonatomic, copy) NSString *programDescription;          //内容



@property (nonatomic, copy) NSString *showLanguage;     //CH -- 中文；EN -- 英文

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END



//accountId = 1165;
//addTime = 1578015799000;
//id = 42;
//programDescription = "\U6d4b";
//programEndDate = 1572624000000;
//programName = "\U6d4b\U8bd5";
//programRole = "\U6d4b\U8bd5";
//programStartDate = 1570032000000;
