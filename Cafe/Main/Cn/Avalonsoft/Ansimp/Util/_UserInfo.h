//
//  _UserInfo.h
//  Cafe
//
//  Created by leo on 2020/3/12.
//  Copyright © 2020 leo. All rights reserved.
//
//  取用户信息类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _UserInfo : NSObject

// 是否显示欢迎页
+ (BOOL)isShowWelcome;

// 首页搜索历史
+ (NSArray *)mainSearchHistoryArr;

// 用户鉴权token
+ (NSString *)token;

// 用户id
+ (NSString *)userId;

//用户名
+ (NSString *)userName;

//密码
+ (NSString *)password;

// accountId
+ (NSString *)accountId;

//昵称
+ (NSString *)nickName;

//身份
+ (NSString *)identify;

//source 1是C端，2是B端
+ (NSString *)source;

//手机号
+ (NSString *)phoneNumber;

//邮箱
+ (NSString *)email;

@end

NS_ASSUME_NONNULL_END
