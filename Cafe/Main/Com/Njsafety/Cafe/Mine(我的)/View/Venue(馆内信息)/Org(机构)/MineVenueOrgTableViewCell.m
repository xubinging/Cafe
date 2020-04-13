//
//  MineVenueOrgTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineVenueOrgTableViewCell.h"

@implementation MineVenueOrgTableViewCell

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
        _companyIconImageView = [UIImageView new];
        [_backView addSubview:_companyIconImageView];
        [_companyIconImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset((64 - 34)/2);
            make.left.equalTo(_backView).offset(10);
            make.size.mas_equalTo(CGSizeMake(34, 34));
        }];
        _companyIconImageView.layer.masksToBounds = YES;
        _companyIconImageView.layer.cornerRadius = 8;
        
        //名称
        _companyNameLabel = [UILabel new];
        [_backView addSubview:_companyNameLabel];
        [_companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset((64 - 42)/2);
            make.left.equalTo(_companyIconImageView.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-10-65-10);
            make.height.mas_equalTo(@42);
        }];
        _companyNameLabel.numberOfLines = 0;
        _companyNameLabel.textAlignment = NSTextAlignmentLeft;
        _companyNameLabel.alpha = 1.0;

        //已关注按钮
        _likeButton = [UIButton new];
        [_backView addSubview:_likeButton];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset((64 - 26)/2);
            make.right.equalTo(_backView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(65, 26));
        }];
        _likeButton.layer.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0].CGColor;
        _likeButton.layer.cornerRadius = 13;
        NSMutableAttributedString *likeButtonString = [[NSMutableAttributedString alloc] initWithString:@"已关注"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]}];
        [_likeButton setAttributedTitle:likeButtonString forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
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

- (void)updateCellWithModel:(MineVenueOrgModel *)model
{

    UIImage *companyIcon = model.companyIcon;
    NSString *companyName = model.companyName;
    
    [_companyIconImageView setImage:companyIcon];
    
    //标题
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:companyName attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    _companyNameLabel.attributedText = nameString;
    
}

//按钮点击事件
- (void)buttonClick:(UIButton *)button{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(button);
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
