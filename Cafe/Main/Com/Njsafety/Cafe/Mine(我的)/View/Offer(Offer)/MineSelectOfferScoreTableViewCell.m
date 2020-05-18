//
//  MineSelectOfferScoreTableViewCell.m
//  Cafe
//
//  Created by migu on 2020/5/18.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineSelectOfferScoreTableViewCell.h"

@implementation MineSelectOfferScoreTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        
        //*** 1.添加一个背景视图 ***
        _backView = [UIView new];
        [self.contentView addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        _backView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _backView.layer.cornerRadius = 8;
        _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0,5);
        _backView.layer.shadowOpacity = 1;
        _backView.layer.shadowRadius = 15;
        
        
        _totalScoreLabel = [UILabel new];
        [_backView addSubview:_totalScoreLabel];
        [_totalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView);
            make.left.equalTo(_backView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
        }];
        _totalScoreLabel.numberOfLines = 0;
        _totalScoreLabel.textAlignment = NSTextAlignmentCenter;
        _totalScoreLabel.alpha = 1.0;
        [_totalScoreLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];

        
        _scoreOneLabel = [UILabel new];
        [_backView addSubview:_scoreOneLabel];
        [_scoreOneLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView);
            make.left.equalTo(_totalScoreLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
        }];
        _scoreOneLabel.numberOfLines = 0;
        _scoreOneLabel.textAlignment = NSTextAlignmentCenter;
        _scoreOneLabel.alpha = 1.0;
        [_scoreOneLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        
                
        _scoreTwoLabel = [UILabel new];
        [_backView addSubview:_scoreTwoLabel];
        [_scoreTwoLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView);
            make.left.equalTo(_scoreOneLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
        }];
        _scoreTwoLabel.numberOfLines = 0;
        _scoreTwoLabel.textAlignment = NSTextAlignmentCenter;
        _scoreTwoLabel.alpha = 1.0;
        [_scoreTwoLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        
        
        
        _scoreThreeLabel = [UILabel new];
        [_backView addSubview:_scoreThreeLabel];
        [_scoreThreeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView);
            make.left.equalTo(_scoreTwoLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
        }];
        _scoreThreeLabel.numberOfLines = 0;
        _scoreThreeLabel.textAlignment = NSTextAlignmentCenter;
        _scoreThreeLabel.alpha = 1.0;
        [_scoreThreeLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        
    
        _scoreFourLabel = [UILabel new];
        [_backView addSubview:_scoreFourLabel];
        [_scoreFourLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView);
            make.left.equalTo(_scoreThreeLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
        }];
        _scoreFourLabel.numberOfLines = 0;
        _scoreFourLabel.textAlignment = NSTextAlignmentCenter;
        _scoreFourLabel.alpha = 1.0;
        [_scoreFourLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        
        
        _scoreFiveLabel = [UILabel new];
        [_backView addSubview:_scoreFiveLabel];
        [_scoreFiveLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView);
            make.left.equalTo(_scoreFourLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 44));
        }];
        _scoreFiveLabel.numberOfLines = 0;
        _scoreFiveLabel.textAlignment = NSTextAlignmentCenter;
        _scoreFiveLabel.alpha = 1.0;
        [_scoreFiveLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        
        
        _sureImage = [UIImageView new];
        [_backView addSubview:_sureImage];
        [_sureImage mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self);
            make.left.equalTo(_scoreFiveLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(23, 20));
        }];
        _sureImage.image = [UIImage imageNamed:@"mine_mecard_complete"];
        _sureImage.hidden = YES;
    }
    
    return self;
}

- (void)updateCellWithModel:(MineResultModel *)model
{
    [_totalScoreLabel setText:model.examScore];
    [_scoreOneLabel setText:model.scoreA];
    [_scoreTwoLabel setText:model.scoreB];
    [_scoreThreeLabel setText:model.scoreC];
    [_scoreFourLabel setText:model.scoreD];
    [_scoreFiveLabel setText:model.scoreE];

    if (model.isSelected == YES) {
        [_totalScoreLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        [_scoreOneLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        [_scoreTwoLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        [_scoreThreeLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        [_scoreFourLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        [_scoreFiveLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        _sureImage.hidden = NO;
    } else {
        [_totalScoreLabel setTextColor:[UIColor blackColor]];
        [_scoreOneLabel setTextColor:[UIColor blackColor]];
        [_scoreTwoLabel setTextColor:[UIColor blackColor]];
        [_scoreThreeLabel setTextColor:[UIColor blackColor]];
        [_scoreFourLabel setTextColor:[UIColor blackColor]];
        [_scoreFiveLabel setTextColor:[UIColor blackColor]];
        _sureImage.hidden = YES;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
