//
//  MineDetailCommonTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineDetailCommonTableViewCell.h"

@implementation MineDetailCommonTableViewCell

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
        [_backView setBackgroundColor:[UIColor clearColor]];
        
        //标题
        _titleLabel = [UILabel new];
        [_backView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(100, 22));
        }];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.alpha = 1.0;
        [_titleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        //内容
        _contentLabel = [UILabel new];
        [_backView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(4);
            make.left.equalTo(_titleLabel.mas_right).offset(15);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@40);
        }];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.alpha = 1.0;
        [_contentLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_contentLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
        //分割线
        UIView *splitView = [UIView new];
        [_backView addSubview:splitView];
        [splitView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(_titleLabel.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@1);
        }];
        [splitView setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
        
    }
    
    return self;
}

- (void)updateCellWithModel:(MineDetailCommonModel *)model
{
    NSString *title = model.title;
    NSString *content = model.content;
    
    //更新尺寸
    CGFloat titleWidth = [UILabel getWidthWithText:title font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(titleWidth, 22));
    }];
    
    //赋值
    if ([title isKindOfClass:[NSString class]]) {
        _titleLabel.text = title;
    } else {
        _titleLabel.text = [NSString stringWithFormat:@"%@",title];;
    }
    
    if ([content isKindOfClass:[NSString class]]) {
        _contentLabel.text = content;
    } else {
        _contentLabel.text = [NSString stringWithFormat:@"%@",content];;
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
