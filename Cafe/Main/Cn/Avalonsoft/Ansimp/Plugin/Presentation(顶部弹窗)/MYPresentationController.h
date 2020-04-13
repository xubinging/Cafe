//
//  MYPresentationController.h
//  Cafe
//
//  Created by leo on 2019/12/22.
//  Copyright © 2019 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYPresentedController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYPresentationController : UIPresentationController

@property (nonatomic, assign) MYPresentedViewShowStyle style;

@property (nonatomic, assign,getter=isNeedClearBack) BOOL clearBack;

//frame
@property (assign, nonatomic) CGRect showFrame;

@end

NS_ASSUME_NONNULL_END
