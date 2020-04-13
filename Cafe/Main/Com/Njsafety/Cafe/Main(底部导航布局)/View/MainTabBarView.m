//
//  MainTabBarView.m
//  Cafe
//
//  Created by leo on 2019/12/16.
//  Copyright © 2019 leo. All rights reserved.
//

#import "MainTabBarView.h"

@implementation MainTabBarView

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 布局tabBar上的tabBarItem
    CGFloat tabBarItemWidth = self.frame.size.width / 3;
    CGFloat tabBarItemIndex = 0;
    
    for (UIView *childItem in self.subviews) {
        if ([childItem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            CGRect frame = childItem.frame;
            // 设置宽度
            frame.size.width = tabBarItemWidth;
            
            // 设置x位置
            frame.origin.x = tabBarItemIndex * tabBarItemWidth;
            childItem.frame = frame;
            
            tabBarItemIndex ++;
        }
    }
}

@end
