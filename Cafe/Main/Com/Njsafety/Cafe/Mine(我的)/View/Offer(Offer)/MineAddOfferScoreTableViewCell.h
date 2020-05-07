//
//  MineAddOfferScoreTableViewCell.h
//  Cafe
//
//  Created by migu on 2020/5/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineOfferScoreModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineAddOfferScoreTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *scoreTypeLabel;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIButton *showButton;

@property (nonatomic, strong) UILabel *totalScoreView;
@property (nonatomic, strong) UILabel *totalScoreTitleLabel;
@property (nonatomic, strong) UILabel *totalScoreLabel;

@property (nonatomic, strong) UILabel *scoreOneView;
@property (nonatomic, strong) UILabel *scoreOneTitleLabel;
@property (nonatomic, strong) UILabel *scoreOneLabel;

@property (nonatomic, strong) UILabel *scoreTwoView;
@property (nonatomic, strong) UILabel *scoreTwoTitleLabel;
@property (nonatomic, strong) UILabel *scoreTwoLabel;

@property (nonatomic, strong) UILabel *scoreThreeView;
@property (nonatomic, strong) UILabel *scoreThreeTitleLabel;
@property (nonatomic, strong) UILabel *scoreThreeLabel;

@property (nonatomic, strong) UILabel *scoreFourView;
@property (nonatomic, strong) UILabel *scoreFourTitleLabel;
@property (nonatomic, strong) UILabel *scoreFourLabel;

@property (nonatomic, strong) UILabel *scoreFiveView;
@property (nonatomic, strong) UILabel *scoreFiveTitleLabel;
@property (nonatomic, strong) UILabel *scoreFiveLabel;

@property (nonatomic, assign) NSInteger indexPathSection;

//根据类去填充cell
-(void)updateCellWithModel:(MineOfferScoreModel *)model;

@end

NS_ASSUME_NONNULL_END
