//
//  AvalonsoftAreaPickerListView.h
//  Cafe
//
//  Created by leo on 2020/2/12.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AvalonsoftAreaPickerListView;
@class AvalonsoftAreaPickerModel;

@protocol AvalonsoftAreaPickerListViewDelegate<NSObject>
- (void)AvalonsoftAreaPickerListView:(AvalonsoftAreaPickerListView *)AvalonsoftAreaPickerListView didSelcetedValue:(AvalonsoftAreaPickerModel *)value;

@end

@interface AvalonsoftAreaPickerListView : UIView

//数据源
@property (nonatomic , strong) NSArray * dataArray;

//已选择的字符串
@property (nonatomic, copy) NSString *selectText;
@property (nonatomic, weak) id<AvalonsoftAreaPickerListViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
