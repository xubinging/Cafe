//
//  MineSelectOfferScoreTableViewCell.h
//  Cafe
//
//  Created by migu on 2020/5/18.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineSelectOfferScoreTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *totalScoreLabel;
@property (nonatomic, strong) UILabel *scoreOneLabel;
@property (nonatomic, strong) UILabel *scoreTwoLabel;
@property (nonatomic, strong) UILabel *scoreThreeLabel;
@property (nonatomic, strong) UILabel *scoreFourLabel;
@property (nonatomic, strong) UILabel *scoreFiveLabel;
@property (nonatomic, strong) UIImageView *sureImage;

-(void)updateCellWithModel:(MineResultModel *)model;

@end

NS_ASSUME_NONNULL_END
