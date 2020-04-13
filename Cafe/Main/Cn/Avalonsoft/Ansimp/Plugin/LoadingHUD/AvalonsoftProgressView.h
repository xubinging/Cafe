//
//  AvalonsoftProgressView.h
//  SmartLock
//
//  Created by leo on 2019/9/12.
//  Copyright © 2019 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kDefaultSuccessImgName = @"成功";
static NSString *kDefaultFailureImgName = @"失败";
static NSString *kDefaultWarningImgName = @"警告";

typedef NS_ENUM(NSUInteger, AvalonsoftLoadingIndicatorStyle) {
    AvalonsoftLoadingIndicatorStyle_Progress,    //菊花框
    AvalonsoftLoadingIndicatorStyle_Success,     //成功
    AvalonsoftLoadingIndicatorStyle_Failure,     //失败
    AvalonsoftLoadingIndicatorStyle_Warning,     //警告
    AvalonsoftLoadingIndicatorStyle_Default      //默认
};

@interface AvalonsoftProgressView : UIView

@property (nonatomic, strong) UIImageView *staticImgView;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;   //系统自带的小菊花

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, assign) AvalonsoftLoadingIndicatorStyle indicatorStyle;

- (instancetype) initWithFrame:(CGRect)frame indicatorStyle:(AvalonsoftLoadingIndicatorStyle) style;

/**
 还原菊花frame
 */
- (void) reductCircleView;

@end


