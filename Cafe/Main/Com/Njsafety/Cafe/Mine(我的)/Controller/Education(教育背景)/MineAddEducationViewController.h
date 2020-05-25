//
//  MineAddEducationViewController.h
//  Cafe
//
//  Created by migu on 2020/5/23.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineEducationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineAddEducationViewController : UIViewController

//Block传值step 1：定义block为传值block的属性
@property (nonatomic,copy)void(^sendValueBlock)(MineEducationModel *model);

@property (nonatomic, strong) MineEducationModel *model;

@end

NS_ASSUME_NONNULL_END
