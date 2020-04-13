//
//  AppDelegate.h
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

//首页所有菜单
@property(nonatomic, strong) NSDictionary *homeMenuDict;

//首页和社区 - 我感兴趣的 - 模块名称对照
@property(nonatomic, strong) NSDictionary *myInterestDict;

//首页和社区 - 我感兴趣的 - 已存在的模块
@property(nonatomic, strong) NSDictionary *myInterestExistDict;

@end

