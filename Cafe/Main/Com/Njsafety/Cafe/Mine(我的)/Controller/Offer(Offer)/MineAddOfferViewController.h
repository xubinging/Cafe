//
//  MineAddOfferViewController.h
//  Cafe
//
//  Created by migu on 2020/5/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineAddOfferViewController : UIViewController

//Block传值step 1：定义block为传值block的属性
@property (nonatomic,copy)void(^sendValueBlock)(MineResultModel *model);

@property (nonatomic, strong) MineResultModel *model;

@end

NS_ASSUME_NONNULL_END
