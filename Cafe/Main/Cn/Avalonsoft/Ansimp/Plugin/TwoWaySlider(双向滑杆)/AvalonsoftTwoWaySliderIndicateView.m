//
//  AvalonsoftTwoWaySliderIndicateView.m
//  Cafe
//
//  Created by leo on 2020/3/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftTwoWaySliderIndicateView.h"

// 将角度转为弧度
#define AVALONSOFT_DEGREES_TO_RADOANS(x) (M_PI * (x) / 180.0)

@implementation AvalonsoftTwoWaySliderIndicateView

{
    AvalonsoftTwoWayIndicateDirection _direction;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        _backIndicateColor = [UIColor whiteColor];
        
        _indicateLabel = [[UILabel alloc] init];
        _indicateLabel.backgroundColor = RGBA_GGCOLOR(32, 188, 255, 1);
        _indicateLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _indicateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
        _indicateLabel.textAlignment = NSTextAlignmentCenter;
        _indicateLabel.layer.cornerRadius = 2;
        _indicateLabel.layer.masksToBounds = YES;
    
        [self addSubview:_indicateLabel];
        [_indicateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.width.equalTo(self);
            make.height.equalTo(@20);
        }];
        self.layer.anchorPoint = CGPointMake(0.5, 1.0);
        
        _direction = AvalonsoftTwoWayIndicateDirectionNormal;
    }
    
    return self;
}


- (void)setTitle:(NSString *)title
{
    _indicateLabel.text = title;
}

- (void)setDirection:(AvalonsoftTwoWayIndicateDirection)direction
{
    if (direction == _direction) {
        return;
    }
    _direction = direction;
    CGFloat s = direction == AvalonsoftTwoWayIndicateDirectionLeft? AVALONSOFT_DEGREES_TO_RADOANS(-30) : (direction == AvalonsoftTwoWayIndicateDirectionRight? AVALONSOFT_DEGREES_TO_RADOANS(30) : AVALONSOFT_DEGREES_TO_RADOANS(0));
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(s);
    }];
    
}

- (void)setDirectionAnimateToNormal
{
    [self setDirection:AvalonsoftTwoWayIndicateDirectionNormal];
}

- (void)setBackIndicateColor:(UIColor *)backIndicateColor
{
    _backIndicateColor = backIndicateColor;
    _indicateLabel.backgroundColor = backIndicateColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self drawBackground:self.bounds inContext:UIGraphicsGetCurrentContext()];
}

- (void)drawBackground:(CGRect)frame inContext:(CGContextRef) context
{
    //指向键头
    CGFloat left = CGRectGetMidX(frame) - 4;
    CGFloat right = CGRectGetMidX(frame) + 4;
    CGFloat y0 = 20;
    CGFloat y1 = frame.size.height;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(left, y0)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(frame), y1)];
    [path addLineToPoint:CGPointMake(right, y0)];
    [path closePath];
    
    [_backIndicateColor set];
    [_backIndicateColor setStroke];
    [path stroke];
    [path fill];
}

@end
