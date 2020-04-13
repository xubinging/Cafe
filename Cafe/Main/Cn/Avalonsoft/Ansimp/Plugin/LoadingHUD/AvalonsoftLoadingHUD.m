//
//  AvalonsoftLoadingHUD.m
//  SmartLock
//
//  Created by leo on 2019/9/12.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftLoadingHUD.h"

#define DefaultBackgroundColor [UIColor grayColor]

@implementation AvalonsoftLoadingHUD

#pragma mark - 单例
+ (AvalonsoftLoadingHUD *)sharedView {
    static dispatch_once_t once;
    static AvalonsoftLoadingHUD *sharedView;
    dispatch_once(&once, ^{
        sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        sharedView.backgroundColor = DefaultBackgroundColor;
        sharedView.layer.opacity = 0.7;     //不透明级别
    });
    return sharedView;
}

+ (void) setCenterViewMaskType:(AvalonsoftProgressViewStyle) type{
    switch (type) {
        case AvalonsoftProgressViewStyleNone:{
            [self sharedView].centerView.backgroundColor = [UIColor whiteColor];
            break;
        }
        case AvalonsoftProgressViewStyleLightGray:{
            [self sharedView].centerView.backgroundColor = [UIColor lightGrayColor];
            break;
        }
        case AvalonsoftProgressViewStyleGray:{
            [self sharedView].centerView.backgroundColor = [UIColor grayColor];
            break;
        }
        case AvalonsoftProgressViewStyleRed:{
            [self sharedView].centerView.backgroundColor = [UIColor redColor];
            break;
        }
        case AvalonsoftProgressViewStyleBlack:{
            [self sharedView].centerView.backgroundColor = [UIColor blackColor];
            break;
        }
        default:{
            break;
        }
    }
}

+ (void) foreignColor:(UIColor *) color{
    [self sharedView].centerView.backgroundColor = color;
}

+ (void) setCornerRadius:(CGFloat) radius{
    [self sharedView].centerView.layer.cornerRadius = radius;
    [self sharedView].centerView.layer.masksToBounds = YES;
}

+ (void) setSuccessImg:(UIImage *) successImg{
    [self sharedView].centerView.staticImgView.image = successImg;
}

+ (void) setFailureImg:(UIImage *) failureImg{
    [self sharedView].centerView.staticImgView.image = failureImg;
}

+ (void)setWarningImg:(UIImage *) warningImg{
    [self sharedView].centerView.staticImgView.image = warningImg;
}

+ (void) showIndicatorWithStatus:(NSString *) status{
    [self setupSubViews];
    [self sharedView].centerView.statusLabel.text = status;
    [self sharedView].centerView.indicatorStyle = AvalonsoftLoadingIndicatorStyle_Progress;
    [self reloadCenterView];
}

+ (void) showSuccessWithStatus:(NSString *) status{
    [self setupSubViews];
    [self sharedView].centerView.statusLabel.text = status;
    [self sharedView].centerView.indicatorStyle = AvalonsoftLoadingIndicatorStyle_Success;
    [self reloadCenterView];
    [self delayDismiss];
}

+ (void) showFailureWithStatus:(NSString *) status{
    [self setupSubViews];
    [self sharedView].centerView.statusLabel.text = status;
    [self sharedView].centerView.indicatorStyle = AvalonsoftLoadingIndicatorStyle_Failure;
    [self reloadCenterView];
    [self delayDismiss];
}

+ (void)showWarningWithStatus:(NSString *) status{
    [self setupSubViews];
    [self sharedView].centerView.statusLabel.text = status;
    [self sharedView].centerView.indicatorStyle = AvalonsoftLoadingIndicatorStyle_Warning;
    [self reloadCenterView];
    [self delayDismiss];
}

+ (void) reloadCenterView{
    NSString *value = [self sharedView].centerView.statusLabel.text;
    CGRect labelRect = [self sharedView].centerView.statusLabel.frame;
    
    //计算高度的
    CGFloat originalHeight = labelRect.size.height;
    CGSize textSize = [value boundingRectWithSize:CGSizeMake(labelRect.size.width, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:[self sharedView].centerView.statusLabel.font}
                                          context:nil].size;
    labelRect.size.height = textSize.height;
    [self sharedView].centerView.statusLabel.frame = labelRect;
    
    CGRect centerViewRect = [self sharedView].centerView.frame;
    centerViewRect.size.height = centerViewRect.size.height + (labelRect.size.height - originalHeight);
    [self sharedView].centerView.frame = centerViewRect;
}

+ (void) setupSubViews{
    [[self sharedView] removeFromSuperview];
    [[self sharedView].centerView removeFromSuperview];
    
    [[UIApplication sharedApplication].keyWindow addSubview:[self sharedView]];
    [[UIApplication sharedApplication].keyWindow addSubview:[self sharedView].centerView];
}

+ (void) dismiss{
    if ([self sharedView].centerView.superview) {
        [[self sharedView].centerView reductCircleView];
    }
    [[self sharedView] removeFromSuperview];
    [[self sharedView].centerView removeFromSuperview];
}

+ (void) delayDismiss{
    if ([self sharedView].centerView.superview) {
        [[self sharedView].centerView reductCircleView];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[self sharedView] removeFromSuperview];
        [[self sharedView].centerView removeFromSuperview];
    });
}

#pragma mark - 懒加载
- (AvalonsoftProgressView *)centerView{
    if (!_centerView) {
        _centerView = [[AvalonsoftProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 45 / 100, 80) indicatorStyle:AvalonsoftLoadingIndicatorStyle_Default]; //0.4
        _centerView.center = self.center;
    }
    return _centerView;
}

@end
