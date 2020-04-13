//
//  PrepareCourseTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import "PrepareCourseAbroadTableViewCell.h"

@implementation PrepareCourseAbroadTableViewCell

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
        _backView.layer.cornerRadius = 10;
        _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0,0);
        _backView.layer.shadowOpacity = 1;
        _backView.layer.shadowRadius = 10;
        
        //头像
        _iconImageView = [UIImageView new];
        [_backView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(10);
            make.left.equalTo(_backView).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        //标题
        _titleLabel = [UILabel new];
        [_backView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_iconImageView).offset(4);
            make.left.equalTo(_iconImageView.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-10-50-10);
            make.height.mas_equalTo(@22);
        }];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.alpha = 1.0;

        _timeLabel = [UILabel new];
        [_backView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_titleLabel).offset(2);
            make.right.equalTo(_backView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(50, 18));
        }];
        _timeLabel.numberOfLines = 0;
        _timeLabel.textAlignment =NSTextAlignmentRight;
        _timeLabel.alpha = 1.0;
        
        //学校
        _contentLabel = [UILabel new];
        [_backView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_iconImageView.mas_bottom).offset(5);
            make.left.equalTo(_backView).offset(10);
            make.right.equalTo(_backView).offset(-10);
            make.bottom.equalTo(_backView).offset(-5);
        }];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.alpha = 1.0;

    }
    
    return self;
}

- (void)updateCellWithModel:(PrepareCourseAbroadModel *)model
{

    NSString *icon = model.icon;
    NSString *title = model.title;
    NSString *time = model.time;
    NSString *content = model.content;
    
    [_iconImageView setImage:[UIImage imageNamed:icon]];
    
    //标题
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:title attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    _titleLabel.attributedText = titleString;
    
    //时间
    NSMutableAttributedString *timeString = [[NSMutableAttributedString alloc] initWithString:time attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    _timeLabel.attributedText = timeString;

    //内容
    NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:content attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    _contentLabel.attributedText = contentString;
    
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
