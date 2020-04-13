//
//  AvalonsoftProgressView.m
//  SmartLock
//
//  Created by leo on 2019/9/12.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftProgressView.h"

#define kRect CGRectMake((self.bounds.size.width - 36) / 2, 10, 36, 36)

@interface AvalonsoftProgressView()

@end

@implementation AvalonsoftProgressView

- (instancetype)initWithFrame:(CGRect)frame indicatorStyle:(AvalonsoftLoadingIndicatorStyle)style
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self setupUIWithStyle:style];
    }
    return self;
}

- (void) setupUIWithStyle:(AvalonsoftLoadingIndicatorStyle) style{
    switch (style) {
        case AvalonsoftLoadingIndicatorStyle_Progress:{
            [self addSubview:self.indicatorView];
            [self changeIndicatorImgFrame];
            [self.indicatorView startAnimating];
            [self addSubview:self.statusLabel];
            break;
        }
        case AvalonsoftLoadingIndicatorStyle_Success:{
            [self addSubview:self.staticImgView];
            self.staticImgView.image = [UIImage imageNamed:kDefaultSuccessImgName];
            [self addSubview:self.statusLabel];
            break;
        }
        case AvalonsoftLoadingIndicatorStyle_Failure:{
            [self addSubview:self.staticImgView];
            self.staticImgView.image = [UIImage imageNamed:kDefaultFailureImgName];
            [self addSubview:self.statusLabel];
            break;
        }
        case AvalonsoftLoadingIndicatorStyle_Warning:{
            [self addSubview:self.staticImgView];
            self.staticImgView.image = [UIImage imageNamed:kDefaultWarningImgName];
            [self addSubview:self.statusLabel];
            break;
        }
        default:
            break;
    }
}

//修改菊花圈位置
- (void) changeIndicatorImgFrame{
    UIImageView *imgV = self.indicatorView.subviews[0];
    imgV.transform = CGAffineTransformMakeScale(1.5, 1.5);
    CGRect imgRect = imgV.frame;
    imgV.frame = CGRectMake(self.indicatorView.frame.size.width/2 - imgRect.size.width/2, self.indicatorView.frame.size.height/2 - imgRect.size.height/2, imgRect.size.width, imgRect.size.height);
}

- (void)setIndicatorStyle:(AvalonsoftLoadingIndicatorStyle)indicatorStyle
{
    _indicatorStyle = indicatorStyle;
    for (UIView *itemView in self.subviews) {
        [itemView removeFromSuperview];
    }
    [self setupUIWithStyle:indicatorStyle];
}

- (void)reductCircleView{
    UIImageView *imgV = self.indicatorView.subviews[0];
    imgV.transform = CGAffineTransformIdentity;
    CGRect imgRect = imgV.frame;
    imgV.frame = CGRectMake(self.indicatorView.frame.size.width/2-imgRect.size.width/2, self.indicatorView.frame.size.height/2-imgRect.size.height/2, imgRect.size.width, imgRect.size.height);
}

#pragma mark - 懒加载
- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.frame = CGRectMake(kRect.origin.x, kRect.origin.y, kRect.size.width, kRect.size.height);
    }
    return _indicatorView;
}

- (UIImageView *)staticImgView{
    if (!_staticImgView) {
        _staticImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kRect.origin.x, kRect.origin.y, kRect.size.width, kRect.size.height)];
        _staticImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _staticImgView;
}

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        CGFloat x = (self.bounds.size.width - kRect.origin.x * 2) / 2;
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 2 * kRect.origin.y + kRect.size.height, self.bounds.size.width - 2 * x, self.bounds.size.height - kRect.origin.y * 3 - kRect.size.height)];
        _statusLabel.textColor = [UIColor darkGrayColor];
        _statusLabel.numberOfLines = 0;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = [UIFont systemFontOfSize:14];
    }
    return _statusLabel;
}

@end
