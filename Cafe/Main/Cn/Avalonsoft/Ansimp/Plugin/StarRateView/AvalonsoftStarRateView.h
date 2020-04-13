//
//  AvalonsoftStarRateView.h
//  Cafe
//
//  Created by leo on 2020/2/24.
//  Copyright © 2020 leo. All rights reserved.
//
//  星级评分插件

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AvalonsoftStarRateView;

typedef NS_ENUM(NSInteger, AvalonsoftStarRateStyle)
{
    WholeStar = 0,      //只能整星评论
    HalfStar = 1,       //允许半星评论
    IncompleteStar = 2  //允许不完整星评论
};

@protocol AvalonsoftStarRateViewDelegate <NSObject>

-(void)avalonsoftStarRateView:(AvalonsoftStarRateView *)starRateView currentScore:(CGFloat)currentScore;

@end

@interface AvalonsoftStarRateView : UIView

@property (nonatomic, assign) BOOL isAnimation;                     // 是否动画显示，默认NO

@property (nonatomic, assign) AvalonsoftStarRateStyle rateStyle;    // 评分样式 默认是WholeStar

@property (nonatomic, assign) NSInteger numberOfStars;              // 星星数量，默认5颗
@property (nonatomic, assign) CGFloat currentScore;                 // 当前评分: 0-5 默认0

@property (nonatomic, weak) id<AvalonsoftStarRateViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame
                isClickabled:(BOOL)isClickabled
         foregroundStarImage:(NSString *)foregroundStarImage
         backgroundStarImage:(NSString *)backgroundStarImage
                    delegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
