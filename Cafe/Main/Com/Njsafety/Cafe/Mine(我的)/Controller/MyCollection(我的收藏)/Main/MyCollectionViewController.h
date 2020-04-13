//
//  MyCollectionViewController.h
//  Cafe
//
//  Created by leo on 2020/1/5.
//  Copyright © 2020 leo. All rights reserved.
//
//  我的收藏

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionViewController : UIViewController

//标签栏标题数组
@property (nonatomic, strong) NSArray *titleArray;

//每个标签对应ViewController数组
@property (nonatomic, strong) NSArray *subViewControllers;

//非选中状态下标签字体颜色
@property (nonatomic, strong) UIColor *titleColor;

//选中标签字体颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;

//非选中状态下标签字体
@property (nonatomic, strong) UIFont *titleFont;

//选中标签字体
@property (nonatomic, strong) UIFont  *titleSelectedFont;

//标签栏每个按钮高度
@property (nonatomic, assign) CGFloat buttonHeight;

//标签栏每个按钮宽度
@property (nonatomic, assign) CGFloat buttonWidth;

@end

NS_ASSUME_NONNULL_END
