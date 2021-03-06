//
//  PersonalDataStudyAbroadCountryVC.h
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//
//  留学国家

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalDataStudyAbroadCountryVC : UIViewController

//Block传值step 1：定义block为传值block的属性
@property (nonatomic,copy)void(^sendValueBlock)(NSDictionary *valueDict);

//接受父页面参数的字典
@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
