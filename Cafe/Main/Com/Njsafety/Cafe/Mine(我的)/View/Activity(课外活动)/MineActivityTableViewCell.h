//
//  MineActivityTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineActivityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineActivityTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *nameTitleLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *startTimeTitleLabel;
@property (nonatomic, strong) UILabel *startTimeLabel;

@property (nonatomic, strong) UILabel *endTimeTitleLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineActivityModel *)model;

@end

NS_ASSUME_NONNULL_END
