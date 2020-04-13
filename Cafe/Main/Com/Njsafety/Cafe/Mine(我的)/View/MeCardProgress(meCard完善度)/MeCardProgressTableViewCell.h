//
//  MeCardProgressTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MeCardProgressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeCardProgressTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *isCompleteImageView;

//根据类去填充cell
-(void)updateCellWithModel:(MeCardProgressModel *)model;

@end

NS_ASSUME_NONNULL_END
