//
//  MineResultDetailViewController.m
//  Cafe
//
//  Created by leo on 2020/1/7.
//  Copyright © 2020 leo. All rights reserved.
//
//  成绩详情

#import "MineResultDetailViewController.h"

#import "MineResultShowViewController.h"    //成绩编辑页面

@interface MineResultDetailViewController ()

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
    @private UIView *moreActionView;
    
    @private UIImageView *contentImageView; //图片
    
    @private UIView *contentView;           //内容
    
    @private UILabel *resultTypeLabel;
    @private UILabel *resultTypeTitleLabel;
    
    @private UILabel *resultDateLabel;
    @private UILabel *resultDateTitleLabel;
    
    @private UILabel *resultLocationLabel;
    @private UILabel *resultLocationTitleLabel;
    
    @private UILabel *resultOrgLabel;
    @private UILabel *resultOrgTitleLabel;
    
    @private UILabel *scoreALabel;
    @private UILabel *scoreATitleLabel;
    
    @private UILabel *scoreBLabel;
    @private UILabel *scoreBTitleLabel;
    
    @private UILabel *scoreCLabel;
    @private UILabel *scoreCTitleLabel;
    
    @private UILabel *scoreDLabel;
    @private UILabel *scoreDTitleLabel;
    
    @private UILabel *scoreELabel;
    @private UILabel *scoreETitleLabel;
    
    @private UILabel *examScoreLabel;
    @private UILabel *examScoreTitleLabel;
    
    @private NSString *type;
    @private NSString *date;
    @private NSString *location;
    @private NSString *org;
    @private NSString *scoreA;
    @private NSString *scoreATitleName;
    @private NSString *scoreB;
    @private NSString *scoreBTitleName;
    @private NSString *scoreC;
    @private NSString *scoreCTitleName;
    @private NSString *scoreD;
    @private NSString *scoreDTitleName;
    @private NSString *scoreE;
    @private NSString *scoreETitleName;
    @private NSString *examScore;
    @private NSString *scoreFile;
    
    @private BOOL isViewUp;
}

@end

@implementation MineResultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self getParentVars];
    [self initNavigationView];
    [self initView];
    [self setListener];
    [self setData];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);
    
    //内容视图此时所在位置，是否在上方
    isViewUp = YES;
}

#pragma mark - 初始化数据 -
-(void)initSharedPreferences
{
    @try {
        
    } @catch (NSException *exception) {
        @throw exception;
        
    }
}

#pragma mark - 获取父页面参数 -
-(void)getParentVars
{
    type = @"";
    date = @"";
    location = @"";
    org = @"";
    scoreA = @"";
    scoreB = @"";
    scoreC = @"";
    scoreD = @"";
    scoreE = @"";
    examScore = @"";
    scoreFile = @"";
        
    if(_dataDic != nil){
        type = _dataDic[@"type"];
        [self bridgeExamType:type];
        date = _dataDic[@"date"];
        location = _dataDic[@"location"];
        org = _dataDic[@"org"];
        scoreA = _dataDic[@"scoreA"];
        scoreB = _dataDic[@"scoreB"];
        scoreC = _dataDic[@"scoreC"];
        scoreD = _dataDic[@"scoreD"];
        scoreE = _dataDic[@"scoreE"];
        examScore = _dataDic[@"examScore"];
        scoreFile = _dataDic[@"scoreFile"];
    }
}

#pragma mark - 初始化导航视图 -
-(void)initNavigationView
{
    //1.顶部导航视图
    navigationView = [UIView new];
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(StatusBarSafeTopMargin);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 64));
    }];
    [navigationView setBackgroundColor:[UIColor clearColor]];
    
    //左上角返回按钮
    backButton = [UIButton new];
    [navigationView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(navigationView).offset(10);
        make.bottom.equalTo(navigationView).offset(-11);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    //设置点击不变色
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_foreign_back"] forState:UIControlStateNormal];
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //右上角操作按钮
    rightButton = [UIButton new];
    [navigationView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(navigationView).offset(-10);
        make.top.equalTo(backButton).offset(1);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"更多" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [rightButton setAttributedTitle:rightButtonString forState:UIControlStateNormal];
    //右上角按钮点击
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //标题
    UILabel *titleLabel = [UILabel new];
    [navigationView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-150)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(150, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //图片
    contentImageView = [UIImageView new];
    contentImageView.frame = CGRectMake(20, StatusBarSafeTopMargin + 64 + 10, SCREEN_WIDTH - 40, 160);
    [self.view addSubview:contentImageView];
    contentImageView.layer.masksToBounds = YES;
    contentImageView.layer.cornerRadius = 10;
    contentImageView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor;
    contentImageView.layer.shadowOffset = CGSizeMake(0,5);
    contentImageView.layer.shadowOpacity = 1;
    contentImageView.layer.shadowRadius = 15;
    [contentImageView sd_setImageWithURL:[NSURL URLWithString:[_F createFileLoadUrl:scoreFile]]];
    
    //内容
    contentView = [UIView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentImageView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(@290);
    }];
    contentView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contentView.layer.cornerRadius = 10;
    contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,0);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 10;
    
    CGFloat labelWidth = (SCREEN_WIDTH - 20)/3;
    
    //考试类型
    resultTypeLabel = [UILabel new];
    [contentView addSubview:resultTypeLabel];
    [resultTypeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView).offset(20);
        make.left.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(labelWidth, 22));
    }];
    
    resultTypeTitleLabel = [UILabel new];
    [contentView addSubview:resultTypeTitleLabel];
    [resultTypeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultTypeLabel.mas_bottom).offset(15);
        make.left.equalTo(resultTypeLabel);
        make.size.mas_equalTo(CGSizeMake(labelWidth, 20));
    }];


    UIView *splitView1 = [UIView new];
    [contentView addSubview:splitView1];
    [splitView1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView).offset(25);
        make.right.equalTo(resultTypeLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(1, 48));
    }];
    [splitView1 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];


    //考试日期
    resultDateLabel = [UILabel new];
    [contentView addSubview:resultDateLabel];
    [resultDateLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView).offset(20);
        make.left.equalTo(resultTypeLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(labelWidth, 22));
    }];

    resultDateTitleLabel = [UILabel new];
    [contentView addSubview:resultDateTitleLabel];
    [resultDateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultDateLabel.mas_bottom).offset(15);
        make.left.equalTo(resultDateLabel);
        make.size.mas_equalTo(CGSizeMake(labelWidth, 20));
    }];

    UIView *splitView2 = [UIView new];
    [contentView addSubview:splitView2];
    [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView).offset(25);
        make.right.equalTo(resultDateLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(1, 48));
    }];
    [splitView2 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];


    //考试地点
    resultLocationLabel = [UILabel new];
    [contentView addSubview:resultLocationLabel];
    [resultLocationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView).offset(20);
        make.left.equalTo(resultDateLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(labelWidth, 22));
    }];

    resultLocationTitleLabel = [UILabel new];
    [contentView addSubview:resultLocationTitleLabel];
    [resultLocationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultLocationLabel.mas_bottom).offset(15);
        make.left.equalTo(resultLocationLabel);
        make.size.mas_equalTo(CGSizeMake(labelWidth, 20));
    }];
    
    //虚线视图
    UIView *dashView1 = [UIView new];
    [contentView addSubview:dashView1];
    [dashView1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView).offset(96);
        make.left.equalTo(contentView).offset(10);
        make.right.equalTo(contentView).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    [self.view layoutIfNeeded];
    [_F drawDashLine:dashView1 lineLength:6 lineSpacing:3 lineColor:RGBA_GGCOLOR(241, 241, 241, 1)];
    
    UIView *dashView2 = [UIView new];
    [contentView addSubview:dashView2];
    [dashView2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView1).offset(96);
        make.left.equalTo(contentView).offset(10);
        make.right.equalTo(contentView).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    [self.view layoutIfNeeded];
    [_F drawDashLine:dashView2 lineLength:6 lineSpacing:3 lineColor:RGBA_GGCOLOR(241, 241, 241, 241)];
    
    //参加的培训机构
    resultOrgLabel = [UILabel new];
    [contentView addSubview:resultOrgLabel];
    [resultOrgLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView1.mas_bottom).offset(15);
        make.right.equalTo(contentView).mas_offset(-20);
        make.size.mas_equalTo(CGSizeMake(150, 66));
    }];

    resultOrgTitleLabel = [UILabel new];
    [contentView addSubview:resultOrgTitleLabel];
    [resultOrgTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView1.mas_bottom).offset(38);
        make.left.equalTo(contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(98, 20));
    }];
    
    //先添加总分
    examScoreLabel = [UILabel new];
    [contentView addSubview:examScoreLabel];
    [examScoreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView2.mas_bottom).offset(19);
        make.right.equalTo(contentView).offset(-5);
        make.size.mas_equalTo(CGSizeMake(90, 22));
    }];

    examScoreTitleLabel = [UILabel new];
    [contentView addSubview:examScoreTitleLabel];
    [examScoreTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(examScoreLabel.mas_bottom).offset(15);
        make.right.equalTo(contentView).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    //分割线
    UIView *splitView3 = [UIView new];
    [contentView addSubview:splitView3];
    [splitView3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView2.mas_bottom).offset(24);
        make.right.equalTo(examScoreLabel.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(1, 47));
    }];
    [splitView3 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    //scoreA
    scoreALabel = [UILabel new];
    [contentView addSubview:scoreALabel];
    [scoreALabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView2.mas_bottom).offset(19);
        make.left.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];

    scoreATitleLabel = [UILabel new];
    [contentView addSubview:scoreATitleLabel];
    [scoreATitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreALabel.mas_bottom).offset(15);
        make.left.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];
    
    //scoreB
    scoreBLabel = [UILabel new];
    [contentView addSubview:scoreBLabel];
    [scoreBLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView2.mas_bottom).offset(19);
        make.left.equalTo(scoreALabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];

    scoreBTitleLabel = [UILabel new];
    [contentView addSubview:scoreBTitleLabel];
    [scoreBTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreBLabel.mas_bottom).offset(15);
        make.left.equalTo(scoreATitleLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];

    //scoreC
    scoreCLabel = [UILabel new];
    [contentView addSubview:scoreCLabel];
    [scoreCLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView2.mas_bottom).offset(19);
        make.left.equalTo(scoreBLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];

    scoreCTitleLabel = [UILabel new];
    [contentView addSubview:scoreCTitleLabel];
    [scoreCTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreCLabel.mas_bottom).offset(15);
        make.left.equalTo(scoreBTitleLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];
    
    //scoreD
    scoreDLabel = [UILabel new];
    [contentView addSubview:scoreDLabel];
    [scoreDLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView2.mas_bottom).offset(19);
        make.left.equalTo(scoreCLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];

    scoreDTitleLabel = [UILabel new];
    [contentView addSubview:scoreDTitleLabel];
    [scoreDTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreDLabel.mas_bottom).offset(15);
        make.left.equalTo(scoreCTitleLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];
    
    //scoreE
    scoreELabel = [UILabel new];
    [contentView addSubview:scoreELabel];
    [scoreELabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dashView2.mas_bottom).offset(19);
        make.left.equalTo(scoreDLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];

    scoreETitleLabel = [UILabel new];
    [contentView addSubview:scoreETitleLabel];
    [scoreETitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreELabel.mas_bottom).offset(15);
        make.left.equalTo(scoreDTitleLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 100 - 20)/5, 22));
    }];
}

#pragma mark - 添加监听 -
-(void)setListener
{
    [self.view layoutIfNeeded];
    
    //添加上滑、下滑手势监测
    UISwipeGestureRecognizer *recognizer;
    //上滑
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [contentView addGestureRecognizer:recognizer];
    //下滑
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [contentView addGestureRecognizer:recognizer];
}

#pragma mark - 设置参数 -
-(void)setData
{
    [self bridgeScoreSubType];
    
    //考试类型
    [_F setLabelStyle:resultTypeTitleLabel withName:@"考试类型" textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:resultTypeLabel withName:type textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
    //考试日期
    [_F setLabelStyle:resultDateTitleLabel withName:@"考试日期" textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:resultDateLabel withName:date textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
    //考试地点
    [_F setLabelStyle:resultLocationTitleLabel withName:@"考试地点" textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:resultLocationLabel withName:location textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
    //参加的培训机构
    [_F setLabelStyle:resultOrgTitleLabel withName:@"参加的培训机构" textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:resultOrgLabel withName:org textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
    //scoreA
    [_F setLabelStyle:scoreATitleLabel withName:scoreATitleName textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:scoreALabel withName:scoreA textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
    //scoreB
    [_F setLabelStyle:scoreBTitleLabel withName:scoreBTitleName textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:scoreBLabel withName:scoreB textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
    //scoreC
    [_F setLabelStyle:scoreCTitleLabel withName:scoreCTitleName textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:scoreCLabel withName:scoreC textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
    //scoreD
    [_F setLabelStyle:scoreDTitleLabel withName:scoreDTitleName textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:scoreDLabel withName:scoreD textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
    //scoreE
    [_F setLabelStyle:scoreETitleLabel withName:scoreETitleName textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:scoreELabel withName:scoreE textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
    //总分
    [_F setLabelStyle:examScoreTitleLabel withName:@"总分" textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14] textColor:RGBA_GGCOLOR(193, 193, 193, 1)];
    [_F setLabelStyle:examScoreLabel withName:examScore textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16] textColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    
}

- (NSString *)bridgeExamType:(NSString *)examType
{
    //考试类型:类型1->TOEFL，类型2->IELTS，类型3->GRE，类型4->GMAT，类型5->SAT，类型6->SSAT，类型7->ACT
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

- (void)bridgeScoreSubType
{
    scoreATitleName = @"";
    scoreBTitleName = @"";
    scoreCTitleName = @"";
    scoreDTitleName = @"";
    scoreETitleName = @"";

    if ([type isEqualToString:@"TOEFL"] || [type isEqualToString:@"IELTS"]) {
        scoreATitleName = @"L";
        scoreBTitleName = @"S";
        scoreCTitleName = @"R";
        scoreDTitleName = @"W";
    }
    
    if ([type isEqualToString:@"GRE"]) {
        scoreATitleName = @"V";
        scoreBTitleName = @"Q";
        scoreCTitleName = @"AW";
    }

    if ([type isEqualToString:@"GMAT"]) {
        scoreATitleName = @"V";
        scoreBTitleName = @"Q";
        scoreCTitleName = @"AW";
        scoreDTitleName = @"IR";
    }
    
    if ([type isEqualToString:@"SAT"]) {
        scoreATitleName = @"EBRW";
        scoreBTitleName = @"M";
        scoreCTitleName = @"ER";
        scoreDTitleName = @"EA";
        scoreETitleName = @"EW";
    }
    
    if ([type isEqualToString:@"SSAT"]) {
        scoreATitleName = @"Q";
        scoreBTitleName = @"V";
        scoreCTitleName = @"R";
    }

    if ([type isEqualToString:@"ACT"]) {
        scoreATitleName = @"R";
        scoreBTitleName = @"E";
        scoreCTitleName = @"M";
        scoreDTitleName = @"S";
        scoreETitleName = @"W";
    }

}

#pragma mark - 手势处理 -
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        //向下滑动，如何这时候内容视图在上方，就滑下来
        if(isViewUp){
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            CGPoint point = contentView.center;
            point.y += 115;
            [contentView setCenter:point];
            [UIView commitAnimations];
            
            //此时在下方
            isViewUp = NO;
        }
    }

    if (recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        //向上滑动，如果这时候内容视图在下方，就滑上来
        if(!isViewUp){
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            CGPoint point = contentView.center;
            point.y -= 115;
            [contentView setCenter:point];
            [UIView commitAnimations];
            
            //此时在上方
            isViewUp = YES;
        }
    }
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    //设置回调
    NSDictionary *sendDataDic = @{@"type":type,
                                  @"date":date,
                                  @"location":location,
                                  @"org":org,
                                  @"scoreA":scoreA,
                                  @"scoreB":scoreB,
                                  @"scoreC":scoreC,
                                  @"scoreD":scoreD,
                                  @"scoreE":scoreE,
                                  @"examScore":examScore
    };
    
    //Block传值step 3:传值类将要传的值传入自己的block中
    self.sendValueBlock(sendDataDic);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 编辑按钮点击 -
-(void)rightButtonClick
{
    moreActionView = [UIView new];
    [self.view addSubview:moreActionView];
    [moreActionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(rightButton.mas_bottom).offset(5);
        make.right.equalTo(rightButton);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    moreActionView.layer.cornerRadius = 10;
    moreActionView.layer.masksToBounds = YES;
    [moreActionView setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *editButton = [UIButton new];
    [moreActionView addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(moreActionView);
        make.left.equalTo(moreActionView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    editButton.adjustsImageWhenHighlighted = NO;
    NSMutableAttributedString *editButtonString = [[NSMutableAttributedString alloc] initWithString:@"编辑" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor blackColor]}];
    [editButton setAttributedTitle:editButtonString forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *splitView = [UIView new];
    [moreActionView addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(editButton.mas_bottom).offset(1);
        make.left.equalTo(moreActionView).offset(5);
        make.right.equalTo(moreActionView).offset(-5);
        make.height.mas_equalTo(@1);
    }];
    [splitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    [moreActionView layoutIfNeeded];

    
    UIButton *deleteButton = [UIButton new];
    [moreActionView addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(editButton.mas_bottom);
        make.left.equalTo(moreActionView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    deleteButton.adjustsImageWhenHighlighted = NO;
    NSMutableAttributedString *deleteButtonString = [[NSMutableAttributedString alloc] initWithString:@"删除" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor blackColor]}];
    [deleteButton setAttributedTitle:deleteButtonString forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)editButtonClick
{
    moreActionView.hidden = YES;
    [moreActionView removeFromSuperview];
    
    NSDictionary *sendDic = @{
        @"type":type,
        @"date":date,
        @"location":location,
        @"org":org,
        @"scoreA":scoreA,
        @"scoreB":scoreB,
        @"scoreC":scoreC,
        @"scoreD":scoreD,
        @"scoreE":scoreE,
        @"examScore":examScore
    };
    
    MineResultShowViewController *showVC = [MineResultShowViewController new];

    //设置block回调
    [showVC setSendValueBlock:^(NSDictionary *valueDict){
        
        //回调函数
        self->type = valueDict[@"type"];
        self->date = valueDict[@"date"];
        self->location = valueDict[@"location"];
        self->org = valueDict[@"org"];
        self->scoreA = valueDict[@"scoreA"];
        self->scoreB = valueDict[@"scoreB"];
        self->scoreC = valueDict[@"scoreC"];
        self->scoreD = valueDict[@"scoreD"];
        self->scoreE = valueDict[@"scoreE"];
        self->examScore = valueDict[@"examScore"];
        
        [self setData];

    }];

    showVC.dataDic = sendDic;

    [self.navigationController pushViewController:showVC animated:YES];

}

- (void)deleteButtonClick
{
    moreActionView.hidden = YES;
    [moreActionView removeFromSuperview];
    
}

#pragma mark - touch screen hide moreActionView -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    moreActionView.hidden = YES;
    [moreActionView removeFromSuperview];
}
@end
