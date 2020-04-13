//
//  AvalonsoftMenuScrollView.h
//  Cafe
//
//  Created by leo on 2019/12/31.
//  Copyright © 2019 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AvalonsoftMenuScrollView;

@protocol AvalonsoftMenuScrollViewDelegate <NSObject>

// 点击事件
- (void)buttonUpInsideWithView:(UIButton *)btn
                     withIndex:(NSInteger)index
                      withView:(AvalonsoftMenuScrollView *)view;

@end;

@interface AvalonsoftMenuScrollView : UIView

// maxCount is view count, default is 8
@property (nonatomic, assign) NSInteger maxCount;

// delegate is button click
@property (nonatomic, weak) id<AvalonsoftMenuScrollViewDelegate> delegate;

#pragma mark - Initializers

// 初始化
- (instancetype)initWithFrame:(CGRect)frame
                  viewsArray:(NSArray *)views;
@end

NS_ASSUME_NONNULL_END
