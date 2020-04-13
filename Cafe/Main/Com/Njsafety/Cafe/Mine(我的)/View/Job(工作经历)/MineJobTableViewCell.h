//
//  MineJobTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineJobModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineJobTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *nameTitleLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *locationTitleLabel;
@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UILabel *positionTitleLabel;
@property (nonatomic, strong) UILabel *positionLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineJobModel *)model;

@end

NS_ASSUME_NONNULL_END
