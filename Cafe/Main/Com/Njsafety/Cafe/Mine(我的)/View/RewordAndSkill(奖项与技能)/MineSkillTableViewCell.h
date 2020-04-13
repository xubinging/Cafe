//
//  MineSkillTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineSkillModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineSkillTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *nameTitleLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateTitleLabel;
@property (nonatomic, strong) UILabel *dateLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineSkillModel *)model;

@end

NS_ASSUME_NONNULL_END
