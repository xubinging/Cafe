//
//  PersonalDataTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/3.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PersonalDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalDataTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *cellTitleLabel;

@property (nonatomic, strong) UIImageView *cellContentImageView;

@property (nonatomic, strong) UILabel *cellContentLabel;

//根据类去填充cell
-(void)updateCellWithModel:(PersonalDataModel *)model;

@end

NS_ASSUME_NONNULL_END
