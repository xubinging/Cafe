//
//  MineOfferDetailViewController.h
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineOfferModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineOfferDetailViewController : UIViewController

//Block传值step 1：定义block为传值block的属性
@property (nonatomic,copy)void(^sendValueBlock)(MineOfferModel *model);

@property (nonatomic, strong) MineOfferModel *model;

@end

NS_ASSUME_NONNULL_END
