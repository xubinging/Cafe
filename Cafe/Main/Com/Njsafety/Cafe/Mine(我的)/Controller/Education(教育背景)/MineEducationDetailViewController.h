//
//  MineEducationDetailViewController.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//
//  教育背景详情

#import <UIKit/UIKit.h>
#import "MineEducationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineEducationDetailViewController : UIViewController

//Block传值step 1：定义block为传值block的属性
@property (nonatomic,copy)void(^sendValueBlock)(MineEducationModel *model);

@property (nonatomic, strong) MineEducationModel *model;

@end

NS_ASSUME_NONNULL_END
