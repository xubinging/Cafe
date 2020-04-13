//
//  MineJobTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineJobTableViewCell.h"

@implementation MineJobTableViewCell

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
        
        
        //公司/机构名称
        _nameTitleLabel = [UILabel new];
        [_backView addSubview:_nameTitleLabel];
        [_nameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 22));
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
        
        UIView *splitView1 = [UIView new];
        [_backView addSubview:splitView1];
        [splitView1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(_nameTitleLabel.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@1);
        }];
        [splitView1 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
        
        
        //公司所在地
        _locationTitleLabel = [UILabel new];
        [_backView addSubview:_locationTitleLabel];
        [_locationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView1.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 22));
        }];
        _locationTitleLabel.numberOfLines = 0;
        _locationTitleLabel.textAlignment = NSTextAlignmentLeft;
        _locationTitleLabel.alpha = 1.0;
        [_locationTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_locationTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        _locationLabel = [UILabel new];
        [_backView addSubview:_locationLabel];
        [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView1.mas_bottom).offset(4);
            make.left.equalTo(_locationTitleLabel.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@40);
        }];
        _locationLabel.numberOfLines = 0;
        _locationLabel.textAlignment = NSTextAlignmentRight;
        _locationLabel.alpha = 1.0;
        [_locationLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_locationLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
        UIView *splitView2 = [UIView new];
        [_backView addSubview:splitView2];
        [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(splitView1.mas_bottom).offset(48);
            make.left.equalTo(_backView).offset(15);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@1);
        }];
        [splitView2 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];

        
        //职位
        _positionTitleLabel = [UILabel new];
        [_backView addSubview:_positionTitleLabel];
        [_positionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView2.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 22));
        }];
        _positionTitleLabel.numberOfLines = 0;
        _positionTitleLabel.textAlignment = NSTextAlignmentLeft;
        _positionTitleLabel.alpha = 1.0;
        [_positionTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_positionTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        _positionLabel = [UILabel new];
        [_backView addSubview:_positionLabel];
        [_positionLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView2.mas_bottom).offset(4);
            make.left.equalTo(_positionTitleLabel.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@40);
        }];
        _positionLabel.numberOfLines = 0;
        _positionLabel.textAlignment = NSTextAlignmentRight;
        _positionLabel.alpha = 1.0;
        [_positionLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_positionLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
    }
    
    return self;
}

- (void)updateCellWithModel:(MineJobModel *)model
{
    
    NSString *name = model.name;
    NSString *location = model.location;
    NSString *position = model.position;
    NSString *showLanguage = model.showLanguage;
    
    [_nameLabel setText:name];
    [_locationLabel setText:location];
    [_positionLabel setText:position];
    
    if([showLanguage isEqualToString:@"ZH"] || showLanguage == nil || [showLanguage isEqualToString:@""]){
        [_nameTitleLabel setText:@"公司/机构名称:"];
        [_locationTitleLabel setText:@"公司所在地:"];
        [_positionTitleLabel setText:@"职位:"];
        
    }else{
        [_nameTitleLabel setText:@"Company:"];
        [_locationTitleLabel setText:@"Location:"];
        [_positionTitleLabel setText:@"Position:"];
        
    }
    
    //更新尺寸
    CGFloat nameTitleWidth = [UILabel getWidthWithText:_nameTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    CGFloat locationTitleWidth = [UILabel getWidthWithText:_locationTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    CGFloat positionTitleWidth = [UILabel getWidthWithText:_positionTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    [_nameTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(nameTitleWidth, 22));
    }];
    
    [_locationTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
           make.size.mas_equalTo(CGSizeMake(locationTitleWidth, 22));
       }];
    
    [_positionTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
           make.size.mas_equalTo(CGSizeMake(positionTitleWidth, 22));
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
