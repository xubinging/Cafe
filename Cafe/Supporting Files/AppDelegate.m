//
//  AppDelegate.m
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AppDelegate.h"

#import "AcSysSplash.h"     //启动页

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //首页所有菜单图标
    self.homeMenuDict = @{
        @"1":@"home_menu_foreign_new",          //国外院校
        @"2":@"home_menu_international_new",    //国际学校
        @"3":@"home_menu_service_new",          //服务机构
        @"4":@"home_menu_analysis_new",         //留学把脉
        @"5":@"home_menu_warning_new",          //留学预警
        @"6":@"home_menu_shows_new",            //留学展会
        @"7":@"home_menu_news_new",             //留学要闻
        @"8":@"home_menu_activity_new",         //校友活动
        @"9":@"home_menu_visa_new",             //签证新动态
        @"10":@"home_menu_offer_new",           //秀秀offer
        @"11":@"home_menu_score_new",           //看看成绩
        @"12":@"home_menu_time_new",            //时间轴
        
        @"13":@"home_menu_smartfilter",         //smartFilter
        @"14":@"home_menu_edupass",             //eduPASS
        @"15":@"home_menu_banking",             //出国金融
        @"16":@"home_menu_safe",                //留学保险
        @"17":@"home_menu_ticket",              //机票预订
        @"18":@"home_menu_hotel",               //留学生公寓
        @"19":@"home_menu_car",                 //留学生购物车
        @"20":@"home_menu_job"                  //海归就业创业
    };
    
    //首页和社区 - 我感兴趣的 - 模块名称对照
    self.myInterestDict = @{
        @"1":@"学学留学",
        @"2":@"说说留学",
        @"3":@"签证法规",
        @"4":@"线上讲座",
        @"5":@"考试攻略分享",
        @"6":@"找同校同城同行",
        @"7":@"说说学校",
        @"8":@"留学布告",
        @"9":@"成功案例",
        @"10":@"高分榜",
        @"11":@"管管留学",
        @"12":@"留学夏令营",
        @"13":@"留学服务区"
    };
    
    self.myInterestExistDict = @{
//        @"1":@"学学留学",
//        @"2":@"说说留学",
//        @"3":@"签证法规",
//        @"4":@"线上讲座",
//        @"5":@"考试攻略分享",
//        @"6":@"找同校同城同行",
//        @"7":@"说说学校",
//        @"8":@"留学布告",
//        @"9":@"成功案例",
//        @"10":@"高分榜",
//        @"11":@"管管留学",
//        @"12":@"留学夏令营",
//        @"13":@"留学服务区"
    };
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    //启动页
    AcSysSplash *acSysSplash = [AcSysSplash new];

    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:acSysSplash];
    
    self.window.rootViewController = navigation;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
