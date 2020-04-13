//
//  AvalonsoftStringPickerView.h
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftPickerUIBaseView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  @param selectValue     选择的行标题文字
 *  @param selectRow       选择的行标题下标
 */
typedef void(^AvalonsoftStringResultBlock)(id selectValue,id selectRow);

@interface AvalonsoftStringPickerView : AvalonsoftPickerUIBaseView

/**
 *  显示自定义字符串选择器
 *
 *  @param title            标题
 *  @param dataSource       数组数据源
 *  @param defaultSelValue  默认选中的行(单列传字符串，多列传字符串数组)
 *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock      选择后的回调
 *
 */
+ (void)showStringPickerWithTitle:(NSString *)title
                       DataSource:(NSArray *)dataSource
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock;

/**
 *  显示自定义字符串选择器
 *
 *  @param title            标题
 *  @param fileName         fileName文件名
 *  @param defaultSelValue  默认选中的行(单列传字符串，多列传字符串数组)
 *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock      选择后的回调
 *
 */
+ (void)showStringPickerWithTitle:(NSString *)title
                         FileName:(NSString *)fileName
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock;

/**
 *  显示自定义字符串选择器   常规个人信息选项
 *
 *  @param title            标题
 *  @param defaultSelValue  默认选中的行(单列传字符串，多列传字符串数组)
 *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock      选择后的回调
 *  @param style            样式选择
 *
 */
+ (void)showStringPickerWithTitle:(NSString *)title
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock
                            Style:(NSInteger)style;

// 根据style的值，从本地存储的plist文件中返回默认单行个人信息数组
// 这种方法需要确定style值的范围 + 本地存储好的plist文件
+ (NSArray *)showStringPickerDataSourceStyle:(NSInteger)style;

@end

NS_ASSUME_NONNULL_END
