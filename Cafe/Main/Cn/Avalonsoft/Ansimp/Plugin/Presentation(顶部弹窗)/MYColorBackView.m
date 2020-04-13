//
//  MYColorBackView.m
//  Cafe
//
//  Created by leo on 2019/12/22.
//  Copyright © 2019 leo. All rights reserved.
//

#import "MYColorBackView.h"

@implementation MYColorBackView

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,0)];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (UIView *)backColorView
{
    if (!_backColorView) {
        _backColorView = [[UIView alloc]initWithFrame:CGRectMake(0,StatusBarSafeTopMargin+64, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height -StatusBarSafeTopMargin- 64)];
    }
    return _backColorView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.topView];
        [self addSubview:self.backColorView];
    }
    return self;
}

@end
