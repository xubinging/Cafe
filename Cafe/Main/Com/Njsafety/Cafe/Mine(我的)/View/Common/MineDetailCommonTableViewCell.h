//
//  MineDetailCommonTableViewCell.h
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

/**
 *  <我的>模块 -- 详情页面公用TableViewCell
 *
 *  教育背景详情
 *  学术经历详情
 *  Offer详情
 *  工作经历详情
 *  课外活动详情
 *  奖项与技能详情
 *
 */

#import <UIKit/UIKit.h>

#import "MineDetailCommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineDetailCommonTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

//根据类去填充cell
-(void)updateCellWithModel:(MineDetailCommonModel *)model;

@end

NS_ASSUME_NONNULL_END
