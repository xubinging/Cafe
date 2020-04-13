//
//  AvalonsoftHasNetwork.h
//  SmartLock
//
//  Created by leo on 2019/9/11.
//  Copyright © 2019 leo. All rights reserved.
//
//  该类仅用做判断是否有网络连接

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftHasNetwork : NSObject

// 监听是否有网络
+ (void)avalonsoft_hasNetwork:(void(^)(bool has))hasNet;

@end

NS_ASSUME_NONNULL_END
