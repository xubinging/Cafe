//
//  MineLearningDetailViewController.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineLearningModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineLearningDetailViewController : UIViewController

//Block传值step 1：定义block为传值block的属性
@property (nonatomic,copy)void(^sendValueBlock)(MineLearningModel *model);

@property (nonatomic, strong) MineLearningModel *model;

@end

NS_ASSUME_NONNULL_END
