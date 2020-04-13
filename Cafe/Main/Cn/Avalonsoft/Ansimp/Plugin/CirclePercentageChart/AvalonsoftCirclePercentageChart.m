//
//  AvalonsoftCirclePercentageChart.m
//  Cafe
//
//  Created by leo on 2020/2/22.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftCirclePercentageChart.h"

@interface AvalonsoftCirclePercentageChart ()

//中文百分比
@property (nonatomic, weak) UILabel *valueLabel;
//当前数值
@property (nonatomic, assign) CGFloat value;
//总数
@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, strong) CAGradientLayer *colorLayer;

@property (nonatomic, strong) CAShapeLayer *insideShapelayer;

@property (nonatomic, strong) CAShapeLayer *outerShapelayer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation AvalonsoftCirclePercentageChart

- (instancetype)initWithFrame:(CGRect)frame withMaxValue:(CGFloat)maxValue value:(CGFloat)value{
    
    self =  [super initWithFrame:frame];
    
    if (self) {
        if (maxValue < value) {
            maxValue = value;
        }
        
        _value = value;
        _maxValue = maxValue;
        
        [self drawArc];
    }
    return self;
}

-(void)drawArc
{
    //计算中心点
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    //底层圆
    CGFloat radius = self.frame.size.width * 0.5 - 15;
    UIBezierPath* arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    _insideShapelayer = shapelayer;
    shapelayer.lineWidth = 10.0;
    shapelayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;

    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.path = arcPath.CGPath;
    
    [self.layer addSublayer:shapelayer];
    
    //顶层圆
    CGFloat outerRadius = radius;
    
    UIBezierPath *outerArcPath = [UIBezierPath bezierPathWithArcCenter:center radius:outerRadius startAngle:-M_PI_2 endAngle:M_PI * 2 * (_value / _maxValue) - M_PI_2  clockwise:YES];
    
    CAShapeLayer *outerShapelayer = [CAShapeLayer layer];
    _outerShapelayer = outerShapelayer;
    outerShapelayer.lineWidth = 10.0;
    outerShapelayer.strokeColor = [UIColor clearColor].CGColor;
    outerShapelayer.fillColor = [UIColor clearColor].CGColor;
    outerShapelayer.path = outerArcPath.CGPath;
    
    [self.layer addSublayer:outerShapelayer];
    
    //标注
    UILabel *valueLabel = [UILabel new];
    
    [self addSubview:valueLabel];
    self.valueLabel = valueLabel;
    
    valueLabel.frame = CGRectMake(center.x - 22, center.y - 11, 44, 22);
    valueLabel.textColor = RGBA_GGCOLOR(238, 111, 0, 1);
    valueLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    valueLabel.textAlignment = NSTextAlignmentCenter;

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    _gradientLayer = gradientLayer;
    gradientLayer.frame = self.bounds;
    gradientLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:gradientLayer];
    
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    self.colorLayer = colorLayer;
    colorLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    colorLayer.locations = @[@0.1,@1.0];
    colorLayer.startPoint = CGPointMake(0, 0);
    colorLayer.endPoint = CGPointMake(1, 0);
    [gradientLayer addSublayer:colorLayer];
    
    
    CAShapeLayer *gressLayer = [CAShapeLayer layer];
    gressLayer.lineWidth = 10.0;
    gressLayer.strokeColor = [UIColor blueColor].CGColor;
    gressLayer.fillColor = [UIColor clearColor].CGColor;
    gressLayer.lineCap = kCALineCapRound;
    gressLayer.path = outerArcPath.CGPath;
    gradientLayer.mask = gressLayer;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.0;
    [gressLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
}

#pragma mark - set -
- (void)setValueTitle:(NSString *)valueTitle{
    _valueLabel.text = valueTitle;
}

- (void)setValueFont:(UIFont *)valueFont{
    _valueLabel.font = valueFont;
}

- (void)setValueColor:(UIColor *)valueColor{
    _valueLabel.textColor = valueColor;
}

- (void)setInsideCircleColor:(UIColor *)insideCircleColor{
    _insideShapelayer.strokeColor = insideCircleColor.CGColor;
}

- (void)setColorArray:(NSArray *)colorArray{
    _colorArray = colorArray;
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (UIColor *color in colorArray) {
        [array addObject:(id)color.CGColor];
    }
    
    _colorLayer.colors = array.copy;
}

- (void)setLocations:(NSArray *)locations{
    _colorLayer.locations = locations;
}

- (void)setSingleColor:(UIColor *)singleColor{
    _outerShapelayer.strokeColor = singleColor.CGColor;
    [_gradientLayer removeFromSuperlayer];
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.0;
    [_outerShapelayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
}

@end
