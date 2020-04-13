//
//  _M.h
//  simp
//
//  Created by leo on 2019/6/24.
//  Copyright © 2019 leo. All rights reserved.
//  请求结果类
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _M : NSObject

@property (copy, nonatomic) NSDictionary *data;     //数据字典
@property (copy, nonatomic) NSString *msg;          //返回信息
@property (assign, nonatomic) NSInteger rescode;    //状态码:200 / 201 / 401 / 403 / 404
@property (copy, nonatomic) NSString *result;       //结果描述:OK / Created / Unauthorized / Forbidden / Not Found

+(instancetype)createResponseJsonObj:(NSDictionary *)dic;

+(instancetype)createResponseJsonObjWithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
