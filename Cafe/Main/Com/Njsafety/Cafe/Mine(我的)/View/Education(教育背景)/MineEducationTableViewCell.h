//
//  MineEducationTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineEducationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineEducationTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *countryTitleLabel;
@property (nonatomic, strong) UILabel *countryLabel;

@property (nonatomic, strong) UILabel *schoolTitleLabel;
@property (nonatomic, strong) UILabel *schoolLabel;

@property (nonatomic, strong) UILabel *stageTitleLabel;
@property (nonatomic, strong) UILabel *stageLabel;

@property (nonatomic, strong) UILabel *stateTitleLabel;
@property (nonatomic, strong) UILabel *stateLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineEducationModel *)model;

@end

NS_ASSUME_NONNULL_END
