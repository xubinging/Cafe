//
//  PersonalDataModifyPhoneNumberVC.h
//  Cafe
//
//  Created by gexy on 2020/3/14.
//  Copyright © 2020 leo. All rights reserved.
//  个人资料 -- 修改手机号

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalDataModifyPhoneNumberVC : UIViewController

//Block传值step 1：定义block为传值block的属性
@property (nonatomic,copy)void(^sendValueBlock)(NSDictionary *valueDict);

//接受父页面参数的字典
@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
