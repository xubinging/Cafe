//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  Cafe
//
//  Created by leo on 2019/12/13.
//  Copyright © 2019 leo. All rights reserved.
//
//  改变 UILabel 文本行间距和字间距；计算文本宽高

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (ChangeLineSpaceAndWordSpace)

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

/**
 *  计算文本高度
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width text:(NSString *)text font:(UIFont*)font lineSpace:(CGFloat)lineSpace;

/**
 *  计算文本宽度
 */
+ (CGFloat)getWidthWithText:(NSString *)text font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
