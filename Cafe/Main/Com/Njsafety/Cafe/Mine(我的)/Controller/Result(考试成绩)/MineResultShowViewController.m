//
//  MineResultShowViewController.m
//  Cafe
//
//  Created by leo on 2020/1/7.
//  Copyright © 2020 leo. All rights reserved.
//
//  晒晒成绩

#import "MineResultShowViewController.h"
#import "AvalonsoftImagePicker.h"

#define TEXTFIELD_TAG 10000

@interface MineResultShowViewController ()<UITextFieldDelegate>

{
    @private UIButton *backButton;              //左上角返回按钮
    @private UIView *navigationView;
    
    @private UIView *contentView;
    @private UIScrollView *contentScrollView;   //滑动视图
    @private UIButton *saveButton;              //保存按钮
    @private UIView *scoreCSplitView;
    
    @private UITextField *typeTextField;        //考试类型
    @private UITextField *dateTextField;        //考试日期
    @private UITextField *locationTextField;    //考试地点
    @private UITextField *orgTextField;         //机构
    
    @private UILabel *scoreALabel;
    @private UILabel *scoreBLabel;
    @private UILabel *scoreCLabel;
    @private UILabel *scoreDLabel;
    @private UILabel *scoreELabel;
    
    @private UITextField *scoreATextField;
    @private UITextField *scoreBTextField;
    @private UITextField *scoreCTextField;
    @private UITextField *scoreDTextField;
    @private UITextField *scoreETextField;
    @private UITextField *examScoreTextField;
    @private UIButton *uploadFileButton;        //上传附件按钮    
}

@end

@implementation MineResultShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self initScrollView];
    [self setData];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);

}

#pragma mark - 初始化数据 -
-(void)initSharedPreferences
{
    @try {
        
    } @catch (NSException *exception) {
        @throw exception;
        
    }
}

#pragma mark - 初始化导航视图 -
-(void)initNavigationView
{
    //***** 顶部导航视图 *****//
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
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"晒晒成绩"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //内容视图
    contentView = [UIView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
    }];
    
    contentView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contentView.layer.cornerRadius = 8;
    contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,0);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 10;
    
    //保存按钮
    saveButton = [UIButton new];
    [contentView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(contentView).offset(-35);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.height.mas_equalTo(@46);
    }];
    saveButton.layer.cornerRadius = 23;
    saveButton.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.3].CGColor;
    saveButton.layer.shadowOffset = CGSizeMake(0,5);
    saveButton.layer.shadowOpacity = 1;
    saveButton.layer.shadowRadius = 15;
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //设置文字
    NSMutableAttributedString *saveButtonString = [[NSMutableAttributedString alloc] initWithString:@"保存" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    [saveButton setAttributedTitle:saveButtonString forState:UIControlStateNormal];
    
    [self.view layoutIfNeeded];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = saveButton.bounds;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 23;
    //添加到最底层，否则会覆盖文字
    [saveButton.layer insertSublayer:gl atIndex:0];
}

#pragma mark - 初始化滑动视图 -
-(void)initScrollView
{
    //可滑动部分
    contentScrollView = [UIScrollView new];
    [contentView addSubview:contentScrollView];
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView);
        make.bottom.equalTo(saveButton.mas_top).offset(-30);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
    }];
    [contentScrollView setBackgroundColor:[UIColor clearColor]];
    contentScrollView.showsVerticalScrollIndicator = NO;
    [contentScrollView setContentSize:CGSizeMake(SCREEN_WIDTH-20, 1050)];
        
    //***** 考试类型 *****//
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 28, SCREEN_WIDTH - 20 - 30, 20)];
    [contentScrollView addSubview:typeLabel];
    [self setTitleLabelStyle:typeLabel withName:@"考试类型"];

    UIImageView *typeNextStep = [UIImageView new];
    [contentScrollView addSubview:typeNextStep];
    [typeNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeLabel.mas_bottom).offset(19);
        make.right.equalTo(typeLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [typeNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    typeTextField = [UITextField new];
    [contentScrollView addSubview:typeTextField];
    [typeTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeLabel.mas_bottom).offset(1);
        make.left.equalTo(typeLabel);
        make.right.equalTo(typeNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:typeTextField withTag:1];

    UIView *countrySplitView = [UIView new];
    [contentScrollView addSubview:countrySplitView];
    [countrySplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeTextField.mas_bottom).offset(1);
        make.left.equalTo(typeLabel).offset(-5);
        make.right.equalTo(typeLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [countrySplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 考试日期 *****//
    UILabel *dateLabel = [UILabel new];
    [contentScrollView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countrySplitView.mas_bottom).offset(28);
        make.left.equalTo(countrySplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:dateLabel withName:@"考试日期"];

    UIImageView *dateNextStep = [UIImageView new];
    [contentScrollView addSubview:dateNextStep];
    [dateNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateLabel.mas_bottom).offset(19);
        make.right.equalTo(dateLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [dateNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    dateTextField = [UITextField new];
    [contentScrollView addSubview:dateTextField];
    [dateTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateLabel.mas_bottom).offset(1);
        make.left.equalTo(dateLabel);
        make.right.equalTo(dateNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:dateTextField withTag:2];

    UIView *dateSplitView = [UIView new];
    [contentScrollView addSubview:dateSplitView];
    [dateSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateTextField.mas_bottom).offset(1);
        make.left.equalTo(dateLabel).offset(-5);
        make.right.equalTo(dateLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [dateSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 考试地点 *****//
    UILabel *locationLabel = [UILabel new];
    [contentScrollView addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateSplitView.mas_bottom).offset(28);
        make.left.equalTo(dateSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:locationLabel withName:@"考试地点"];

    UIImageView *locationNextStep = [UIImageView new];
    [contentScrollView addSubview:locationNextStep];
    [locationNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(locationLabel.mas_bottom).offset(19);
        make.right.equalTo(locationLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [locationNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    locationTextField = [UITextField new];
    [contentScrollView addSubview:locationTextField];
    [locationTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(locationLabel.mas_bottom).offset(1);
        make.left.equalTo(locationLabel);
        make.right.equalTo(locationNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:locationTextField withTag:3];

    UIView *locationSplitView = [UIView new];
    [contentScrollView addSubview:locationSplitView];
    [locationSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(locationTextField.mas_bottom).offset(1);
        make.left.equalTo(locationLabel).offset(-5);
        make.right.equalTo(locationLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [locationSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 参加的培训机构 *****//
    UILabel *orgLabel = [UILabel new];
    [contentScrollView addSubview:orgLabel];
    [orgLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(locationSplitView.mas_bottom).offset(28);
        make.left.equalTo(locationSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:orgLabel withName:@"参加的培训机构"];

    UIImageView *orgNextStep = [UIImageView new];
    [contentScrollView addSubview:orgNextStep];
    [orgNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(orgLabel.mas_bottom).offset(19);
        make.right.equalTo(orgLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [orgNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    orgTextField = [UITextField new];
    [contentScrollView addSubview:orgTextField];
    [orgTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(orgLabel.mas_bottom).offset(1);
        make.left.equalTo(orgLabel);
        make.right.equalTo(orgNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:orgTextField withTag:4];

    UIView *orgSplitView = [UIView new];
    [contentScrollView addSubview:orgSplitView];
    [orgSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(orgTextField.mas_bottom).offset(1);
        make.left.equalTo(orgLabel).offset(-5);
        make.right.equalTo(orgLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [orgSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    //***** scoreA *****//
    scoreALabel = [UILabel new];
    [contentScrollView addSubview:scoreALabel];
    [scoreALabel mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(orgSplitView.mas_bottom).offset(28);
       make.left.equalTo(orgSplitView).offset(5);
       make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];

    UIImageView *scoreANextStep = [UIImageView new];
    [contentScrollView addSubview:scoreANextStep];
    [scoreANextStep mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreALabel.mas_bottom).offset(19);
       make.right.equalTo(scoreALabel);
       make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [scoreANextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    scoreATextField = [UITextField new];
    [contentScrollView addSubview:scoreATextField];
    [scoreATextField mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreALabel.mas_bottom).offset(1);
       make.left.equalTo(scoreALabel);
       make.right.equalTo(scoreANextStep.mas_left).offset(-15);
       make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:scoreATextField withTag:5];

    UIView *scoreASplitView = [UIView new];
    [contentScrollView addSubview:scoreASplitView];
    [scoreASplitView mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreATextField.mas_bottom).offset(1);
       make.left.equalTo(scoreALabel).offset(-5);
       make.right.equalTo(scoreALabel).offset(5);
       make.height.mas_equalTo(@1);
    }];
    [scoreASplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];


    //***** scoreB *****//
    scoreBLabel = [UILabel new];
    [contentScrollView addSubview:scoreBLabel];
    [scoreBLabel mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreASplitView.mas_bottom).offset(28);
       make.left.equalTo(scoreASplitView).offset(5);
       make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];

    UIImageView *scoreBNextStep = [UIImageView new];
    [contentScrollView addSubview:scoreBNextStep];
    [scoreBNextStep mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreBLabel.mas_bottom).offset(19);
       make.right.equalTo(scoreBLabel);
       make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [scoreBNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    scoreBTextField = [UITextField new];
    [contentScrollView addSubview:scoreBTextField];
    [scoreBTextField mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreBLabel.mas_bottom).offset(1);
       make.left.equalTo(scoreBLabel);
       make.right.equalTo(scoreBNextStep.mas_left).offset(-15);
       make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:scoreBTextField withTag:6];

    UIView *scoreBSplitView = [UIView new];
    [contentScrollView addSubview:scoreBSplitView];
    [scoreBSplitView mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreBTextField.mas_bottom).offset(1);
       make.left.equalTo(scoreBLabel).offset(-5);
       make.right.equalTo(scoreBLabel).offset(5);
       make.height.mas_equalTo(@1);
    }];
    [scoreBSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];


    //***** scoreC *****//
    scoreCLabel = [UILabel new];
    [contentScrollView addSubview:scoreCLabel];
    [scoreCLabel mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreBSplitView.mas_bottom).offset(28);
       make.left.equalTo(scoreBSplitView).offset(5);
       make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];

    UIImageView *scoreCNextStep = [UIImageView new];
    [contentScrollView addSubview:scoreCNextStep];
    [scoreCNextStep mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreCLabel.mas_bottom).offset(19);
       make.right.equalTo(scoreCLabel);
       make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [scoreCNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    scoreCTextField = [UITextField new];
    [contentScrollView addSubview:scoreCTextField];
    [scoreCTextField mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreCLabel.mas_bottom).offset(1);
       make.left.equalTo(scoreCLabel);
       make.right.equalTo(scoreBNextStep.mas_left).offset(-15);
       make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:scoreCTextField withTag:7];

    scoreCSplitView = [UIView new];
    [contentScrollView addSubview:scoreCSplitView];
    [scoreCSplitView mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(scoreCTextField.mas_bottom).offset(1);
       make.left.equalTo(scoreCLabel).offset(-5);
       make.right.equalTo(scoreCLabel).offset(5);
       make.height.mas_equalTo(@1);
    }];
    [scoreCSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    [self setupSubViewsWithType:self.model.examType];
}

- (void)setupSubViewsWithType:(NSString *)type
{
    if ([type isEqualToString:@"TOEFL"] || [type isEqualToString:@"IELTS"]) {
        [self setupSubViews2];
        [self setTitleLabelStyle:scoreALabel withName:@"L"];
        [self setTitleLabelStyle:scoreBLabel withName:@"S"];
        [self setTitleLabelStyle:scoreCLabel withName:@"R"];
        [self setTitleLabelStyle:scoreDLabel withName:@"W"];
    }
    
    if ([type isEqualToString:@"GRE"]) {
        [self setupSubViews1];
        [self setTitleLabelStyle:scoreALabel withName:@"V"];
        [self setTitleLabelStyle:scoreBLabel withName:@"Q"];
        [self setTitleLabelStyle:scoreCLabel withName:@"AW"];
        [contentScrollView setContentSize:CGSizeMake(SCREEN_WIDTH-20, 950)];
    }
    
    if ([type isEqualToString:@"GMAT"]) {
        [self setupSubViews2];
        [self setTitleLabelStyle:scoreALabel withName:@"V"];
        [self setTitleLabelStyle:scoreBLabel withName:@"Q"];
        [self setTitleLabelStyle:scoreCLabel withName:@"AW"];
        [self setTitleLabelStyle:scoreDLabel withName:@"IR"];
    }
    
    if ([type isEqualToString:@"SAT"]) {
        [self setupSubViews3];
        [self setTitleLabelStyle:scoreALabel withName:@"EBRW"];
        [self setTitleLabelStyle:scoreBLabel withName:@"M"];
        [self setTitleLabelStyle:scoreCLabel withName:@"ER"];
        [self setTitleLabelStyle:scoreDLabel withName:@"EA"];
        [self setTitleLabelStyle:scoreELabel withName:@"EW"];
        [contentScrollView setContentSize:CGSizeMake(SCREEN_WIDTH-20, 1150)];
    }
    
    if ([type isEqualToString:@"SSAT"]) {
        [self setupSubViews1];
        [self setTitleLabelStyle:scoreALabel withName:@"Q"];
        [self setTitleLabelStyle:scoreBLabel withName:@"V"];
        [self setTitleLabelStyle:scoreCLabel withName:@"R"];
        [contentScrollView setContentSize:CGSizeMake(SCREEN_WIDTH-20, 950)];
    }
    
    if ([type isEqualToString:@"ACT"]) {
        [self setupSubViews3];
        [self setTitleLabelStyle:scoreALabel withName:@"R"];
        [self setTitleLabelStyle:scoreBLabel withName:@"E"];
        [self setTitleLabelStyle:scoreCLabel withName:@"M"];
        [self setTitleLabelStyle:scoreDLabel withName:@"S"];
        [self setTitleLabelStyle:scoreELabel withName:@"W"];
        [contentScrollView setContentSize:CGSizeMake(SCREEN_WIDTH-20, 1150)];
    }
}

- (void)setupSubViews1
{
    //***** 总分 *****//
    UILabel *resultScoreLabel = [UILabel new];
    [contentScrollView addSubview:resultScoreLabel];
    [resultScoreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreCSplitView.mas_bottom).offset(28);
        make.left.equalTo(scoreCSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:resultScoreLabel withName:@"总分"];

    UIImageView *resultScoreNextStep = [UIImageView new];
    [contentScrollView addSubview:resultScoreNextStep];
    [resultScoreNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreLabel.mas_bottom).offset(19);
        make.right.equalTo(resultScoreLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [resultScoreNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    examScoreTextField = [UITextField new];
    [contentScrollView addSubview:examScoreTextField];
    [examScoreTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreLabel.mas_bottom).offset(1);
        make.left.equalTo(resultScoreLabel);
        make.right.equalTo(resultScoreNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:examScoreTextField withTag:10];

    UIView *resultScoreSplitView = [UIView new];
    [contentScrollView addSubview:resultScoreSplitView];
    [resultScoreSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(examScoreTextField.mas_bottom).offset(1);
        make.left.equalTo(resultScoreLabel).offset(-5);
        make.right.equalTo(resultScoreLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [resultScoreSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //上传照片
    UILabel *uploadPicLabel = [UILabel new];
    [contentScrollView addSubview:uploadPicLabel];
    [uploadPicLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreSplitView.mas_bottom).offset(15);
        make.left.equalTo(scoreCSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:uploadPicLabel withName:@"上传成绩"];
    
    //上传附件按钮
    uploadFileButton = [UIButton new];
    [contentScrollView addSubview:uploadFileButton];
    [uploadFileButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(uploadPicLabel.mas_bottom).offset(15);
        make.left.equalTo(uploadPicLabel);
        make.size.mas_equalTo(CGSizeMake(78, 78));
    }];
    [uploadFileButton setImage:[UIImage imageNamed:@"mine_upload_file"] forState:UIControlStateNormal];
    [uploadFileButton setAdjustsImageWhenHighlighted:NO];
    [uploadFileButton addTarget:self action:@selector(uploadExamResult) forControlEvents:UIControlEventTouchUpInside];

    
    //说明文字
    UILabel *detailLabel = [UILabel new];
    [contentScrollView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(uploadFileButton).offset(30);
        make.left.equalTo(uploadFileButton.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(220, 18));
    }];
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.alpha = 1.0;

    NSMutableAttributedString *detailLabelString = [[NSMutableAttributedString alloc] initWithString:@"支持png,jpg,jpeg等格式,大小不超过5M" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]}];
    detailLabel.attributedText = detailLabelString;
}


- (void)setupSubViews2
{
    //***** scoreD *****//
    scoreDLabel = [UILabel new];
    [contentScrollView addSubview:scoreDLabel];
    [scoreDLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreCSplitView.mas_bottom).offset(28);
        make.left.equalTo(scoreCSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];

    UIImageView *scoreDNextStep = [UIImageView new];
    [contentScrollView addSubview:scoreDNextStep];
    [scoreDNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreDLabel.mas_bottom).offset(19);
        make.right.equalTo(scoreDLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [scoreDNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    scoreDTextField = [UITextField new];
    [contentScrollView addSubview:scoreDTextField];
    [scoreDTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreDLabel.mas_bottom).offset(1);
        make.left.equalTo(scoreDLabel);
        make.right.equalTo(scoreDNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:scoreDTextField withTag:8];

    UIView *scoreDSplitView = [UIView new];
    [contentScrollView addSubview:scoreDSplitView];
    [scoreDSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreDTextField.mas_bottom).offset(1);
        make.left.equalTo(scoreDLabel).offset(-5);
        make.right.equalTo(scoreDLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [scoreDSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 总分 *****//
    UILabel *resultScoreLabel = [UILabel new];
    [contentScrollView addSubview:resultScoreLabel];
    [resultScoreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreDSplitView.mas_bottom).offset(28);
        make.left.equalTo(scoreDSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:resultScoreLabel withName:@"总分"];

    UIImageView *resultScoreNextStep = [UIImageView new];
    [contentScrollView addSubview:resultScoreNextStep];
    [resultScoreNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreLabel.mas_bottom).offset(19);
        make.right.equalTo(resultScoreLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [resultScoreNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    examScoreTextField = [UITextField new];
    [contentScrollView addSubview:examScoreTextField];
    [examScoreTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreLabel.mas_bottom).offset(1);
        make.left.equalTo(resultScoreLabel);
        make.right.equalTo(resultScoreNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:examScoreTextField withTag:10];

    UIView *resultScoreSplitView = [UIView new];
    [contentScrollView addSubview:resultScoreSplitView];
    [resultScoreSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(examScoreTextField.mas_bottom).offset(1);
        make.left.equalTo(resultScoreLabel).offset(-5);
        make.right.equalTo(resultScoreLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [resultScoreSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //上传照片
    UILabel *uploadPicLabel = [UILabel new];
    [contentScrollView addSubview:uploadPicLabel];
    [uploadPicLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreSplitView.mas_bottom).offset(15);
        make.left.equalTo(scoreDSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:uploadPicLabel withName:@"上传成绩"];
    
    //上传附件按钮
    uploadFileButton = [UIButton new];
    [contentScrollView addSubview:uploadFileButton];
    [uploadFileButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(uploadPicLabel.mas_bottom).offset(15);
        make.left.equalTo(uploadPicLabel);
        make.size.mas_equalTo(CGSizeMake(78, 78));
    }];
    [uploadFileButton setImage:[UIImage imageNamed:@"mine_upload_file"] forState:UIControlStateNormal];
    [uploadFileButton setAdjustsImageWhenHighlighted:NO];
    [uploadFileButton addTarget:self action:@selector(uploadExamResult) forControlEvents:UIControlEventTouchUpInside];
    
    //说明文字
    UILabel *detailLabel = [UILabel new];
    [contentScrollView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(uploadFileButton).offset(30);
        make.left.equalTo(uploadFileButton.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(220, 18));
    }];
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.alpha = 1.0;

    NSMutableAttributedString *detailLabelString = [[NSMutableAttributedString alloc] initWithString:@"支持png,jpg,jpeg等格式,大小不超过5M" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]}];
    detailLabel.attributedText = detailLabelString;
}

- (void)setupSubViews3
{
    //***** scoreD *****//
    scoreDLabel = [UILabel new];
    [contentScrollView addSubview:scoreDLabel];
    [scoreDLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreCSplitView.mas_bottom).offset(28);
        make.left.equalTo(scoreCSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];

    UIImageView *scoreDNextStep = [UIImageView new];
    [contentScrollView addSubview:scoreDNextStep];
    [scoreDNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreDLabel.mas_bottom).offset(19);
        make.right.equalTo(scoreDLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [scoreDNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    scoreDTextField = [UITextField new];
    [contentScrollView addSubview:scoreDTextField];
    [scoreDTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreDLabel.mas_bottom).offset(1);
        make.left.equalTo(scoreDLabel);
        make.right.equalTo(scoreDNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:scoreDTextField withTag:8];

    UIView *scoreDSplitView = [UIView new];
    [contentScrollView addSubview:scoreDSplitView];
    [scoreDSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreDTextField.mas_bottom).offset(1);
        make.left.equalTo(scoreDLabel).offset(-5);
        make.right.equalTo(scoreDLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [scoreDSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** scoreE *****//
    scoreELabel = [UILabel new];
    [contentScrollView addSubview:scoreELabel];
    [scoreELabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreDSplitView.mas_bottom).offset(28);
        make.left.equalTo(scoreDSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];

    UIImageView *scoreENextStep = [UIImageView new];
    [contentScrollView addSubview:scoreENextStep];
    [scoreENextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreELabel.mas_bottom).offset(19);
        make.right.equalTo(scoreELabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [scoreENextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    scoreETextField = [UITextField new];
    [contentScrollView addSubview:scoreETextField];
    [scoreETextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreELabel.mas_bottom).offset(1);
        make.left.equalTo(scoreELabel);
        make.right.equalTo(scoreENextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:scoreETextField withTag:9];

    UIView *scoreESplitView = [UIView new];
    [contentScrollView addSubview:scoreESplitView];
    [scoreESplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreETextField.mas_bottom).offset(1);
        make.left.equalTo(scoreELabel).offset(-5);
        make.right.equalTo(scoreELabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [scoreESplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 总分 *****//
    UILabel *resultScoreLabel = [UILabel new];
    [contentScrollView addSubview:resultScoreLabel];
    [resultScoreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(scoreESplitView.mas_bottom).offset(28);
        make.left.equalTo(scoreESplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:resultScoreLabel withName:@"总分"];

    UIImageView *resultScoreNextStep = [UIImageView new];
    [contentScrollView addSubview:resultScoreNextStep];
    [resultScoreNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreLabel.mas_bottom).offset(19);
        make.right.equalTo(resultScoreLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [resultScoreNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    examScoreTextField = [UITextField new];
    [contentScrollView addSubview:examScoreTextField];
    [examScoreTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreLabel.mas_bottom).offset(1);
        make.left.equalTo(resultScoreLabel);
        make.right.equalTo(resultScoreNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:examScoreTextField withTag:10];

    UIView *resultScoreSplitView = [UIView new];
    [contentScrollView addSubview:resultScoreSplitView];
    [resultScoreSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(examScoreTextField.mas_bottom).offset(1);
        make.left.equalTo(resultScoreLabel).offset(-5);
        make.right.equalTo(resultScoreLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [resultScoreSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //上传照片
    UILabel *uploadPicLabel = [UILabel new];
    [contentScrollView addSubview:uploadPicLabel];
    [uploadPicLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreSplitView.mas_bottom).offset(15);
        make.left.equalTo(scoreESplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:uploadPicLabel withName:@"上传成绩"];
    
    //上传附件按钮
    uploadFileButton = [UIButton new];
    [contentScrollView addSubview:uploadFileButton];
    [uploadFileButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(uploadPicLabel.mas_bottom).offset(15);
        make.left.equalTo(uploadPicLabel);
        make.size.mas_equalTo(CGSizeMake(78, 78));
    }];
    [uploadFileButton setImage:[UIImage imageNamed:@"mine_upload_file"] forState:UIControlStateNormal];
    [uploadFileButton setAdjustsImageWhenHighlighted:NO];
    [uploadFileButton addTarget:self action:@selector(uploadExamResult) forControlEvents:UIControlEventTouchUpInside];
    
    //说明文字
    UILabel *detailLabel = [UILabel new];
    [contentScrollView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(uploadFileButton).offset(30);
        make.left.equalTo(uploadFileButton.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(220, 18));
    }];
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.alpha = 1.0;

    NSMutableAttributedString *detailLabelString = [[NSMutableAttributedString alloc] initWithString:@"支持png,jpg,jpeg等格式,大小不超过5M" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]}];
    detailLabel.attributedText = detailLabelString;
}

#pragma mark - 设置参数 -
-(void)setData
{
    typeTextField.text = self.model.examType;
    dateTextField.text = self.model.examDate;
    locationTextField.text = self.model.address;
    orgTextField.text = self.model.examOrgan;
    scoreATextField.text = self.model.scoreA;
    scoreBTextField.text = self.model.scoreB;
    scoreCTextField.text = self.model.scoreC;
    scoreDTextField.text = self.model.scoreD;
    scoreETextField.text = self.model.scoreE;
    examScoreTextField.text = self.model.examScore;
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    [self editMineExamScore];
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    NSInteger tfTag = textField.tag - TEXTFIELD_TAG;
    
    switch (tfTag) {
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10: {
            return YES;
        }
            break;
        
        case 1: {
            [self resignFirstResponderForTextField];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"TOEFL",@"IELTS",@"GRE",@"GMAT",@"SAT",@"SSAT",@"ACT"] DefaultSelValue:@"TOEFL" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
                __strong typeof(weakSelf) strongSelf = weakSelf;

                self.model.examType = selectValue;
                strongSelf->typeTextField.text = selectValue;
                [strongSelf clearData];
            }];
        }
            break;
            
        case 2: {
            [self resignFirstResponderForTextField];

            NSDate *now = [NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *nowStr = [fmt stringFromDate:now];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
//                self->date = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//                self->dateTextField.text = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                
                self.model.examDate = selectValue;
                strongSelf->dateTextField.text = selectValue;
            }];
        }
            break;
            
        case 3: {
            [self resignFirstResponderForTextField];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showAddressPickerWithTitle:@"" DefaultSelected:@[@11, @1, @5] IsAutoSelect:NO Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow){
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                self.model.address = [NSString stringWithFormat:@"%@ %@ %@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                strongSelf->locationTextField.text = [NSString stringWithFormat:@"%@ %@ %@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
            }];
        }
            break;
            
        default:
            break;
    }
    
    return NO;
}

#pragma mark - 统一设置标题label格式 -
-(void)setTitleLabelStyle:(UILabel *)titleLabel withName:(NSString *)labelName
{
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:labelName attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 统一textfield格式 -
-(void)setTextFieldStyle:(UITextField *)textField withTag:(NSInteger)tag
{
    textField.tag = tag + TEXTFIELD_TAG;
    textField.delegate = self;
    [textField setTextAlignment:NSTextAlignmentLeft];
    textField.clearButtonMode = UITextFieldViewModeNever;
    textField.borderStyle = UITextBorderStyleNone;
    //设置输入后文字样式
    [textField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [textField setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
}


#pragma mark 上传成绩
- (void)uploadExamResult
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (image) {
            [strongSelf->uploadFileButton setImage:image forState:UIControlStateNormal];
        }
    }];
}

- (void)resignFirstResponderForTextField
{
    [orgTextField resignFirstResponder];
    [scoreATextField resignFirstResponder];
    [scoreBTextField resignFirstResponder];
    [scoreCTextField resignFirstResponder];
    [scoreDTextField resignFirstResponder];
    [scoreETextField resignFirstResponder];
    [examScoreTextField resignFirstResponder];
}

- (void)clearData
{
    dateTextField.text = nil;
    locationTextField.text = nil;
    orgTextField.text = nil;
    scoreATextField.text = nil;
    scoreBTextField.text = nil;
    scoreCTextField.text = nil;
    scoreDTextField.text = nil;
    scoreETextField.text = nil;
    examScoreTextField.text = nil;
}

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [self resignFirstResponderForTextField];
}


#pragma mark - 网络请求
- (void)editMineExamScore
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:strongSelf.model.examType forKey:@"examType"];
            [root setValue:strongSelf.model.examScore forKey:@"examScore"];
            [root setValue:strongSelf.model.examDate forKey:@"examDate"];
            [root setValue:strongSelf.model.scoreA forKey:@"scoreA"];
            [root setValue:strongSelf.model.scoreB forKey:@"scoreB"];
            [root setValue:strongSelf.model.scoreC forKey:@"scoreC"];
            [root setValue:strongSelf.model.scoreD forKey:@"scoreD"];
            [root setValue:strongSelf.model.scoreE forKey:@"scoreE"];
            [root setValue:strongSelf.model.ID forKey:@"id"];
            [root setValue:strongSelf.model.areaType forKey:@"areaType"];
            [root setValue:strongSelf.model.countryCode forKey:@"countryCode"];
            [root setValue:strongSelf.model.countryName forKey:@"countryName"];
            [root setValue:strongSelf.model.provincesCode forKey:@"provincesCode"];
            [root setValue:strongSelf.model.provincesName forKey:@"provincesName"];
            [root setValue:strongSelf.model.cityCode forKey:@"cityCode"];
            [root setValue:strongSelf.model.cityName forKey:@"cityName"];
            [root setValue:strongSelf.model.address forKey:@"address"];
            [root setValue:strongSelf.model.examOrgan forKey:@"examOrgan"];
            [root setValue:strongSelf.model.insid forKey:@"insid"];
            [root setValue:strongSelf.model.scoreFile forKey:@"scoreFile"];
            [root setValue:strongSelf.model.username forKey:@"nickname"];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:@"0" forKey:@"delSign"];
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EXAM_SCORE_UPDATE method:HttpRequestPost paramenters:root prepareExecute:^{

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);

                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        MineResultModel *model = [MineResultModel modelWithDict:rspData];

                        if (self.sendValueBlock) {
                            self.sendValueBlock(model);
                        }
                        
                        [strongSelf.navigationController popViewControllerAnimated:YES];
                    }
                } @catch (NSException *exception) {
                    @throw exception;
                    //给出提示信息
                    [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
                }

            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
            }];

        } else {
            //没网
            //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}

@end
