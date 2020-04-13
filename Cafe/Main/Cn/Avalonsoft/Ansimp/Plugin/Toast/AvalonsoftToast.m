//
//  AvalonsoftToast.m
//  SmartLock
//
//  Created by leo on 2019/9/7.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftToast.h"
#import "Masonry.h"

NSNotificationName const AvalonsoftToastWillShowNotification    = @"AvalonsoftToastWillShowNotification";
NSNotificationName const AvalonsoftToastDidShowNotification     = @"AvalonsoftToastDidShowNotification";
NSNotificationName const AvalonsoftToastWillDismissNotification = @"AvalonsoftToastWillDismissNotification";
NSNotificationName const AvalonsoftToastDidDismissNotification  = @"AvalonsoftToastDidDismissNotification";

/**
 toast的style
 
 - AvalonsoftToastStyleText: 纯文本toast
 - AvalonsoftToastStyleImageText: 图文toast
 */
typedef NS_ENUM(NSUInteger, AvalonsoftToastStyle) {
    AvalonsoftToastStyleText,
    AvalonsoftToastStyleImageText
};

// toast初始背景颜色
static UIColor *AvalonsoftToastInitialBackgroundColor;
// toast初始文本颜色
static UIColor *AvalonsoftToastInitialTextColor;
// toast初始展示时间
static NSTimeInterval AvalonsoftToastInitialDuration;
// toast初始消失时间
static NSTimeInterval AvalonsoftToastInitialFadeDuration;

@interface AvalonsoftToast()

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation AvalonsoftToast

#pragma mark - Initial
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //========== 设置初始值 ==========//
//        AvalonsoftToastInitialBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        AvalonsoftToastInitialBackgroundColor = RGBA_GGCOLOR(0, 0, 0, 0.7);
        AvalonsoftToastInitialTextColor = [UIColor whiteColor];
        AvalonsoftToastInitialDuration = 2;
        AvalonsoftToastInitialFadeDuration = 0.3;
    });
}

// 初始化方法里可以对各种toast的一致属性进行统一设置
- (instancetype)init {
    if (self = [super init]) {
        // 创建subView
        self.messageLabel = [[UILabel alloc] init];
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.messageLabel];
        [self addSubview:self.imageView];
        
        // toast的一致属性
        self.layer.cornerRadius = 8;
        self.backgroundColor = AvalonsoftToastInitialBackgroundColor;
        self.messageLabel.textColor = AvalonsoftToastInitialTextColor;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

#pragma mark - UI
/** 纯文本toast */
- (void)p_setupTextToastWithMessage:(NSString *)message {
    self.messageLabel.text = message;
    [self.messageLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    // 设置toast的约束
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.superview);
        make.bottom.mas_offset(-80);
        make.top.left.mas_equalTo(self.messageLabel).mas_offset(-10);
        make.bottom.right.mas_equalTo(self.messageLabel).mas_offset(10);
    }];
    
    // 设置label的约束
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(200);
        make.center.mas_equalTo(self.messageLabel.superview);
    }];
}

/** 图文toast */
- (void)p_setupImageTextToastWithMessage:(NSString *)message image:(NSString *)imageName {
    // label
    self.messageLabel.text = message;
    [self.messageLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    // imageView
    self.imageView.image = [UIImage imageNamed:imageName];
    
    // 设置toast的约束
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.superview);
        make.width.mas_equalTo(120);
    }];
    
    // 设置imageView的约束
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    // 设置label的约束
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(100);
        make.centerX.mas_equalTo(self.messageLabel.superview);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(15);
        make.bottom.mas_offset(-15);
    }];
}

/** 根据传入的style创建不同的toast */
- (void)p_setupWithMessage:(NSString *)message image:(NSString *)imageName style:(AvalonsoftToastStyle)style {
    switch (style) {
        case AvalonsoftToastStyleText:
        {
            // 纯文本toast
            [self p_setupTextToastWithMessage:message];
        }
            break;
            
        case AvalonsoftToastStyleImageText:
        {
            // 图文toast
            [self p_setupImageTextToastWithMessage:message image:imageName];
        }
            break;
    }
}

#pragma mark - show toast
/** 纯文本toast */
+ (void)showWithMessage:(NSString *)message {
    [AvalonsoftToast p_showWithMessage:message image:nil duration:AvalonsoftToastInitialDuration style:AvalonsoftToastStyleText];
}

+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration {
    [AvalonsoftToast p_showWithMessage:message image:nil duration:duration style:AvalonsoftToastStyleText];
}

/** 图文toast */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName {
    [AvalonsoftToast p_showWithMessage:message image:imageName duration:AvalonsoftToastInitialDuration style:AvalonsoftToastStyleImageText];
}

+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName duration:(NSTimeInterval)duration {
    [AvalonsoftToast p_showWithMessage:message image:imageName duration:duration style:AvalonsoftToastStyleImageText];
}

/** 全能show方法 */
+ (void)p_showWithMessage:(NSString *)message image:(NSString *)imageName duration:(NSTimeInterval)duration style:(AvalonsoftToastStyle)style {
    // 切换到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        // 将要展示
        [[NSNotificationCenter defaultCenter] postNotificationName:AvalonsoftToastWillShowNotification object:nil];
        AvalonsoftToast *toast = [[AvalonsoftToast alloc] init];
        [[UIApplication sharedApplication].windows.lastObject addSubview:toast];
        [toast p_setupWithMessage:message image:imageName style:style];
        // 已经展示
        [[NSNotificationCenter defaultCenter] postNotificationName:AvalonsoftToastDidShowNotification object:nil];
        // 指定时间移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 将要消失
            [[NSNotificationCenter defaultCenter] postNotificationName:AvalonsoftToastWillDismissNotification object:nil];
            [UIView animateWithDuration:AvalonsoftToastInitialFadeDuration animations:^{
                toast.alpha = 0;
            } completion:^(BOOL finished) {
                [toast removeFromSuperview];
                // 已经消失
                [[NSNotificationCenter defaultCenter] postNotificationName:AvalonsoftToastDidDismissNotification object:nil];
            }];
        });
    });
}

@end
