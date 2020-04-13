//
//  MyLikeInternationalClassViewCell.m
//  Cafe
//
//  Created by gexy on 2020/3/22.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MyLikeInternationalClassViewCell.h"

@implementation MyLikeInternationalClassViewCell

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
        _classIconImageView = [UIImageView new];
        [_backView addSubview:_classIconImageView];
        [_classIconImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset((70 - 34)/2);
            make.left.equalTo(_backView).offset(10);
            make.size.mas_equalTo(CGSizeMake(34, 34));
        }];
        
        //名称
        _classNameLabel = [UILabel new];
        [_backView addSubview:_classNameLabel];
        [_classNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset((70 - 42)/2);
            make.left.equalTo(_classIconImageView.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-10-65-10);
            make.height.mas_equalTo(@42);
        }];
        _classNameLabel.numberOfLines = 0;
        _classNameLabel.textAlignment = NSTextAlignmentLeft;
        _classNameLabel.alpha = 1.0;

        //已关注按钮
        _likeButton = [UIButton new];
        [_backView addSubview:_likeButton];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset((70 - 26)/2);
            make.right.equalTo(_backView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(65, 26));
        }];
        _likeButton.layer.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0].CGColor;
        _likeButton.layer.cornerRadius = 13;
        NSMutableAttributedString *likeButtonString = [[NSMutableAttributedString alloc] initWithString:@"已关注"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]}];
        [_likeButton setAttributedTitle:likeButtonString forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)updateCellWithModel:(MyLikeInternationalClassModel *)model
{

    NSString *displayName = model.displayName;
    if ([@"" isEqualToString:displayName]) {
        displayName = model.instnameen;
    }
    
    if (model.logo == NULL || [model.logo isEqualToString:@""]) {
        UIImage *icon = [UIImage imageNamed:@"home_foreign_school_icon"];
        _classIconImageView.image = icon;
    } else {
        [_classIconImageView sd_setImageWithURL:[NSURL URLWithString:[_F createFileLoadUrl:model.logo]]];
    }

    
    //标题
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:displayName attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    _classNameLabel.attributedText = nameString;
    
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
