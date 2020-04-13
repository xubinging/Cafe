//
//  MyLikeStudyAbroadCompanyTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyLikeStudyAbroadCompanyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyLikeStudyAbroadCompanyTableViewCell : UITableViewCell

// 用typef宏定义来减少冗余代码
typedef void(^ButtonClick)(UIButton *sender);

// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数
// 下一步就是声明属性了，注意block的声明属性修饰要用copy
@property (nonatomic,copy) ButtonClick buttonAction;

@property (nonatomic, strong) UIView *backView;                 //背景视图

@property (nonatomic, strong) UIImageView *companyIconImageView;

@property (nonatomic, strong) UILabel *companyNameLabel;

@property (nonatomic, strong) UIButton *likeButton;             //已关注按钮

//根据类去填充cell
-(void)updateCellWithModel:(MyLikeStudyAbroadCompanyModel *)model;

@end

NS_ASSUME_NONNULL_END
