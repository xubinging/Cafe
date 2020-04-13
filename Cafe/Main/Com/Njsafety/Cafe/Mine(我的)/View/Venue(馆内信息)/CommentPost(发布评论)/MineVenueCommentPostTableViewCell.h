//
//  MineVenueCommentPostTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineVenueCommentPostModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineVenueCommentPostTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;                 //背景视图

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineVenueCommentPostModel *)model;

@end

NS_ASSUME_NONNULL_END
