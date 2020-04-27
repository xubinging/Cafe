//
//  MineOfferTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineOfferTableViewCell.h"

@implementation MineOfferTableViewCell

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
        
        
        //国家
        _countryTitleLabel = [UILabel new];
        [_backView addSubview:_countryTitleLabel];
        [_countryTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 22));
        }];
        _countryTitleLabel.numberOfLines = 0;
        _countryTitleLabel.textAlignment = NSTextAlignmentLeft;
        _countryTitleLabel.alpha = 1.0;
        [_countryTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_countryTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        _countryLabel = [UILabel new];
        [_backView addSubview:_countryLabel];
        [_countryLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(4);
            make.left.equalTo(_countryTitleLabel.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@40);
        }];
        _countryLabel.numberOfLines = 0;
        _countryLabel.textAlignment = NSTextAlignmentRight;
        _countryLabel.alpha = 1.0;
        [_countryLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_countryLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
        UIView *splitView1 = [UIView new];
        [_backView addSubview:splitView1];
        [splitView1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(_countryTitleLabel.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@1);
        }];
        [splitView1 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
        
        
        //学校名称(英文)
        _schoolTitleLabel = [UILabel new];
        [_backView addSubview:_schoolTitleLabel];
        [_schoolTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView1.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 22));
        }];
        _schoolTitleLabel.numberOfLines = 0;
        _schoolTitleLabel.textAlignment = NSTextAlignmentLeft;
        _schoolTitleLabel.alpha = 1.0;
        [_schoolTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_schoolTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        _schoolLabel = [UILabel new];
        [_backView addSubview:_schoolLabel];
        [_schoolLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView1.mas_bottom).offset(4);
            make.left.equalTo(_schoolTitleLabel.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@40);
        }];
        _schoolLabel.numberOfLines = 0;
        _schoolLabel.textAlignment = NSTextAlignmentRight;
        _schoolLabel.alpha = 1.0;
        [_schoolLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_schoolLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
        UIView *splitView2 = [UIView new];
        [_backView addSubview:splitView2];
        [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(splitView1.mas_bottom).offset(48);
            make.left.equalTo(_backView).offset(15);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@1);
        }];
        [splitView2 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
        
    
        //就读阶段
        _stageTitleLabel = [UILabel new];
        [_backView addSubview:_stageTitleLabel];
        [_stageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView2.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 22));
        }];
        _stageTitleLabel.numberOfLines = 0;
        _stageTitleLabel.textAlignment = NSTextAlignmentLeft;
        _stageTitleLabel.alpha = 1.0;
        [_stageTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_stageTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        _stageLabel = [UILabel new];
        [_backView addSubview:_stageLabel];
        [_stageLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView2.mas_bottom).offset(4);
            make.left.equalTo(_stageTitleLabel.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@40);
        }];
        _stageLabel.numberOfLines = 0;
        _stageLabel.textAlignment = NSTextAlignmentRight;
        _stageLabel.alpha = 1.0;
        [_stageLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_stageLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
        UIView *splitView3 = [UIView new];
        [_backView addSubview:splitView3];
        [splitView3 mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(splitView2.mas_bottom).offset(48);
            make.left.equalTo(_backView).offset(15);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@1);
        }];
        [splitView3 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
        
        
        //专业
        _majorTitleLabel = [UILabel new];
        [_backView addSubview:_majorTitleLabel];
        [_majorTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView3.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 22));
        }];
        _majorTitleLabel.numberOfLines = 0;
        _majorTitleLabel.textAlignment = NSTextAlignmentLeft;
        _majorTitleLabel.alpha = 1.0;
        [_majorTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_majorTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        _majorLabel = [UILabel new];
        [_backView addSubview:_majorLabel];
        [_majorLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView3.mas_bottom).offset(4);
            make.left.equalTo(_majorTitleLabel.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@40);
        }];
        _majorLabel.numberOfLines = 0;
        _majorLabel.textAlignment = NSTextAlignmentRight;
        _majorLabel.alpha = 1.0;
        [_majorLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_majorLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
    }
    
    return self;
}

- (void)updateCellWithModel:(MineOfferModel *)model
{
    NSString *country = model.country;
    NSString *school = model.schoolNameEn;
    NSString *stage = model.level;
    NSString *major = model.majorName;
    NSString *showLanguage = model.showLanguage;
    
    [_countryLabel setText:country];
    [_schoolLabel setText:school];
    [_stageLabel setText:stage];
    [_majorLabel setText:major];
    
    if([showLanguage isEqualToString:@"ZH"] || showLanguage == nil || [showLanguage isEqualToString:@""]){
        [_countryTitleLabel setText:@"国家:"];
        [_schoolTitleLabel setText:@"学校名称(英文):"];
        [_stageTitleLabel setText:@"就读阶段:"];
        [_majorTitleLabel setText:@"专业:"];
        
    }else{
        [_countryTitleLabel setText:@"Country:"];
        [_schoolTitleLabel setText:@"School Name(EN):"];
        [_stageTitleLabel setText:@"Study Stage:"];
        [_majorTitleLabel setText:@"Major:"];
    }
    
    //更新尺寸
    CGFloat countryTitleWidth = [UILabel getWidthWithText:_countryTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    CGFloat schoolTitleWidth = [UILabel getWidthWithText:_schoolTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    CGFloat stageTitleWidth = [UILabel getWidthWithText:_stageTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    CGFloat majorTitleWidth = [UILabel getWidthWithText:_majorTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    [_countryTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(countryTitleWidth, 22));
    }];
    
    [_schoolTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
           make.size.mas_equalTo(CGSizeMake(schoolTitleWidth, 22));
       }];
    
    [_stageTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
           make.size.mas_equalTo(CGSizeMake(stageTitleWidth, 22));
       }];
    
    [_majorTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(majorTitleWidth, 22));
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
