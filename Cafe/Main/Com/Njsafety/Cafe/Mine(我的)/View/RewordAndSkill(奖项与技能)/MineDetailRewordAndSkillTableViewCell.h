//
//  MineDetailRewordAndSkillTableViewCell.h
//  Cafe
//
//  Created by migu on 2020/5/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineDetailRewordAndSkillTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *nameLabel;             //名称
@property (nonatomic, strong) UILabel *nameTitleLabel;           

@property (nonatomic, strong) UILabel *dateLabel;             //日期
@property (nonatomic, strong) UILabel *dateTitleLabel;

@property (nonatomic, strong) UILabel *levelLabel;            //等级
@property (nonatomic, strong) UILabel *levelTitleLabel;

//根据类去填充cell
-(void)updateCellWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
