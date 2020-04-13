//
//  AvalonsoftPickerUIBaseView.h
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvalonsoftPickerViewManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftPickerUIBaseView : UIView

@property (nonatomic , strong) AvalonsoftPickerViewManager *manager;

@property (nonatomic, strong) UIView *backgroundView;   // 背景视图

@property (nonatomic, strong) UIView *alertView;        // 弹出视图

@property (nonatomic, strong) UIView *topView;          // 顶部视图

@property (nonatomic, strong) UIButton *leftBtn;        // 左边取消按钮

@property (nonatomic, strong) UIButton *rightBtn;       // 右边确定按钮

@property (nonatomic, strong) UILabel *titleLabel;      // 中间标题

@property (nonatomic, strong) UIView *lineView;         // 分割线视图

// 初始化子视图
- (void)initUI;

// 点击背景遮罩图层事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;

// 取消按钮的点击事件
- (void)clickLeftBtn;

// 确定按钮的点击事件
- (void)clickRightBtn;

@end

NS_ASSUME_NONNULL_END
