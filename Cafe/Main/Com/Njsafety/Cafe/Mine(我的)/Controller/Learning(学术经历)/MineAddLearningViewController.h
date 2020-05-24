//
//  MineAddLearningViewController.h
//  Cafe
//
//  Created by migu on 2020/5/24.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineLearningModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineAddLearningViewController : UIViewController


//Block传值step 1：定义block为传值block的属性
@property (nonatomic,copy)void(^sendValueBlock)(MineLearningModel *model);

//接受父页面参数的字典
@property (nonatomic, strong) MineLearningModel *model;

@end

NS_ASSUME_NONNULL_END
