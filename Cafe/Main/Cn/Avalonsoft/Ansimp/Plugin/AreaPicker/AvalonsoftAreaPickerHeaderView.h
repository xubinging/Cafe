//
//  AvalonsoftAreaPickerHeaderView.h
//  Cafe
//
//  Created by leo on 2020/2/12.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AvalonsoftAreaPickerHeaderView;
@protocol AvalonsoftAreaPickerHeaderViewDelegate<NSObject>
- (void)AvalonsoftAreaPickerHeaderView:(AvalonsoftAreaPickerHeaderView *)AvalonsoftAreaPickerHeaderView didSelcetIndex:(NSInteger )index;
@end

@interface AvalonsoftAreaPickerHeaderView : UIView

@property (nonatomic , weak) id<AvalonsoftAreaPickerHeaderViewDelegate> dalegate;
@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , assign) BOOL isLastRed; //最后一个时候是红色

- (void)setindex:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
