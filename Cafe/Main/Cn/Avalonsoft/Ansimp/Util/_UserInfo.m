//
//  _UserInfo.m
//  Cafe
//
//  Created by leo on 2020/3/12.
//  Copyright © 2020 leo. All rights reserved.
//
//  取用户信息类

#import "_UserInfo.h"
#import "AvalonsoftUserDefaultsModel.h"         // 公共类

@implementation _UserInfo

//是否显示欢迎页
+ (BOOL)isShowWelcome
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].isShowWelcome;
}

//首页搜索历史
+ (NSArray *)mainSearchHistoryArr
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].mainSearchHistoryArr;
}

//用户鉴权token
+ (NSString *)token
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].token;
}

//用户id
+ (NSString *)userId
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].userId;
}

//用户名
+ (NSString *)userName
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].userName;
}

//密码
+ (NSString *)password
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].password;
}

// accountId
+ (NSString *)accountId
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].accountId;
}

//昵称
+ (NSString *)nickName
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].nickName;
}

//身份
+ (NSString *)identify
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].identify;
}

//source
+ (NSString *)source
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].source;
}

//手机号
+ (NSString *)phoneNumber
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].phoneNumber;
}

//邮箱
+ (NSString *)email
{
    return [AvalonsoftUserDefaultsModel userDefaultsModel].email;
}

@end
