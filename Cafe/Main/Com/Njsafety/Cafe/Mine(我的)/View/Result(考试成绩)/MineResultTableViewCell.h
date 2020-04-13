//
//  MineResultTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineResultTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *resultTypeTitleLabel;
@property (nonatomic, strong) UILabel *resultTypeLabel;

@property (nonatomic, strong) UILabel *resultDateTitleLabel;
@property (nonatomic, strong) UILabel *resultDateLabel;

@property (nonatomic, strong) UILabel *resultScoreTitleLabel;
@property (nonatomic, strong) UILabel *resultScoreLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineResultModel *)model;

@end

NS_ASSUME_NONNULL_END
