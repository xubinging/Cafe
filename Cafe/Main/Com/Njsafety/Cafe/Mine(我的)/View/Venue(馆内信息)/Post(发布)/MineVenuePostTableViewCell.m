//
//  MineVenuePostTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineVenuePostTableViewCell.h"

@implementation MineVenuePostTableViewCell

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

        //标题
        _titleLabel = [UILabel new];
        [_backView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(15);
            make.left.equalTo(_backView).offset(10);
            make.right.equalTo(_backView).offset(-10);
            make.height.mas_equalTo(@22);
        }];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.alpha = 1.0;
        [_titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        [_titleLabel setTextColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]];
       
        //内容
        _contentLabel = [UILabel new];
        [_backView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_titleLabel.mas_bottom).offset(7);
            make.left.equalTo(_backView).offset(10);
            make.right.equalTo(_backView).offset(-10);
            make.height.mas_equalTo(@45);
        }];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.alpha = 1.0;
        
        //点赞
        _likeButton = [UIButton new];
        [_backView addSubview:_likeButton];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_contentLabel.mas_bottom).offset(15);
            make.left.equalTo(_backView).offset(10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        [_likeButton setImage:[UIImage imageNamed:@"communit_pulse_good_unslct"] forState:UIControlStateNormal];
        
        //点赞数量标签
        _likeNumLabel = [UILabel new];
        [_backView addSubview:_likeNumLabel];
        [_likeNumLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_likeButton);
            make.left.equalTo(_likeButton.mas_right).offset(4);
            make.size.mas_equalTo(CGSizeMake(25, 20));
        }];
        _likeNumLabel.numberOfLines = 0;
        _likeNumLabel.textAlignment = NSTextAlignmentLeft;
        _likeNumLabel.alpha = 1.0;
        [_likeNumLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:13]];
        [_likeNumLabel setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
  
        //评论数量
        _commentButton = [UIButton new];
        [_backView addSubview:_commentButton];
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_likeButton);
            make.left.equalTo(_likeNumLabel.mas_right).offset(20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        [_commentButton setImage:[UIImage imageNamed:@"mine_venue_comment"] forState:UIControlStateNormal];
        
        //收藏数量标签
        _commentNumLabel = [UILabel new];
        [_backView addSubview:_commentNumLabel];
        [_commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_commentButton);
            make.left.equalTo(_commentButton.mas_right).offset(4);
            make.size.mas_equalTo(CGSizeMake(25, 20));
        }];
        _commentNumLabel.numberOfLines = 0;
        _commentNumLabel.textAlignment = NSTextAlignmentLeft;
        _commentNumLabel.alpha = 1.0;
        [_commentNumLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:13]];
        [_commentNumLabel setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
        
        //阅览量
        _seeButton = [UIButton new];
        [_backView addSubview:_seeButton];
        [_seeButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_commentButton);
            make.left.equalTo(_commentNumLabel.mas_right).offset(20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        [_seeButton setImage:[UIImage imageNamed:@"mine_venue_eye"] forState:UIControlStateNormal];
        
        //阅览量标签
        _seeNumLabel = [UILabel new];
        [_backView addSubview:_seeNumLabel];
        [_seeNumLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_seeButton);
            make.left.equalTo(_seeButton.mas_right).offset(4);
            make.size.mas_equalTo(CGSizeMake(25, 20));
        }];
        _seeNumLabel.numberOfLines = 0;
        _seeNumLabel.textAlignment = NSTextAlignmentLeft;
        _seeNumLabel.alpha = 1.0;
        [_seeNumLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:13]];
        [_seeNumLabel setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
        
        //时间
        _timeLabel = [UILabel new];
        [_backView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_seeButton);
            make.right.equalTo(_backView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(80, 17));
        }];
        _timeLabel.numberOfLines = 0;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.alpha = 1.0;
        [_timeLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
        [_timeLabel setTextColor:[UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]];
        
        //分割线
        UIView *splitView = [UIView new];
        [_backView addSubview:splitView];
        [splitView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(_backView);
            make.left.equalTo(_backView).offset(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
        }];
        [splitView setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
        
    }
    
    return self;
}

- (void)updateCellWithModel:(MineVenuePostModel *)model
{
    
    NSString *title = model.title;
    NSString *content = model.content;
    NSString *likeNum = model.likeNum;
    NSString *commentNum = model.commentNum;
    NSString *seeNum = model.seeNum;
    NSString *time = model.time;
    
    [_titleLabel setText:title];

    //内容
    NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@阅读全文",content] attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];

    [contentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]} range:NSMakeRange(0, [content length])];

    [contentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]} range:NSMakeRange([content length], 4)];

    _contentLabel.attributedText = contentString;
    
    //数量
    [_likeNumLabel setText:likeNum];
    [_commentNumLabel setText:commentNum];
    [_seeNumLabel setText:seeNum];
    
    [_timeLabel setText:time];
    
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
