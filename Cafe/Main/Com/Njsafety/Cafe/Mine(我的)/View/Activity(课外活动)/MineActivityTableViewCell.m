//
//  MineActivityTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineActivityTableViewCell.h"

@implementation MineActivityTableViewCell

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
        
        
        //开始时间
        _startTimeTitleLabel = [UILabel new];
        [_backView addSubview:_startTimeTitleLabel];
        [_startTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView1.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 22));
        }];
        _startTimeTitleLabel.numberOfLines = 0;
        _startTimeTitleLabel.textAlignment = NSTextAlignmentLeft;
        _startTimeTitleLabel.alpha = 1.0;
        [_startTimeTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_startTimeTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        _startTimeLabel = [UILabel new];
        [_backView addSubview:_startTimeLabel];
        [_startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView1.mas_bottom).offset(4);
            make.left.equalTo(_startTimeTitleLabel.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@40);
        }];
        _startTimeLabel.numberOfLines = 0;
        _startTimeLabel.textAlignment = NSTextAlignmentRight;
        _startTimeLabel.alpha = 1.0;
        [_startTimeLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_startTimeLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
        UIView *splitView2 = [UIView new];
        [_backView addSubview:splitView2];
        [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(splitView1.mas_bottom).offset(48);
            make.left.equalTo(_backView).offset(15);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@1);
        }];
        [splitView2 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];

        
        //结束时间
        _endTimeTitleLabel = [UILabel new];
        [_backView addSubview:_endTimeTitleLabel];
        [_endTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView2.mas_bottom).offset(13);
            make.left.equalTo(_backView).offset(15);
            make.size.mas_equalTo(CGSizeMake(110, 22));
        }];
        _endTimeTitleLabel.numberOfLines = 0;
        _endTimeTitleLabel.textAlignment = NSTextAlignmentLeft;
        _endTimeTitleLabel.alpha = 1.0;
        [_endTimeTitleLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_endTimeTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        _endTimeLabel = [UILabel new];
        [_backView addSubview:_endTimeLabel];
        [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(splitView2.mas_bottom).offset(4);
            make.left.equalTo(_endTimeTitleLabel.mas_right).offset(10);
            make.right.equalTo(_backView).offset(-15);
            make.height.mas_equalTo(@40);
        }];
        _endTimeLabel.numberOfLines = 0;
        _endTimeLabel.textAlignment = NSTextAlignmentRight;
        _endTimeLabel.alpha = 1.0;
        [_endTimeLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        [_endTimeLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        
    }
    
    return self;
}

- (void)updateCellWithModel:(MineActivityModel *)model
{

    NSString *name = model.name;
    NSString *startTime = model.startTime;
    NSString *endTime = model.endTime;
    NSString *showLanguage = model.showLanguage;
    
    [_nameLabel setText:name];
    [_startTimeLabel setText:startTime];
    [_endTimeLabel setText:endTime];
    
    if([showLanguage isEqualToString:@"ZH"] || showLanguage == nil || [showLanguage isEqualToString:@""]){
        [_nameTitleLabel setText:@"社团/项目/活动名称:"];
        [_startTimeTitleLabel setText:@"开始时间:"];
        [_endTimeTitleLabel setText:@"结束时间:"];
        
    }else{
        [_nameTitleLabel setText:@"Activity Name:"];
        [_startTimeTitleLabel setText:@"Start Time:"];
        [_endTimeTitleLabel setText:@"End Time:"];
    }
    
    //更新尺寸
    CGFloat nameTitleWidth = [UILabel getWidthWithText:_nameTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    CGFloat startTimeTitleWidth = [UILabel getWidthWithText:_startTimeTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    CGFloat endTimeTitleWidth = [UILabel getWidthWithText:_endTimeTitleLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    [_nameTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(nameTitleWidth, 22));
    }];
    
    [_startTimeTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
           make.size.mas_equalTo(CGSizeMake(startTimeTitleWidth, 22));
       }];
    
    [_endTimeTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
           make.size.mas_equalTo(CGSizeMake(endTimeTitleWidth, 22));
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
