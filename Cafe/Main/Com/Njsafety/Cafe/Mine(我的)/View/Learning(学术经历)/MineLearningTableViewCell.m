//
//  MineLearningTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineLearningTableViewCell.h"

@implementation MineLearningTableViewCell

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
        
        //左侧的背景
        UIView *leftBackView = [UIView new];
        [self.contentView addSubview:leftBackView];
        [leftBackView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView);
            make.left.equalTo(_backView);
            make.size.mas_equalTo(CGSizeMake(5, 32));
        }];

        [self layoutIfNeeded];
        
        // gradient
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = leftBackView.bounds;
        gl.startPoint = CGPointMake(-0.17, -0.17);
        gl.endPoint = CGPointMake(1.17, 0.83);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:154/255.0 blue:66/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        [leftBackView.layer addSublayer:gl];

        //设置右上角和右下角为圆角
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:leftBackView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(4.5, 4.5)];
        CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc] init];
        cornerRadiusLayer.frame = leftBackView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        leftBackView.layer.mask = cornerRadiusLayer;

        
        //项目名称
        _nameLabel = [UILabel new];
        [_backView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(15);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15 - 10 - 45 - 10, 22));
        }];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.alpha = 1.0;
        [_nameLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_nameLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        
        //项目角色
        _roleLabel = [UILabel new];
        [_backView addSubview:_roleLabel];
        [_roleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(10);
            make.right.equalTo(_backView.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(45, 15));
        }];
        _roleLabel.layer.backgroundColor = [UIColor colorWithRed:225/255.0 green:246/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _roleLabel.layer.cornerRadius = 3;
        _roleLabel.numberOfLines = 0;
        _roleLabel.textAlignment = NSTextAlignmentCenter;
        _roleLabel.alpha = 1.0;
        [_roleLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        [_roleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:10]];

        
        //内容标签
        _contentLabel = [UILabel new];
        [_backView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_nameLabel.mas_bottom).offset(6);
            make.left.equalTo(_backView).offset(15);
            make.right.equalTo(_backView).offset(-10);
            make.height.mas_equalTo(@44);
        }];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.alpha = 1.0;
        [_contentLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_contentLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
        
        //时间标签
        _timeLabel = [UILabel new];
        [_backView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_contentLabel.mas_bottom).offset(10);
            make.left.equalTo(_backView).offset(15);
            make.right.equalTo(_backView).offset(-10);
            make.height.mas_equalTo(@17);
        }];
        _timeLabel.numberOfLines = 0;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.alpha = 1.0;
        [_timeLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
        [_timeLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
        
    }
    
    return self;
}

- (void)updateCellWithModel:(MineLearningModel *)model
{
    
    NSString *name = model.programName;
    NSString *role = model.programRole;
    NSString *startTime = model.programStartDate;
    NSString *endTime = model.programEndDate;
    NSString *content = model.programDescription;
    NSString *showLanguage = model.showLanguage;

    [_nameLabel setText:name];
    [_roleLabel setText:role];
    [_contentLabel setText:content];
    
    if([showLanguage isEqualToString:@"ZH"] || showLanguage == nil || [showLanguage isEqualToString:@""]){
        [_timeLabel setText:[NSString stringWithFormat:@"活动时间: %@ 至 %@",startTime,endTime]];
        
    }else{
        [_timeLabel setText:[NSString stringWithFormat:@"Time: %@ To %@",startTime,endTime]];
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
