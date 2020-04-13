//
//  MineVenuePostTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineVenuePostModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineVenuePostTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likeNumLabel;

@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UILabel *commentNumLabel;

@property (nonatomic, strong) UIButton *seeButton;
@property (nonatomic, strong) UILabel *seeNumLabel;

@property (nonatomic, strong) UILabel *timeLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineVenuePostModel *)model;

@end

NS_ASSUME_NONNULL_END
