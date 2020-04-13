//
//  AvalonsoftHttpClient.m
//  SmartLock
//
//  Created by leo on 2019/9/7.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftHttpClient.h"
#import "AFNetworking.h"

@interface AvalonsoftHttpClient ()

@property (nonatomic, strong) AFHTTPSessionManager * manager;

@end

@implementation AvalonsoftHttpClient

#pragma mark - 初始化 -
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.manager = [AFHTTPSessionManager manager];

        //设置请求类型为json
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //设置响应类型为json
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //设置可接受的数据类型
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //请求队列的最大并发数
        //self.manager.operationQueue.maxConcurrentOperationCount = 5;
        //请求超时的时间
        self.manager.requestSerializer.timeoutInterval = SERVER_CONNECTION_TIMEOUT;
        
        //传token和访问来源 1、安卓 2、iOS 3、web
        if([_F isStringNotEmptyOrNil:_UserInfo.token]){
            //token不为空，传过去
            [self.manager.requestSerializer setValue:_UserInfo.token forHTTPHeaderField:@"Authorization"];
        }
        [self.manager.requestSerializer setValue:@"2" forHTTPHeaderField:@"loginSource"];
        
        
    }
    return self;
}

//单例
+ (AvalonsoftHttpClient *)avalonsoftHttpClient
{
    static AvalonsoftHttpClient * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//请求连接
- (void)requestWithAction:(NSString *)actionName
                   method:(NSInteger)method
              paramenters:(NSDictionary *)params
           prepareExecute:(PrepareExecuteBlock)prepare
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure
{
    //根据传进来的action名称，拼接url路径
    NSString * url = [NSString stringWithFormat:@"%@%@:%@/%@/%@",SERVER_PROTOCOL,SERVER_IP,SERVER_PORT,SERVER_PRJ_NAME,actionName];
    
    //预处理
    if (prepare) {
        prepare();
    }
    
    //连接网络
    switch (method) {
        case HttpRequestGet:
            [self.manager GET:url parameters:params headers:nil progress:nil success:success failure:failure];
            break;
        case HttpRequestPost:
            [self.manager POST:url parameters:params headers:nil progress:nil success:success failure:failure];
            break;
        case HttpRequestPut:
            [self.manager PUT:url parameters:params headers:nil success:success failure:failure];
            break;
        case HttpRequestDelete:
            [self.manager DELETE:url parameters:params headers:nil success:success failure:failure];
            break;
        default:
            break;
    }
    
}

//请求连接
- (void)requestWithAction:(NSString *)serverUrl
               actionName:(NSString *)actionName
                   method:(NSInteger)method
              paramenters:(NSDictionary *)params
           prepareExecute:(PrepareExecuteBlock)prepare
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure
{
    //根据传进来的action名称，拼接url路径
    NSString * url = [NSString stringWithFormat:@"%@/%@",serverUrl,actionName];
    
    //预处理
    if (prepare) {
        prepare();
    }
    
    //连接网络
    switch (method) {
        case HttpRequestGet:
            [self.manager GET:url parameters:params headers:nil progress:nil success:success failure:failure];
            break;
        case HttpRequestPost:
            [self.manager POST:url parameters:params headers:nil progress:nil success:success failure:failure];
            break;
        case HttpRequestPut:
            [self.manager PUT:url parameters:params headers:nil success:success failure:failure];
            break;
        case HttpRequestDelete:
            [self.manager DELETE:url parameters:params headers:nil success:success failure:failure];
            break;
        default:
            break;
    }
    
}

- (void)requestWithActionUrlAndParam:(NSString *)serverUrl
                   method:(NSInteger)method
              paramenters:(NSDictionary *)params
           prepareExecute:(PrepareExecuteBlock)prepare
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure
{
    
    //预处理
    if (prepare) {
        prepare();
    }
    
    //连接网络
    switch (method) {
        case HttpRequestGet:
            [self.manager GET:serverUrl parameters:params headers:nil progress:nil success:success failure:failure];
            break;
        case HttpRequestPost:
            [self.manager POST:serverUrl parameters:params headers:nil progress:nil success:success failure:failure];
            break;
        case HttpRequestPut:
            [self.manager PUT:serverUrl parameters:params headers:nil success:success failure:failure];
            break;
        case HttpRequestDelete:
            [self.manager DELETE:serverUrl parameters:params headers:nil success:success failure:failure];
            break;
        default:
            break;
    }
    
}

@end
