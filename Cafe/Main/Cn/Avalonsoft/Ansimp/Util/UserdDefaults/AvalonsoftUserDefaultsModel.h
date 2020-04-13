//
//  AvalonsoftUserDefaultsModel.h
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//

#import "UDUserDefaultsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftUserDefaultsModel : UDUserDefaultsModel

//如果把一个自定义的类存到一个NSArray里，然后再存到NSUserDefaults里是不能成功的

//是否显示欢迎页
@property (nonatomic, assign)  BOOL isShowWelcome;              //是否显示欢迎页，默认为YES
@property (nonatomic, strong) NSArray *mainSearchHistoryArr;    //首页搜索历史

@property (nonatomic, copy) NSString *token;     //用户鉴权token
@property (nonatomic, copy) NSString *userId;    //用户id
@property (nonatomic, copy) NSString *userName;  //用户名
@property (nonatomic, copy) NSString *password;  //密码
@property (nonatomic, copy) NSString *accountId; //accountId
@property (nonatomic, copy) NSString *nickName;  //昵称
@property (nonatomic, copy) NSString *identify;  //身份
@property (nonatomic, copy) NSString *source;    //source
@property (nonatomic, copy) NSString *phoneNumber;  //phoneNumber
@property (nonatomic, copy) NSString *email;        //email

@end

NS_ASSUME_NONNULL_END
