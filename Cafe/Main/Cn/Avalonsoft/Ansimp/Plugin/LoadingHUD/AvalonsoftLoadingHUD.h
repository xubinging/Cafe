//
//  AvalonsoftLoadingHUD.h
//  SmartLock
//
//  Created by leo on 2019/9/12.
//  Copyright © 2019 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvalonsoftProgressView.h"

typedef NS_ENUM(NSUInteger, AvalonsoftProgressViewStyle) {
    AvalonsoftProgressViewStyleNone,
    AvalonsoftProgressViewStyleLightGray,
    AvalonsoftProgressViewStyleGray,
    AvalonsoftProgressViewStyleRed,
    AvalonsoftProgressViewStyleBlack,
    AvalonsoftProgressViewStyleCustom
};

@interface AvalonsoftLoadingHUD : UIView

@property (nonatomic, strong) AvalonsoftProgressView *centerView;

/**
 设置中间焦点视图的样式
 
 @param type 样式类型
 */
+ (void) setCenterViewMaskType:(AvalonsoftProgressViewStyle) type;

/**
 设置提示框的前景颜色
 
 @param color 色值
 */
+ (void) foreignColor:(UIColor *) color;

/**
 设置圆角大小
 
 @param radius 圆角半径
 */
+ (void) setCornerRadius:(CGFloat) radius;

/**
 设置成功图片
 
 @param successImg 成功图片
 */
+ (void) setSuccessImg:(UIImage *) successImg;

/**
 设置失败图片
 
 @param failureImg 失败图片
 */
+ (void) setFailureImg:(UIImage *) failureImg;

/**
 设置警告图片
 
 @param warningImg 警告图片
 */
+ (void) setWarningImg:(UIImage *) warningImg;

/**
 带加载转圈圈的提示框
 
 @param status 提示文案
 */
+ (void) showIndicatorWithStatus:(NSString *) status;

/**
 加载成功的提示框
 
 @param status 提示文案
 */
+ (void) showSuccessWithStatus:(NSString *) status;

/**
 加载失败的提示框
 
 @param status 提示文案
 */
+ (void) showFailureWithStatus:(NSString *) status;

/**
 警告提示框
 
 @param status 提示文案
 */
+ (void) showWarningWithStatus:(NSString *) status;

/**
 提示框消失
 */
+ (void) dismiss;

@end

