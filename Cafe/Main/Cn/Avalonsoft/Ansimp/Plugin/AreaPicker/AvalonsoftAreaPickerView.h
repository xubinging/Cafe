//
//  AvalonsoftAreaPickerView.h
//  Cafe
//
//  Created by leo on 2020/2/12.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AvalonsoftAreaPickerView;
@class AvalonsoftAreaPickerModel;
@protocol AvalonsoftAreaPickerViewDelegate<NSObject>

/**
 点击Cell的回调  返回下一个视图需要的数据数组
 @param AvalonsoftAreaPickerView 视图
 @param tier 点击的第几层
 @param value 点击那一列的数据
 */
- (NSMutableArray<AvalonsoftAreaPickerModel *> *)AvalonsoftAreaPickerView:(AvalonsoftAreaPickerView *)AvalonsoftAreaPickerView didSelcetedTier:(NSInteger)tier selcetedValue:(AvalonsoftAreaPickerModel *)value;

/**
 完成时候的回调

 @param AvalonsoftAreaPickerView 视图
 @param complete 完成时候返回拼接的字符串
 */
@required
- (void)MCPickerView:(AvalonsoftAreaPickerView *)AvalonsoftAreaPickerView completeArray:(NSMutableArray<AvalonsoftAreaPickerModel *> *)comArray completeStr:(NSString *)comStr ;

@end

@interface AvalonsoftAreaPickerView : UIView

@property (nonatomic, weak) id<AvalonsoftAreaPickerViewDelegate> delegate;

/**
 选择窗的title
 */
@property (nonatomic , copy) NSString *titleText;

/**
 每一层的数据数组
 */
@property (nonatomic , strong) NSArray<AvalonsoftAreaPickerModel *> *dataArray;


/**
 给每一层数据添加数据源 有默认选择的字符串
 无默认选择的话推荐使用 setDataArray

 @param dataArray 数据源
 @param Text 默认选择的字符串
 */
- (void)setData:(NSArray<AvalonsoftAreaPickerModel *> *)dataArray selectText:(NSString *)Text;

@end

NS_ASSUME_NONNULL_END
