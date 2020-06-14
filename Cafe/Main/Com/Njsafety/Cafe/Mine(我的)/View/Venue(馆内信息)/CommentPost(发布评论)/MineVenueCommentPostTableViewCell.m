//
//  MineVenueCommentPostTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineVenueCommentPostTableViewCell.h"

@implementation MineVenueCommentPostTableViewCell

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
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        _backView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _backView.layer.cornerRadius = 8;
        
        //头像
        _iconImageView = [UIImageView new];
        [_backView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(15);
            make.left.equalTo(_backView).offset(10);
            make.size.mas_equalTo(CGSizeMake(48, 48));
        }];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 24;
        
        //名称
        _titleLabel = [UILabel new];
        [_backView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(15);
            make.left.equalTo(_iconImageView.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-10-60-10);
            make.height.mas_equalTo(@22);
        }];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.alpha = 1.0;
        [_titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        [_titleLabel setTextColor:[UIColor colorWithRed:26/255.0 green:46/255.0 blue:80/255.0 alpha:1.0]];
       
        //时间
        _timeLabel = [UILabel new];
        [_backView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(19);
            make.right.equalTo(_backView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(60, 15));
        }];
        _timeLabel.numberOfLines = 0;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.alpha = 1.0;
        [_timeLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
        [_timeLabel setTextColor:[UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]];
        
        //副标题
        _subTitleLabel = [UILabel new];
        [_backView addSubview:_subTitleLabel];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_titleLabel.mas_bottom).offset(2);
            make.left.equalTo(_iconImageView.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@18);
        }];
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel.alpha = 1.0;
        [_subTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:13]];
        [_subTitleLabel setTextColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]];
        
        //内容
        _contentLabel = [UILabel new];
        [_backView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_subTitleLabel.mas_bottom).offset(4);
            make.left.equalTo(_iconImageView.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@45);
        }];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.alpha = 1.0;
        [_contentLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_contentLabel setTextColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]];
        
        //分割线
        UIView *splitView = [UIView new];
        [_backView addSubview:splitView];
        [splitView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(_backView);
            make.left.equalTo(_backView).offset(68);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 68, 1));
        }];
        [splitView setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
        
    }
    
    return self;
}

- (void)updateCellWithModel:(MineVenueCommentPostModel *)model
{
    NSString *iconImage = model.logo;
    NSString *time = model.createTime;
    NSString *title = model.title;
    NSString *subTitle = model.originTitle;
    NSString *content = model.content;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[_F createFileLoadUrl:iconImage]]];
    
    [_timeLabel setText:time];
    
    [_titleLabel setText:title];
    
    [_subTitleLabel setText:subTitle];
    
    [_contentLabel setText:content];
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
