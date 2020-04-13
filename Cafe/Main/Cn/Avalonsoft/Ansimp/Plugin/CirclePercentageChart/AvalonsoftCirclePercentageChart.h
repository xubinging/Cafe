//
//  AvalonsoftCirclePercentageChart.h
//  Cafe
//
//  Created by leo on 2020/2/22.
//  Copyright © 2020 leo. All rights reserved.
//
//  环形百分比图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftCirclePercentageChart : UIView

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame withMaxValue:(CGFloat)maxValue value:(CGFloat)value;

//值文字相关
@property (nonatomic, copy) NSString *valueTitle;
@property (nonatomic, weak) UIColor *valueColor;
@property (nonatomic, weak) UIFont *valueFont;

//渐变色数组
@property (nonatomic, strong) NSArray *colorArray;
//渐变色数组所占位置
@property (nonatomic, strong) NSArray *locations;
//底圆颜色
@property (nonatomic, strong) UIColor *insideCircleColor;
//单色
@property (nonatomic, strong) UIColor *singleColor;

@end

NS_ASSUME_NONNULL_END
