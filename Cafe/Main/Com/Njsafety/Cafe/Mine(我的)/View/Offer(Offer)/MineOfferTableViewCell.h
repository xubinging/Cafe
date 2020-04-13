//
//  MineOfferTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineOfferModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineOfferTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *countryTitleLabel;
@property (nonatomic, strong) UILabel *countryLabel;

@property (nonatomic, strong) UILabel *schoolTitleLabel;
@property (nonatomic, strong) UILabel *schoolLabel;

@property (nonatomic, strong) UILabel *stageTitleLabel;
@property (nonatomic, strong) UILabel *stageLabel;

@property (nonatomic, strong) UILabel *majorTitleLabel;
@property (nonatomic, strong) UILabel *majorLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineOfferModel *)model;

@end

NS_ASSUME_NONNULL_END
