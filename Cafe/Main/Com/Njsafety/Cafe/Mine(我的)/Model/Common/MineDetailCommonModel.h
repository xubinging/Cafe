//
//  MineDetailCommonModel.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

/**
*  <我的>模块 -- 详情页面公用Model
*
*  教育背景详情
*  学术经历详情
*  Offer详情
*  工作经历详情
*  课外活动详情
*  奖项与技能详情
*
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineDetailCommonModel : NSObject

//定义属性
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *aboutme; //个性签名
@property (nonatomic, copy) NSString *sex; //性别
@property (nonatomic, copy) NSString *headportrait; //头像
@property (nonatomic, copy) NSString *username; //用户名
@property (nonatomic, copy) NSString *identify; //身份
@property (nonatomic, copy) NSString *nameCn; //中文名
@property (nonatomic, copy) NSString *nameEn; //英文名
@property (nonatomic, copy) NSString *birthdate; //出生日期
@property (nonatomic, copy) NSString *city; //目前居住城市
@property (nonatomic, copy) NSString *tourStudyCountry; //游学国家
@property (nonatomic, copy) NSString *country; //留学国家
@property (nonatomic, copy) NSString *internationalSchool; //国际学校
@property (nonatomic, copy) NSString *cooperativeSchoolType; //合作办学
@property (nonatomic, copy) NSString *domesticPreparatoryType; //国内预科
@property (nonatomic, copy) NSString *phonenumber; //电话
@property (nonatomic, copy) NSString *email; //邮箱

@property (nonatomic, copy) NSString *category; //留学类别
@property (nonatomic, copy) NSString *admissiondate; //计划入学时间
@property (nonatomic, copy) NSString *classes; //班次，例如春季班
@property (nonatomic, assign) Boolean studyflag; //是否留学在读或校友

@property (nonatomic, copy) NSString *internationalSchoolType; //国际学校类型
@property (nonatomic, copy) NSString *internationalSchoolsystem; //国际学校体系




//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
