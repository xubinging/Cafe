//
//  PrepareCourseHomeTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrepareCourseHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrepareCourseHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

//根据类去填充cell
-(void)updateCellWithModel:(PrepareCourseHomeModel *)model;

@end

NS_ASSUME_NONNULL_END
