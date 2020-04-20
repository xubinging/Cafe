//
//  MineDetailRewordAndSkillTableViewCell.m
//  Cafe
//
//  Created by migu on 2020/4/20.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineDetailRewordAndSkillTableViewCell.h"
#import "MineSkillModel.h"
#import "MineRewordModel.h"

@implementation MineDetailRewordAndSkillTableViewCell

//纯代码创建 tableviewcell，重写该方法
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
           make.left.equalTo(self.contentView).offset(10);
           make.right.equalTo(self.contentView).offset(-10);
           make.bottom.equalTo(self.contentView);
       }];
       _backView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
       _backView.layer.cornerRadius = 8;
       _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
       _backView.layer.shadowOffset = CGSizeMake(0,5);
       _backView.layer.shadowOpacity = 1;
       _backView.layer.shadowRadius = 15;
       
       //名称
       _nameTitleLabel = [UILabel new];
       [_backView addSubview:_nameTitleLabel];
       [_nameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
           make.top.equalTo(_backView).offset(13);
           make.left.equalTo(_backView).offset(15);
           make.size.mas_equalTo(CGSizeMake(36, 22));
       }];
       _nameTitleLabel.numberOfLines = 0;
       _nameTitleLabel.textAlignment = NSTextAlignmentLeft;
       _nameTitleLabel.alpha = 1.0;
       [_nameTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
       [_nameTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
       
       _nameLabel = [UILabel new];
       [_backView addSubview:_nameLabel];
       [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
           make.top.equalTo(_backView).offset(4);
           make.left.equalTo(_nameTitleLabel.mas_right).offset(10);
           make.right.equalTo(_backView).offset(-15);
           make.height.mas_equalTo(@40);
       }];
       _nameLabel.numberOfLines = 0;
       _nameLabel.textAlignment = NSTextAlignmentRight;
       _nameLabel.alpha = 1.0;
       [_nameLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
       [_nameLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
       
       UIView *splitView = [UIView new];
       [_backView addSubview:splitView];
       [splitView mas_makeConstraints:^(MASConstraintMaker *make){
           make.bottom.equalTo(_nameTitleLabel.mas_bottom).offset(13);
           make.left.equalTo(_backView).offset(15);
           make.right.equalTo(_backView).offset(-15);
           make.height.mas_equalTo(@1);
       }];
       [splitView setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
       
       
       //日期
       _dateTitleLabel = [UILabel new];
       [_backView addSubview:_dateTitleLabel];
       [_dateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
           make.top.equalTo(splitView.mas_bottom).offset(13);
           make.left.equalTo(_backView).offset(15);
           make.size.mas_equalTo(CGSizeMake(110, 22));
       }];
       _dateTitleLabel.numberOfLines = 0;
       _dateTitleLabel.textAlignment = NSTextAlignmentLeft;
       _dateTitleLabel.alpha = 1.0;
       [_dateTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
       [_dateTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
       
       _dateLabel = [UILabel new];
       [_backView addSubview:_dateLabel];
       [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
           make.top.equalTo(splitView.mas_bottom).offset(4);
           make.left.equalTo(_dateTitleLabel.mas_right).offset(10);
           make.right.equalTo(_backView).offset(-15);
           make.height.mas_equalTo(@40);
       }];
       _dateLabel.numberOfLines = 0;
       _dateLabel.textAlignment = NSTextAlignmentRight;
       _dateLabel.alpha = 1.0;
       [_dateLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
       [_dateLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
       UIView *splitView2 = [UIView new];
       [_backView addSubview:splitView2];
       [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
           make.bottom.equalTo(_dateTitleLabel.mas_bottom).offset(13);
           make.left.equalTo(_backView).offset(15);
           make.right.equalTo(_backView).offset(-15);
           make.height.mas_equalTo(@1);
       }];
       [splitView2 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
       
       //等级
      _levelTitleLabel = [UILabel new];
      [_backView addSubview:_levelTitleLabel];
      [_levelTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
          make.top.equalTo(splitView2.mas_bottom).offset(13);
          make.left.equalTo(_backView).offset(15);
          make.size.mas_equalTo(CGSizeMake(110, 22));
      }];
      _levelTitleLabel.numberOfLines = 0;
      _levelTitleLabel.textAlignment = NSTextAlignmentLeft;
      _levelTitleLabel.alpha = 1.0;
      [_levelTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
      [_levelTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
      
      _levelLabel = [UILabel new];
      [_backView addSubview:_levelLabel];
      [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make){
          make.top.equalTo(splitView2.mas_bottom).offset(4);
          make.left.equalTo(_levelTitleLabel.mas_right).offset(10);
          make.right.equalTo(_backView).offset(-15);
          make.height.mas_equalTo(@40);
      }];
      _levelLabel.numberOfLines = 0;
      _levelLabel.textAlignment = NSTextAlignmentRight;
      _levelLabel.alpha = 1.0;
      [_levelLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
      [_levelLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    }
    
    return self;
}

- (void)updateCellWithModel:(id)model
{
    NSString *name = nil;
    NSString *date = nil;
    NSString *level = nil;
    NSString *showLanguage = nil;
    
    if ([model isKindOfClass:[MineSkillModel class]]) {
        MineSkillModel *curModel = (MineSkillModel *)model;
        name = curModel.skillDesc;
        date = curModel.skillDate;
        level = curModel.rankOrLevel;
        showLanguage = curModel.showLanguage;

    } else if ([model isKindOfClass:[MineRewordModel class]]) {
        MineRewordModel *curModel = (MineRewordModel *)model;
        name = curModel.awardName;
        date = curModel.awardDate;
        level = curModel.rankOrLevel;
        showLanguage = curModel.showLanguage;
    }
    
    _nameLabel.text = name;
    _levelLabel.text = level;
    
    if ([date isKindOfClass:[NSString class]]) {
        _dateLabel.text = date;
    } else { // 测试发现，date有时是long类型，待平台修正返回类型
        NSString *date2 = [ NSString stringWithFormat:@"%@",date];
        _dateLabel.text = date2;
    }
    
    if([showLanguage isEqualToString:@"ZH"] || showLanguage.length == 0){
        _nameTitleLabel.text = @"名称";
        _dateTitleLabel.text = @"日期";
        _levelTitleLabel.text = @"等级程度";
        
    }else{
        _nameTitleLabel.text = @"Name";
        _dateTitleLabel.text = @"Date";
        _levelTitleLabel.text = @"RankOrLevel";
    }
    
    //更新尺寸
    CGFloat nameTitleWidth = [UILabel getWidthWithText:_nameTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    CGFloat dateTitleWidth = [UILabel getWidthWithText:_dateTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    CGFloat levelTitleWidth = [UILabel getWidthWithText:_levelTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    [_nameTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(nameTitleWidth, 22));
    }];
    
    [_dateTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(dateTitleWidth, 22));
    }];
    
    [_levelTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(levelTitleWidth, 22));
    }];

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
