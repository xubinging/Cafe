//
//  AvalonsoftAreaPickerCollectionViewCell.m
//  Cafe
//
//  Created by leo on 2020/2/12.
//  Copyright © 2020 leo. All rights reserved.
//
//  用于生成地区选择器头部

#import "AvalonsoftAreaPickerCollectionViewCell.h"

@implementation AvalonsoftAreaPickerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView
{
    self.tLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.tLb.textAlignment = NSTextAlignmentCenter;
    self.tLb.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    self.tLb.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    [self addSubview:self.tLb];
}

- (void)layoutSubviews
{
    self.tLb.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
