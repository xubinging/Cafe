//
//  MeCardProgressTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MeCardProgressTableViewCell.h"

@implementation MeCardProgressTableViewCell

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
        
        //cell标题
        _titleLabel = [UILabel new];
        [_backView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(13);
            make.left.equalTo(_backView).offset(10);
            make.right.equalTo(_backView).offset(-15-23-10);
            make.height.mas_equalTo(@22);
        }];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.alpha = 1.0;
        
        //显示图片
        _isCompleteImageView = [UIImageView new];
        [_backView addSubview:_isCompleteImageView];
        [_isCompleteImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(_backView).offset(-15);
            make.top.equalTo(_backView).offset(14);
            make.size.mas_equalTo(CGSizeMake(23, 20));
        }];
        
        //下分割线
        UIView *splitView = [UIView new];
        [_backView addSubview:splitView];
        [splitView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_backView).offset(10);
            make.right.equalTo(_backView).offset(-10);
            make.bottom.equalTo(_backView.mas_bottom).offset(-1);
            make.height.mas_equalTo(@1);
        }];
        [splitView setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];

    }
    
    return self;
}

- (void)updateCellWithModel:(MeCardProgressModel *)model
{

    NSString *title = model.title;
    NSString *isCompleteFlg = model.isCompleteFlg;
    
    //标题
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:title attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]}];
    _titleLabel.attributedText = titleString;
    
    if([isCompleteFlg isEqualToString:@"1"]){
        [self.isCompleteImageView setImage:[UIImage imageNamed:@"mine_mecard_complete"]];
        
    }else{
        //填充白色
        [self.isCompleteImageView setImage:[_F imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(23, 20)]];
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
