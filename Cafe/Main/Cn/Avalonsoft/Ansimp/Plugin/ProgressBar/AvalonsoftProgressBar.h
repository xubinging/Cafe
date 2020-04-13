//
//  AvalonsoftProgressBar.h
//  Cafe
//
//  Created by leo on 2020/1/1.
//  Copyright © 2020 leo. All rights reserved.
//
//  自定义进度条

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AvalonsoftProgressBarStyle) {
    AvalonsoftProgressBarStyleDefault,         // 默认
    AvalonsoftProgressBarStyleTrackFillet ,    // 轨道圆角(默认半圆)
    AvalonsoftProgressBarStyleAllFillet,       // 进度与轨道都圆角
};

@interface AvalonsoftProgressBar : UIView

@property(nonatomic) float progress;    // 0.0 .. 1.0, 默认0 超出为1.

@property(nonatomic) AvalonsoftProgressBarStyle progressViewStyle;

@property(nonatomic,assign) BOOL isTile;  //背景图片是平铺填充 默认NO拉伸填充 设置为YES时图片复制平铺填充

@property(nonatomic, strong, nullable) UIColor* progressTintColor;

@property(nonatomic, strong, nullable) UIColor* trackTintColor;

@property(nonatomic, strong, nullable) UIImage* progressImage;  //进度条背景图片,默认拉伸填充  优先级大于背景色

@property(nonatomic, strong, nullable) UIImage* trackImage;     //轨道填充图片

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame progressViewStyle:(AvalonsoftProgressBarStyle)style;
@end

NS_ASSUME_NONNULL_END
