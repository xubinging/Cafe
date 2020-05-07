//
//  MineAddOfferScoreTableViewCell.m
//  Cafe
//
//  Created by migu on 2020/5/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineAddOfferScoreTableViewCell.h"

@implementation MineAddOfferScoreTableViewCell

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
        _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0,5);
        _backView.layer.shadowOpacity = 1;
        _backView.layer.shadowRadius = 15;
        
        
        //分数类型
        _scoreTypeLabel = [UILabel new];
        [_backView addSubview:_scoreTypeLabel];
        [_scoreTypeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_backView).offset(10);
            make.left.equalTo(_backView).offset(10);
            make.right.equalTo(_backView).offset(-10);
            make.height.mas_equalTo(@22);
        }];
        _scoreTypeLabel.numberOfLines = 0;
        _scoreTypeLabel.textAlignment = NSTextAlignmentLeft;
        _scoreTypeLabel.alpha = 1.0;
        [_scoreTypeLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [_scoreTypeLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
        
        _selectButton = [UIButton new];
        [_backView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scoreTypeLabel);
            make.left.equalTo(_backView.mas_right).offset(-180);
            make.width.mas_equalTo(@80);
            make.height.mas_equalTo(@22);
        }];
        _selectButton.adjustsImageWhenHighlighted = NO;
        _selectButton.layer.cornerRadius = 12;
        NSMutableAttributedString *buttonString = [[NSMutableAttributedString alloc] initWithString:@"选择成绩"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
        [_selectButton setAttributedTitle:buttonString forState:UIControlStateNormal];
        [_selectButton.layer setBorderColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor];
        [_selectButton.layer setBorderWidth:1.0];
        [_selectButton addTarget:self action:@selector(selectButtonClick) forControlEvents:UIControlEventTouchUpInside];

        
        _showButton = [UIButton new];
        [_backView addSubview:_showButton];
        [_showButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scoreTypeLabel);
            make.left.equalTo(_selectButton.mas_right).offset(10);
            make.width.mas_equalTo(@80);
            make.height.mas_equalTo(@22);
        }];
        _showButton.adjustsImageWhenHighlighted = NO;
        _showButton.layer.cornerRadius = 12;
        NSMutableAttributedString *buttonString2 = [[NSMutableAttributedString alloc] initWithString:@"晒晒成绩"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
        [_showButton setAttributedTitle:buttonString2 forState:UIControlStateNormal];
        [_showButton.layer setBorderColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor];
        [_showButton.layer setBorderWidth:1.0];
        [_showButton addTarget:self action:@selector(showButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        //总分
        _totalScoreView = [UILabel new];
        [_backView addSubview:_totalScoreView];
        [_totalScoreView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreTypeLabel.mas_bottom).offset(15);
            make.left.equalTo(_backView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 57));
        }];
        _totalScoreView.hidden = YES;
        
        _totalScoreLabel = [UILabel new];
        [_totalScoreView addSubview:_totalScoreLabel];
        [_totalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_totalScoreView);
            make.left.equalTo(_totalScoreView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 22));
        }];
        _totalScoreLabel.numberOfLines = 0;
        _totalScoreLabel.textAlignment = NSTextAlignmentCenter;
        _totalScoreLabel.alpha = 1.0;
        [_totalScoreLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        [_totalScoreLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        
        _totalScoreTitleLabel = [UILabel new];
        [_totalScoreView addSubview:_totalScoreTitleLabel];
        [_totalScoreTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_totalScoreLabel.mas_bottom).offset(15);
            make.left.equalTo(_totalScoreView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 20));
        }];
        _totalScoreTitleLabel.numberOfLines = 0;
        _totalScoreTitleLabel.textAlignment = NSTextAlignmentCenter;
        _totalScoreTitleLabel.alpha = 1.0;
        [_totalScoreTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_totalScoreTitleLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
        
        UIView *spiltView1 = [UIView new];
        [_totalScoreView addSubview:spiltView1];
        [spiltView1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_totalScoreView).offset(14);
            make.right.equalTo(_totalScoreView);
            make.size.mas_equalTo(CGSizeMake(1, 30));
        }];
        
        
        //分数一
        _scoreOneView = [UILabel new];
        [_backView addSubview:_scoreOneView];
        [_scoreOneView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreTypeLabel.mas_bottom).offset(15);
            make.left.equalTo(_totalScoreView.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 57));
        }];
        _scoreOneView.hidden = YES;
        
        _scoreOneLabel = [UILabel new];
        [_scoreOneView addSubview:_scoreOneLabel];
        [_scoreOneLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreOneView);
            make.left.equalTo(_scoreOneView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 22));
        }];
        _scoreOneLabel.numberOfLines = 0;
        _scoreOneLabel.textAlignment = NSTextAlignmentCenter;
        _scoreOneLabel.alpha = 1.0;
        [_scoreOneLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        [_scoreOneLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        
        _scoreOneTitleLabel = [UILabel new];
        [_scoreOneView addSubview:_scoreOneTitleLabel];
        [_scoreOneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreOneLabel.mas_bottom).offset(15);
            make.left.equalTo(_scoreOneView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 20));
        }];
        _scoreOneTitleLabel.numberOfLines = 0;
        _scoreOneTitleLabel.textAlignment = NSTextAlignmentCenter;
        _scoreOneTitleLabel.alpha = 1.0;
        [_scoreOneTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_scoreOneTitleLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
        
        UIView *spiltView2 = [UIView new];
        [_scoreOneView addSubview:spiltView2];
        [spiltView2 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreOneView).offset(14);
            make.right.equalTo(_scoreOneView);
            make.size.mas_equalTo(CGSizeMake(1, 30));
        }];
        

        //分数二
        _scoreTwoView = [UILabel new];
        [_backView addSubview:_scoreTwoView];
        [_scoreTwoView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreTypeLabel.mas_bottom).offset(15);
            make.left.equalTo(_scoreOneView.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 57));
        }];
        _scoreTwoView.hidden = YES;
        
        _scoreTwoLabel = [UILabel new];
        [_scoreTwoView addSubview:_scoreTwoLabel];
        [_scoreTwoLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreTwoView);
            make.left.equalTo(_scoreTwoView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 22));
        }];
        _scoreTwoLabel.numberOfLines = 0;
        _scoreTwoLabel.textAlignment = NSTextAlignmentCenter;
        _scoreTwoLabel.alpha = 1.0;
        [_scoreTwoLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        [_scoreTwoLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        
        _scoreTwoTitleLabel = [UILabel new];
        [_scoreTwoView addSubview:_scoreTwoTitleLabel];
        [_scoreTwoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreTwoLabel.mas_bottom).offset(15);
            make.left.equalTo(_scoreTwoView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 20));
        }];
        _scoreTwoTitleLabel.numberOfLines = 0;
        _scoreTwoTitleLabel.textAlignment = NSTextAlignmentCenter;
        _scoreTwoTitleLabel.alpha = 1.0;
        [_scoreTwoTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_scoreTwoTitleLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
        
        UIView *spiltView3 = [UIView new];
        [_scoreTwoView addSubview:spiltView3];
        [spiltView3 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreTwoView).offset(14);
            make.right.equalTo(_scoreTwoView);
            make.size.mas_equalTo(CGSizeMake(1, 30));
        }];

        
        //分数三
        _scoreThreeView = [UILabel new];
        [_backView addSubview:_scoreThreeView];
        [_scoreThreeView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreTypeLabel.mas_bottom).offset(15);
            make.left.equalTo(_scoreTwoView.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 57));
        }];
        _scoreThreeView.hidden = YES;
        
        _scoreThreeLabel = [UILabel new];
        [_scoreThreeView addSubview:_scoreThreeLabel];
        [_scoreThreeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreThreeView);
            make.left.equalTo(_scoreThreeView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 22));
        }];
        _scoreThreeLabel.numberOfLines = 0;
        _scoreThreeLabel.textAlignment = NSTextAlignmentCenter;
        _scoreThreeLabel.alpha = 1.0;
        [_scoreThreeLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        [_scoreThreeLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        
        _scoreThreeTitleLabel = [UILabel new];
        [_scoreThreeView addSubview:_scoreThreeTitleLabel];
        [_scoreThreeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreThreeLabel.mas_bottom).offset(15);
            make.left.equalTo(_scoreThreeView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 20));
        }];
        _scoreThreeTitleLabel.numberOfLines = 0;
        _scoreThreeTitleLabel.textAlignment = NSTextAlignmentCenter;
        _scoreThreeTitleLabel.alpha = 1.0;
        [_scoreThreeTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_scoreThreeTitleLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
        
        UIView *spiltView4 = [UIView new];
        [_scoreThreeView addSubview:spiltView4];
        [spiltView4 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreThreeView).offset(14);
            make.right.equalTo(_scoreThreeView);
            make.size.mas_equalTo(CGSizeMake(1, 30));
        }];
        
        
        //分数四
        _scoreFourView = [UILabel new];
        [_backView addSubview:_scoreFourView];
        [_scoreFourView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreTypeLabel.mas_bottom).offset(15);
            make.left.equalTo(_scoreThreeView.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 57));
        }];
        _scoreFourView.hidden = YES;
        
        _scoreFourLabel = [UILabel new];
        [_scoreFourView addSubview:_scoreFourLabel];
        [_scoreFourLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreFourView);
            make.left.equalTo(_scoreFourView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 22));
        }];
        _scoreFourLabel.numberOfLines = 0;
        _scoreFourLabel.textAlignment = NSTextAlignmentCenter;
        _scoreFourLabel.alpha = 1.0;
        [_scoreFourLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        [_scoreFourLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        
        _scoreFourTitleLabel = [UILabel new];
        [_scoreFourView addSubview:_scoreFourTitleLabel];
        [_scoreFourTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreFourLabel.mas_bottom).offset(15);
            make.left.equalTo(_scoreFourView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 20));
        }];
        _scoreFourTitleLabel.numberOfLines = 0;
        _scoreFourTitleLabel.textAlignment = NSTextAlignmentCenter;
        _scoreFourTitleLabel.alpha = 1.0;
        [_scoreFourTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_scoreFourTitleLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];

        
        //分数五
        _scoreFiveView = [UILabel new];
        [_backView addSubview:_scoreFiveView];
        [_scoreFiveView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreTypeLabel.mas_bottom).offset(15);
            make.left.equalTo(_scoreFourView.mas_right);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 57));
        }];
        _scoreFiveView.hidden = YES;
        
        _scoreFiveLabel = [UILabel new];
        [_scoreFiveView addSubview:_scoreFiveLabel];
        [_scoreFiveLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreFiveView);
            make.left.equalTo(_scoreFiveView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 22));
        }];
        _scoreFiveLabel.numberOfLines = 0;
        _scoreFiveLabel.textAlignment = NSTextAlignmentCenter;
        _scoreFiveLabel.alpha = 1.0;
        [_scoreFiveLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
        [_scoreFiveLabel setTextColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]];
        
        _scoreFiveTitleLabel = [UILabel new];
        [_scoreFiveView addSubview:_scoreFiveTitleLabel];
        [_scoreFiveTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_scoreFiveLabel.mas_bottom).offset(15);
            make.left.equalTo(_scoreFiveView);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 20));
        }];
        _scoreFiveTitleLabel.numberOfLines = 0;
        _scoreFiveTitleLabel.textAlignment = NSTextAlignmentCenter;
        _scoreFiveTitleLabel.alpha = 1.0;
        [_scoreFiveTitleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [_scoreFiveTitleLabel setTextColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];

    }
    
    return self;
}

- (void)updateCellWithModel:(MineOfferScoreModel *)model
{
    NSString *scoreType = model.scoreType;
    
    NSString *totalScoreTitle = model.totalScoreTitle;
    NSString *totalScore = model.totalScore;
    
    NSString *scoreOneTitle = model.scoreOneTitle;
    NSString *scoreOne = model.scoreOne;
    
    NSString *scoreTwoTitle = model.scoreTwoTitle;
    NSString *scoreTwo = model.scoreTwo;
    
    NSString *scoreThreeTitle = model.scoreThreeTitle;
    NSString *scoreThree = model.scoreThree;
    
    NSString *scoreFourTitle = model.scoreFourTitle;
    NSString *scoreFour = model.scoreFour;
    
    NSString *scoreFiveTitle = model.scoreFiveTitle;
    NSString *scoreFive = model.scoreFive;
    
    [_scoreTypeLabel setText:scoreType];
    
    //总分
    if(![totalScoreTitle isEqualToString:@""] && totalScoreTitle != nil){
        _totalScoreView.hidden = NO;
        
        [_totalScoreTitleLabel setText:totalScoreTitle];
        [_totalScoreLabel setText:totalScore];
    }
    
    //分数一
    if(![scoreOneTitle isEqualToString:@""] && scoreOneTitle != nil){
        _scoreOneView.hidden = NO;
        
        [_scoreOneTitleLabel setText:scoreOneTitle];
        [_scoreOneLabel setText:scoreOne];
    }
    
    //分数二
    if(![scoreTwoTitle isEqualToString:@""] && scoreTwoTitle != nil){
        _scoreTwoView.hidden = NO;
        
        [_scoreTwoTitleLabel setText:scoreTwoTitle];
        [_scoreTwoLabel setText:scoreTwo];
    }
    
    //分数三
    if(![scoreThreeTitle isEqualToString:@""] && scoreThreeTitle != nil){
        _scoreThreeView.hidden = NO;
        
        [_scoreThreeTitleLabel setText:scoreThreeTitle];
        [_scoreThreeLabel setText:scoreThree];
    }
    
    //分数四
    if(![scoreFourTitle isEqualToString:@""] && scoreFourTitle != nil){
        _scoreFourView.hidden = NO;
        
        [_scoreFourTitleLabel setText:scoreFourTitle];
        [_scoreFourLabel setText:scoreFour];
    }
    
    //分数五
    if(![scoreFiveTitle isEqualToString:@""] && scoreFiveTitle != nil){
        _scoreFiveView.hidden = NO;
        
        [_scoreFiveTitleLabel setText:scoreFiveTitle];
        [_scoreFiveLabel setText:scoreFive];
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


- (void)selectButtonClick
{
    switch (self.indexPathSection) {
        case 0: {
            
        }
            break;
            
        case 1: {
            
        }
            break;

        case 2: {
            
        }
            break;
            
        case 3: {
            
        }
            break;
        
        case 4: {
            
        }
            break;
            
        case 5: {
            
        }
            break;
                        
        default:
            break;
    }
}


- (void)showButtonClick
{
    switch (self.indexPathSection) {
        case 0: {
            
        }
            break;
            
        case 1: {
            
        }
            break;

        case 2: {
            
        }
            break;
            
        case 3: {
            
        }
            break;
        
        case 4: {
            
        }
            break;
            
        case 5: {
            
        }
            break;
                        
        default:
            break;
    }
}

@end
