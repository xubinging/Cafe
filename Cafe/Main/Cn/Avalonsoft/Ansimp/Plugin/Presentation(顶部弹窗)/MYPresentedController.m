//
//  MYPresentedController.m
//  Cafe
//
//  Created by leo on 2019/12/22.
//  Copyright © 2019 leo. All rights reserved.
//

#import "MYPresentedController.h"

@interface MYPresentedController ()

//动画管理
@property (nonatomic, strong) MYPresentAnimationManager *animationManager;

@end

@implementation MYPresentedController

//管理
- (MYPresentAnimationManager *)animationManager
{
    if (!_animationManager) {
        _animationManager = [[MYPresentAnimationManager alloc]init];
    }
    return _animationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)initWithShowFrame:(CGRect)showFrame ShowStyle:(MYPresentedViewShowStyle)showStyle callback:(handleBack)callback
{
    //断言
//    NSParameterAssert(![@(showStyle)isKindOfClass:[NSNumber class]]||![@(isBottomMenu)isKindOfClass:[NSNumber class]]);
    
    if (self = [super init]) {
        //设置管理
        self.transitioningDelegate          = self.animationManager;
        self.modalPresentationStyle         = UIModalPresentationCustom;
        self.callback                       = callback;
        self.animationManager.showStyle     = showStyle;
        self.animationManager.showViewFrame = showFrame;
    }
    
    return self;
}

- (void)setClearBack:(BOOL)clearBack
{
    _clearBack = clearBack;
    
    self.animationManager.clearBack = clearBack;
}

@end
