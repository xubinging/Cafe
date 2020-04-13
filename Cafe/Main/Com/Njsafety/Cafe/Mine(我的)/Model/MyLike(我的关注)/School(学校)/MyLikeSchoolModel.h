//
//  MyLikeSchoolModel.h
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyLikeSchoolModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger insId;    //机构id
@property (nonatomic, assign) NSInteger insType;    //关注的机构类别（1:学校 2:留学公司 3:留学培训 4:合作办学 5:预科、国际班 6驻地顾问点）
@property (nonatomic, copy) NSString *instnamecn;       //机构名称
@property (nonatomic, copy) NSString *instnameen;       //机构英文名称
@property (nonatomic, copy) NSString *logo;       //机构logo
@property (nonatomic, copy) NSString *officeId;       //驻地顾问点id
@property (nonatomic, copy) NSString *type;       //机构类型
@property (nonatomic, copy) NSString *displayName;       //运营名


@property (nonatomic, assign) NSInteger schoolIndex;

//@property (nonatomic, copy) UIImage *schoolIcon;        //学校图标
//@property (nonatomic, copy) NSString *schoolName;       //学校名称

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
