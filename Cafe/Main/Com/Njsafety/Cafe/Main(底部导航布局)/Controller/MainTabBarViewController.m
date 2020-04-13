//
//  MainTabBarViewController.m
//  Cafe
//
//  Created by leo on 2019/12/16.
//  Copyright © 2019 leo. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "MainNavigationViewController.h"
#import "MainTabBarView.h"

#import "MineMainViewController.h"          //我的


@interface MainTabBarViewController ()

@property (nonatomic, strong) MineMainViewController *mineMainVc;

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 该方法设置的是 UITabBar 的 Item 未选中颜色，这样选中的颜色就能正常显示了，
    // 目前发现是在iOS13的系统上会出现页面push再返回，选中的颜色会变成系统自定义的蓝色
    if (@available(iOS 13.0, *)) {
        [[UITabBar appearance] setUnselectedItemTintColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]];
    }
    
    // 我的
    [self addChildViewController:self.mineMainVc image:@"mine_unselect" selectedImage:@"mine_select" title:@"我的"];
        
    // MainTabBarView
    MainTabBarView *mainTabBarView = [[MainTabBarView alloc] init];
    [self setValue:mainTabBarView forKeyPath:@"tabBar"];
    
}

/**
 *  添加子控制器
 *
 *  @param childViewController 子控制器
 *  @param image               tabBarItem正常状态图片
 *  @param selectedImage       tabBarItem选中状态图片
 *  @param title               标题
 */
- (void)addChildViewController:(UIViewController *)childViewController image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    //标题
    childViewController.title = title;
    
    //tabBarItem图片
    childViewController.tabBarItem.image = [UIImage imageNamed:image];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem字体的设置
    //正常状态
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSFontAttributeName] = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    normalText[NSForegroundColorAttributeName] = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    [childViewController.tabBarItem setTitleTextAttributes:normalText forState:UIControlStateNormal];
    
    //选中状态
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSFontAttributeName] = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    selectedText[NSForegroundColorAttributeName] = [UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0];
    [childViewController.tabBarItem setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    //导航控制器
    MainNavigationViewController *navgationVC = [[MainNavigationViewController alloc] initWithRootViewController:childViewController];
    [self addChildViewController:navgationVC];
    
}


- (MineMainViewController *)mineMainVc
{
    if(_mineMainVc == nil){
        _mineMainVc = [MineMainViewController new];
    }
    return _mineMainVc;
}

@end
