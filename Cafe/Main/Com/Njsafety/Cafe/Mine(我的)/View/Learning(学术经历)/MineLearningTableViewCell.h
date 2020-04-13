//
//  MineLearningTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineLearningModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineLearningTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *roleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineLearningModel *)model;

@end

NS_ASSUME_NONNULL_END
