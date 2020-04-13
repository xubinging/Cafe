//
//  AvalonsoftHasNetwork.m
//  SmartLock
//
//  Created by leo on 2019/9/11.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftHasNetwork.h"
#import "AFNetworkReachabilityManager.h"

@implementation AvalonsoftHasNetwork

// 监听是否有网络
+ (void)avalonsoft_hasNetwork:(void (^)(bool))hasNet
{
    //创建网络监听对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manager startMonitoring];
    //监听改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                hasNet(NO);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                hasNet(YES);
                break;
        }
    }];
    //结束监听
    [manager stopMonitoring];
}

@end
