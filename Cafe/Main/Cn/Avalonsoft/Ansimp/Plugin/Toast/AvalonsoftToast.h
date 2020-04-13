//
//  AvalonsoftToast.h
//  SmartLock
//
//  Created by leo on 2019/9/7.
//  Copyright © 2019 leo. All rights reserved.
//
//  自定义Toast

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSNotificationName const AvalonsoftToastWillShowNotification;
UIKIT_EXTERN NSNotificationName const AvalonsoftToastDidShowNotification;
UIKIT_EXTERN NSNotificationName const AvalonsoftToastWillDismissNotification;
UIKIT_EXTERN NSNotificationName const AvalonsoftToastDidDismissNotification;

@interface AvalonsoftToast : UIView

#pragma mark - 纯文本toast
/** 纯文本toast */
+ (void)showWithMessage:(NSString *)message;

/**
 纯文本toast
 @param message 提示内容
 @param duration toast展示时间
 */
+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration;

#pragma mark - 图文toast
/** 图文toast */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName;

/**
 图文toast
 @param message 提示内容
 @param imageName 图片名
 @param duration toast展示时间
 */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
