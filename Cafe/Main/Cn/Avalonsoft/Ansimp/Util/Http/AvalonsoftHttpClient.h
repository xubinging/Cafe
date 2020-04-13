//
//  AvalonsoftHttpClient.h
//  SmartLock
//
//  Created by leo on 2019/9/7.
//  Copyright © 2019 leo. All rights reserved.
//
//  网络连接工具类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//HTTP请求类别
typedef NS_ENUM(NSInteger,HttpRequestType) {
    HttpRequestGet,
    HttpRequestPost,
    HttpRequestPut,
    HttpRequestDelete,
};

/**
 *  请求前预处理block
 */
typedef void(^PrepareExecuteBlock)(void);

typedef void(^SuccessBlock)(NSURLSessionDataTask * task, id responseObject);

typedef void(^FailureBlock)(NSURLSessionDataTask * task, NSError * error);

@interface AvalonsoftHttpClient : NSObject

+(AvalonsoftHttpClient *)avalonsoftHttpClient;

/**
 *  HTTP请求（GET,POST,PUT,DELETE）
 *
 *  @param actionName   请求地址
 *  @param method       请求类型
 *  @param params       请求参数
 *  @param prepare      请求前预处理
 *  @param success      请求成功处理
 *  @param failure      请求失败处理
 */
- (void)requestWithAction:(NSString *)actionName
                   method:(NSInteger)method
              paramenters:(NSDictionary *)params
           prepareExecute:(PrepareExecuteBlock)prepare
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

/**
*  HTTP请求（GET,POST,PUT,DELETE）
*
*  @param serverUrl    服务器地址
*  @param actionName   请求地址
*  @param method       请求类型
*  @param params       请求参数
*  @param prepare      请求前预处理
*  @param success      请求成功处理
*  @param failure      请求失败处理
*/
- (void)requestWithAction:(NSString *)serverUrl
               actionName:(NSString *)actionName
                   method:(NSInteger)method
              paramenters:(NSDictionary *)params
           prepareExecute:(PrepareExecuteBlock)prepare
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

/**
*  HTTP请求（GET,POST,PUT,DELETE）
*
*  @param serverUrl    带参数的服务器地址
*  @param method       请求类型
*  @param params       请求参数
*  @param prepare      请求前预处理
*  @param success      请求成功处理
*  @param failure      请求失败处理
*/
- (void)requestWithActionUrlAndParam:(NSString *)serverUrl
                              method:(NSInteger)method
                         paramenters:(NSDictionary *)params
                      prepareExecute:(PrepareExecuteBlock)prepare
                             success:(SuccessBlock)success
                             failure:(FailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
