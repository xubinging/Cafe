//
//  AvalonsoftStarRateView.m
//  Cafe
//
//  Created by leo on 2020/2/24.
//  Copyright © 2020 leo. All rights reserved.
//
//  星级评分插件

#import "AvalonsoftStarRateView.h"

@interface AvalonsoftStarRateView()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, strong) NSString *foregroundStarImage;
@property (nonatomic, strong) NSString *backgroundStarImage;

@property (nonatomic, assign) BOOL isClickabled;    // 是否动画显示, 默认NO

@end

@implementation AvalonsoftStarRateView

- (instancetype)initWithFrame:(CGRect)frame
                 isClickabled:(BOOL)isClickabled
          foregroundStarImage:(NSString *)foregroundStarImage
          backgroundStarImage:(NSString *)backgroundStarImage
                     delegate:(id)delegate
{
    if (self = [super initWithFrame:frame]) {
        _isAnimation = NO;
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        
        _isClickabled = isClickabled;
        _foregroundStarImage = foregroundStarImage;
        _backgroundStarImage = backgroundStarImage;
        _delegate = delegate;
        
        if(!_foregroundStarImage){
            _foregroundStarImage = @"home_service_train_star_color";
        }
        if(!_backgroundStarImage){
            _backgroundStarImage = @"home_service_train_star_gray";
        }
        [self createStarView];
    }
    return self;
}

#pragma mark - private Method
-(void)createStarView{

    self.foregroundStarView = [self createStarViewWithImage:_foregroundStarImage];
    self.backgroundStarView = [self createStarViewWithImage:_backgroundStarImage];
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*_currentScore/self.numberOfStars, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];

}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    if(_isClickabled){
        CGPoint tapPoint = [gesture locationInView:self];
        CGFloat offset = tapPoint.x;
        CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
        switch (_rateStyle) {
            case WholeStar:
            {
                self.currentScore = ceilf(realStarScore);
                break;
            }
            case HalfStar:
                self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
                break;
            case IncompleteStar:
                self.currentScore = realStarScore;
                break;
            default:
                break;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak AvalonsoftStarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore/self.numberOfStars, weakSelf.bounds.size.height);
    }];
}

-(void)setCurrentScore:(CGFloat)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    } else {
        _currentScore = currentScore;
    }
    
    //点击后调用代理方法
    if ([self.delegate respondsToSelector:@selector(avalonsoftStarRateView:currentScore:)]) {
        [self.delegate avalonsoftStarRateView:self currentScore:_currentScore];
    }
    
    [self setNeedsLayout];
}

@end
