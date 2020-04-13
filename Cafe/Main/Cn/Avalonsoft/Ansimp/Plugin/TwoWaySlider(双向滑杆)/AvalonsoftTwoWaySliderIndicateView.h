//
//  AvalonsoftTwoWaySliderIndicateView.h
//  Cafe
//
//  Created by leo on 2020/3/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    AvalonsoftTwoWayIndicateDirectionNormal,
    AvalonsoftTwoWayIndicateDirectionLeft,
    AvalonsoftTwoWayIndicateDirectionRight,
} AvalonsoftTwoWayIndicateDirection;

@interface AvalonsoftTwoWaySliderIndicateView : UIView

//背景色
@property (strong, nonatomic) UIColor *backIndicateColor;
@property (strong, nonatomic, readonly) UILabel *indicateLabel;

//设置标题
- (void)setTitle:(NSString *)title;

//设置指示方向
- (void)setDirection:(AvalonsoftTwoWayIndicateDirection)direction;

//设置指示方向为正常状态
- (void)setDirectionAnimateToNormal;

@end

NS_ASSUME_NONNULL_END
