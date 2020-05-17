//
//  MineResultTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineResultTableViewCell.h"

@implementation MineResultTableViewCell

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
        
        //左侧的背景
        UIView *leftBackView = [UIView new];
        [self.contentView addSubview:leftBackView];
        [leftBackView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(32);
            make.left.equalTo(_backView);
            make.size.mas_equalTo(CGSizeMake(5, 33));
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
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:leftBackView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.5, 5.5)];
        CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc] init];
        cornerRadiusLayer.frame = leftBackView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        leftBackView.layer.mask = cornerRadiusLayer;
        
        
        CGFloat labelWidth = (SCREEN_WIDTH - 20 - 5)/3;
        
        //考试类型
        _resultTypeLabel = [UILabel new];
        [_backView addSubview:_resultTypeLabel];
        [_resultTypeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(20);
            make.left.equalTo(leftBackView.mas_right);
            make.size.mas_equalTo(CGSizeMake(labelWidth, 22));
        }];
        _resultTypeLabel.numberOfLines = 0;
        _resultTypeLabel.textAlignment = NSTextAlignmentCenter;
        _resultTypeLabel.alpha = 1.0;
        [_resultTypeLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        [_resultTypeLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        
        _resultTypeTitleLabel = [UILabel new];
        [_backView addSubview:_resultTypeTitleLabel];
        [_resultTypeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_resultTypeLabel.mas_bottom).offset(15);
            make.left.equalTo(_resultTypeLabel);
            make.size.mas_equalTo(CGSizeMake(labelWidth, 20));
        }];
        _resultTypeTitleLabel.numberOfLines = 0;
        _resultTypeTitleLabel.textAlignment = NSTextAlignmentCenter;
        _resultTypeTitleLabel.alpha = 1.0;
        [_resultTypeTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_resultTypeTitleLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
        
        UIView *splitView1 = [UIView new];
        [_backView addSubview:splitView1];
        [splitView1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(25);
            make.right.equalTo(_resultTypeLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(1, 97-50));
        }];
        [splitView1 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    

        //考试日期
        _resultDateLabel = [UILabel new];
        [_backView addSubview:_resultDateLabel];
        [_resultDateLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(20);
            make.left.equalTo(_resultTypeLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(labelWidth, 22));
        }];
        _resultDateLabel.numberOfLines = 0;
        _resultDateLabel.textAlignment = NSTextAlignmentCenter;
        _resultDateLabel.alpha = 1.0;
        [_resultDateLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        [_resultDateLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        
        _resultDateTitleLabel = [UILabel new];
        [_backView addSubview:_resultDateTitleLabel];
        [_resultDateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_resultDateLabel.mas_bottom).offset(15);
            make.left.equalTo(_resultDateLabel);
            make.size.mas_equalTo(CGSizeMake(labelWidth, 20));
        }];
        _resultDateTitleLabel.numberOfLines = 0;
        _resultDateTitleLabel.textAlignment = NSTextAlignmentCenter;
        _resultDateTitleLabel.alpha = 1.0;
        [_resultDateTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_resultDateTitleLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
        
        UIView *splitView2 = [UIView new];
        [_backView addSubview:splitView2];
        [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(25);
            make.right.equalTo(_resultDateLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(1, 97-50));
        }];
        [splitView2 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
        

        //总分
        _resultScoreLabel = [UILabel new];
        [_backView addSubview:_resultScoreLabel];
        [_resultScoreLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(20);
            make.left.equalTo(_resultDateLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(labelWidth, 22));
        }];
        _resultScoreLabel.numberOfLines = 0;
        _resultScoreLabel.textAlignment = NSTextAlignmentCenter;
        _resultScoreLabel.alpha = 1.0;
        [_resultScoreLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        [_resultScoreLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        
        _resultScoreTitleLabel = [UILabel new];
        [_backView addSubview:_resultScoreTitleLabel];
        [_resultScoreTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_resultScoreLabel.mas_bottom).offset(15);
            make.left.equalTo(_resultScoreLabel);
            make.size.mas_equalTo(CGSizeMake(labelWidth, 20));
        }];
        _resultScoreTitleLabel.numberOfLines = 0;
        _resultScoreTitleLabel.textAlignment = NSTextAlignmentCenter;
        _resultScoreTitleLabel.alpha = 1.0;
        [_resultScoreTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_resultScoreTitleLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
    }
    
    return self;
}

- (void)updateCellWithModel:(MineResultModel *)model
{

    NSString *resultType = [self bridgeExamType:model.examType];
    
    NSString *resultDate = @"";
    if ([model.examDate isKindOfClass:[NSString class]]) {
        resultDate = model.examDate;
    } else {
        resultDate = [NSString stringWithFormat:@"%@",model.examDate];
    }

    NSString *resultScore = model.examScore;
    NSString *showLanguage = model.showLanguage;    //ZH -- 中文；EN -- 英文
    
    [_resultTypeLabel setText:resultType];
    [_resultDateLabel setText:resultDate];
    [_resultScoreLabel setText:resultScore];
    
    if([showLanguage isEqualToString:@"ZH"] || showLanguage == nil || [showLanguage isEqualToString:@""]){
        [_resultTypeTitleLabel setText:@"考试类型"];
        [_resultDateTitleLabel setText:@"考试日期"];
        [_resultScoreTitleLabel setText:@"总分"];
        
    }else{
        [_resultTypeTitleLabel setText:@"Type"];
        [_resultDateTitleLabel setText:@"Date"];
        [_resultScoreTitleLabel setText:@"Score"];
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

- (NSString *)bridgeExamType:(NSString *)examType
{
    //考试类型:类型1->TOEFL，类型2->IELTS，类型3->GRE，类型4->GMAT，类型5->SAT，类型6->SSAT，类型7->ACT
    NSString *type = examType;
    if ([examType isKindOfClass:[NSString class]]) {
        switch (examType.integerValue) {
            case 1:
                type = @"TOEFL";
                break;
            case 2:
                type = @"IELTS";
                break;
            case 3:
                type = @"GRE";
                break;
            case 4:
                type = @"GMAT";
                break;
            case 5:
                type = @"SAT";
                break;
            case 6:
                type = @"SSAT";
                break;
            case 7:
                type = @"ACT";
                break;
                
            default:
                break;
        }
    }
    
    return type;
}
@end
