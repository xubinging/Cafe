//
//  AvalonsoftMenuButton.h
//  Cafe
//
//  Created by leo on 2019/12/31.
//  Copyright © 2019 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftMenuButton : UIButton

// 标题标签
@property (nonatomic, strong) UILabel *btnTitleLabel;

// 图片视图
@property (nonatomic, strong) UIImageView *btnImageView;

// 图片地址
@property (nonatomic, copy) NSString *imageString;

// 标题文字
@property (nonatomic, copy) NSString *titleString;

// 标题颜色
@property (nonatomic, copy) UIColor *titleColor;

// 标题字体
@property (nonatomic, copy) UIFont *titleFont;

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
              withImageString:(NSString *)imageString;

@end

NS_ASSUME_NONNULL_END
