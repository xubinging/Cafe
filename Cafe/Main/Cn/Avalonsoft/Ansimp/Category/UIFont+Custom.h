//
//  UIFont+Custom.h
//  CMBase-d7afa43e
//
//  Created by zhangrui on 2019/9/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, FontWeightStyle) {
    FontWeightStyleMedium, // 中黑体
    FontWeightStyleSemibold, // 中粗体
    FontWeightStyleLight, // 细体
    FontWeightStyleUltralight, // 极细体
    FontWeightStyleRegular, // 常规体
    FontWeightStyleThin, // 纤细体
};

typedef NS_ENUM(NSInteger, CM_FontWeight) {
    CM_FontWeightUltraLight = 1,
    CM_FontWeightThin,
    CM_FontWeightLight,
    CM_FontWeightRegular,
    CM_FontWeightMedium,
    CM_FontWeightSemibold,
    CM_FontWeightBold,
    CM_FontWeightHeavy,
    CM_FontWeightBlack
};

@interface UIFont (Custom)
/**
 苹方字体
 
 @param fontWeight 字体粗细（字重)
 @param fontSize 字体大小
 @return 返回指定字重大小的苹方字体
 */
+ (UIFont *)pingFangSCWithWeight:(FontWeightStyle)fontWeight size:(CGFloat)fontSize;

/// 系统字体
/// @param fontSize 字体大小
/// @param weight 字重
+ (UIFont *)customSystemFontOfSize:(CGFloat)fontSize weight:(CM_FontWeight)weight;

/// DIN Condensed Bold
/// @param fontSize 字体大小
+ (UIFont *)dinCondensedBoldWithFontSize:(CGFloat)fontSize;

/// 思源宋粗体
/// @param fontSize 字体大小
+ (UIFont *)sourceHanSerifWithFontSize:(CGFloat)fontSize;
@end

NS_ASSUME_NONNULL_END
