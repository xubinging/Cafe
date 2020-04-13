//
//  AvalonsoftMsgAlertView.h
//  SmartLock
//
//  Created by leo on 2019/9/7.
//  Copyright © 2019 leo. All rights reserved.
//
// 消息提示框

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftMsgAlertView : UIView

/**
 信息弹窗调用方法
 
 @param title 标题
 @param content 内容
 @param buttonTitles 按钮title数组
 @param buttonClickedBlock 按钮点击回调
 @return 自定义弹窗实例
 */
+ (instancetype)showWithTitle:(nullable NSString *)title content:(NSString *)content buttonTitles:(NSArray <NSString *> *)buttonTitles buttonClickedBlock:(nullable void (^)(NSInteger index))buttonClickedBlock;

/** 设置第几个按钮是主按钮（主按钮为主题色粗体），默认最右边那个是主按钮 */
- (void)setMainButtonIndex:(NSInteger)mainButtonIndex;

@end

NS_ASSUME_NONNULL_END
