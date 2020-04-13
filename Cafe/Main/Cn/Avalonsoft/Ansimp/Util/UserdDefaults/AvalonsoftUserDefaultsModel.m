//
//  AvalonsoftUserDefaultsModel.m
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftUserDefaultsModel.h"

@implementation AvalonsoftUserDefaultsModel

//在.m文件中对每一个属性进行@dynamic操作，意为setter与getter方法由类自己实现
@dynamic isShowWelcome;
@dynamic mainSearchHistoryArr;

@dynamic token;
@dynamic userId;
@dynamic userName;
@dynamic password;
@dynamic accountId;
@dynamic nickName;
@dynamic identify;
@dynamic source;
@dynamic phoneNumber;
@dynamic email;

//设置默认值
- (NSDictionary *)setupDefaultValues
{
    return @{
        @"isShowWelcome":@(YES),
        @"mainSearchHistoryArr":@[],
        
        @"token":@"",
        @"userId":@"",
        @"userName":@"",
        @"password":@"",
        @"accountId":@"",
        @"nickName":@"",
        @"identify":@"",
        @"source":@"",
        @"phoneNumber":@"",
        @"email":@""
    };
}

//定义生成的plist文件的名称
- (NSString *)_suiteName
{
    return @"Cafe.UserDefatults";
}

@end
