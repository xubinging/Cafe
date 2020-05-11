//
//  AvalonsoftPickerView.h
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AvalonsoftPickerViewManager.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  @param selectAddressArr     选择的行标题文字
 *  @param selectAddressRow     选择的行标题下标
 */
typedef void(^AvalonsoftAddressResultBlock)(NSArray *selectAddressArr,NSArray *selectAddressRow);


typedef void(^AvalonsoftDateResultBlock)(NSString *selectValue);

/**
 *  @param selectValue      选择的行标题文字
 *  @param selectRow        选择的行标题下标
 */
typedef void(^AvalonsoftStringResultBlock)(id selectValue,id selectRow);

typedef NS_ENUM(NSInteger, AvalonsoftStringPickerViewStyle) {
    AvalonsoftStringPickerViewStyleEducation,       //学历
    AvalonsoftStringPickerViewStyleBlood,           //血型
    AvalonsoftStringPickerViewStyleAnimal,          //生肖
    AvalonsoftStringPickerViewStylConstellation,    //星座
    AvalonsoftStringPickerViewStyleGender,          //性别
    AvalonsoftStringPickerViewStylNation,           //民族
    AvalonsoftStringPickerViewStylReligious,        //宗教
    AvalonsoftStringPickerViewStyleAge,             //年龄 18岁～80岁
    AvalonsoftStringPickerViewStyleAgeScope,        //年龄范围
    AvalonsoftStringPickerViewStylHeight,           //身高 150cm~220cm
    AvalonsoftStringPickerViewStylHeightScope,      //身高范围
    AvalonsoftStringPickerViewStylWeight,           //体重 40kg~100kg
    AvalonsoftStringPickerViewStylWeightScope,      //体重范围
    AvalonsoftStringPickerViewStylWeek,             //星期
};

@interface AvalonsoftPickerView : UIView

/**
 *  显示地址选择器
 *
 *  @param defaultSelectedArr   默认选中的值(传数组，元素为对应的索引值。如：@[@10, @1, @1])
 *  @param isAutoSelect         是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock          选择后的回调
 *
 */
+ (void)showAddressPickerWithTitle:(NSString *)title
                   DefaultSelected:(NSArray *)defaultSelectedArr
                      IsAutoSelect:(BOOL)isAutoSelect
                           Manager:(AvalonsoftPickerViewManager *)manager
                       ResultBlock:(AvalonsoftAddressResultBlock)resultBlock;


//自定义使用的
+ (void)showAddressPickerWithTitle:(NSString *)title
                   DefaultSelected:(NSArray *)defaultSelectedArr
                          FileName:(NSString *)fileName
                      IsAutoSelect:(BOOL)isAutoSelect
                           Manager:(AvalonsoftPickerViewManager *)manager
                       ResultBlock:(AvalonsoftAddressResultBlock)resultBlock;
/**
 *  显示时间选择器
 *
 *  @param title            标题
 *  @param type             类型（时间、日期、日期和时间、倒计时）
 *  @param defaultSelValue  默认选中的时间（为空，默认选中现在的时间）
 *  @param minDateStr       最小时间（如：2015-08-28 00:00:00），可为空
 *  @param maxDateStr       最大时间（如：2018-05-05 00:00:00），可为空
 *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock      选择结果的回调
 *
 */
+ (void)showDatePickerWithTitle:(NSString *)title
                       DateType:(UIDatePickerMode)type
                DefaultSelValue:(NSString *)defaultSelValue
                     MinDateStr:(NSString *)minDateStr
                     MaxDateStr:(NSString *)maxDateStr
                   IsAutoSelect:(BOOL)isAutoSelect
                        Manager:(AvalonsoftPickerViewManager *)manager
                    ResultBlock:(AvalonsoftDateResultBlock)resultBlock;


/**
 *  显示自定义字符串选择器      自定义
 *
 *  @param title            标题
 *  @param dataSource       数组数据源  单行@[@"ha",@"haha"]    多行@[@[@"ha",@"haha"],@[@"ha",@"haha"]]
 *  @param defaultSelValue  默认选中的行(单列传字符串，多列传一维数组)
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
 *  @param fileName         plist文件名
 *  @param defaultSelValue  默认选中的行(单列传字符串数组，多列传一维数组)
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
 *  显示自定义字符串选择器      默认常规设置常规个人信息选项  单行
 *  @param title            标题
 *  @param defaultSelValue  默认选中的行(单列传字符串，多列传一维数组)
 *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock      选择后的回调
 *  @param style            样式选择
 */
+ (void)showStringPickerWithTitle:(NSString *)title
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock
                            Style:(AvalonsoftStringPickerViewStyle)style;

// 根据style的值，从本地存储的plist文件中返回默认单行个人信息数组
// 这种方法需要确定style值的范围 + 本地存储好的plist文件
+ (NSArray *)showStringPickerDataSourceStyle:(AvalonsoftStringPickerViewStyle)style;

@end

NS_ASSUME_NONNULL_END
