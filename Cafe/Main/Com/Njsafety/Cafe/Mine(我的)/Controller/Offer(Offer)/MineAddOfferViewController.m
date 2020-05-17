//
//  MineAddOfferViewController.m
//  Cafe
//
//  Created by migu on 2020/5/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineAddOfferViewController.h"
#import "MineAddOfferScoreTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AvalonsoftImagePicker.h"
#import "MineSelectOfferViewController.h"
#import "MineResultShowViewController.h"

#define TEXTFIELD_TAG 10000
#define K_ScoreTableView_CellHeight     114
#define K_NumberOfSections              6
#define K_HeightForHeaderInSection      20

@interface MineAddOfferViewController () <UITextFieldDelegate, UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,MineSelectButtonDelegate>
{
    @private UIButton *backButton;
    @private UIButton *saveButton;
    @private UIView *navigationView;
   
    @private UIScrollView *contentView;
    @private UITextField *countryTextField;
    @private UITextField *schoolTextField;
    @private UITextField *studyStageTextField;
    @private UITextField *majorTextField;
    @private UITextField *agentCompanyTextField;
    @private UITextField *internationalSchoolTextField;
    @private UITextField *internationalDateTextField1;
    @private UITextField *internationalDateTextField2;
    @private UITextField *gpaTextField;
    @private UIView *splitView7;
    @private UIButton *uploadOfferButton;
    @private UITextView *contentTextView;

    
    @private NSString *country;
    @private NSString *studyStage;
    @private NSString *internationalDate1;
    @private NSString *internationalDate2;

    

    
    
    
    
    
    
    
    
    
    @private UITextField *locationTextField;
    @private UITextField *positionTextField;
    @private UITextField *startDateTextField;
    @private UITextField *endDateTextField;
   
    @private NSString *companyName;
    @private NSString *location;
    @private NSString *position;
    @private NSString *startDate;
    @private NSString *endDate;
    @private NSString *Description;
}

@property (nonatomic,strong) UITableView *scoreTableView;
@property (nonatomic,strong) NSMutableArray *scoreArray;


@end

@implementation MineAddOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self setData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [contentView setContentSize:CGSizeMake(SCREEN_WIDTH-20, 2000)];
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

- (NSMutableArray *)scoreArray
{
    return _scoreArray?:(_scoreArray = [NSMutableArray array]);
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
    
    //右上角保存按钮
    saveButton = [UIButton new];
    [navigationView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(navigationView).offset(-10);
        make.bottom.equalTo(navigationView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(28, 20));
    }];
    //设置点击不变色
    saveButton.adjustsImageWhenHighlighted = NO;
    NSMutableAttributedString *saveButtonString = [[NSMutableAttributedString alloc] initWithString:@"保存"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [saveButton setAttributedTitle:saveButtonString forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //内容视图
    contentView = [UIScrollView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
    }];
    [contentView setBackgroundColor:[UIColor clearColor]];
    contentView.showsVerticalScrollIndicator = NO;
    
    
    UIView *contentView1 = [UIView new];
    [contentView addSubview:contentView1];
    contentView1.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 750);
    [contentView1 setBackgroundColor:[UIColor whiteColor]];
    contentView1.layer.cornerRadius = 8;
    contentView1.layer.masksToBounds = YES;
    
    
    //***** 国家 *****//
    UILabel *label1 = [UILabel new];
    [contentView1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView1).offset(28);
        make.left.equalTo(contentView1).offset(15);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label1 withName:@"国家"];

    UIImageView *nextStep1 = [UIImageView new];
    [contentView1 addSubview:nextStep1];
    [nextStep1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label1.mas_bottom).offset(19);
        make.right.equalTo(label1);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep1 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    countryTextField = [UITextField new];
    [contentView1 addSubview:countryTextField];
    [countryTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label1.mas_bottom).offset(1);
        make.left.equalTo(label1);
        make.right.equalTo(nextStep1.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:countryTextField withTag:1];

    UIView *splitView1 = [UIView new];
    [contentView1 addSubview:splitView1];
    [splitView1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryTextField.mas_bottom).offset(1);
        make.left.equalTo(label1).offset(-5);
        make.right.equalTo(label1).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [splitView1 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];

    
    //***** 学校名称(英文) *****//
    UILabel *label2 = [UILabel new];
    [contentView1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(splitView1.mas_bottom).offset(28);
        make.left.equalTo(splitView1).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label2 withName:@"学校名称(英文)"];

    UIImageView *nextStep2 = [UIImageView new];
    [contentView1 addSubview:nextStep2];
    [nextStep2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label2.mas_bottom).offset(19);
        make.right.equalTo(label2);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep2 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    schoolTextField = [UITextField new];
    [contentView1 addSubview:schoolTextField];
    [schoolTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label2.mas_bottom).offset(1);
        make.left.equalTo(label2);
        make.right.equalTo(nextStep2.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:schoolTextField withTag:2];
    [schoolTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIView *splitView2 = [UIView new];
    [contentView1 addSubview:splitView2];
    [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(schoolTextField.mas_bottom).offset(1);
        make.left.equalTo(label2).offset(-5);
        make.right.equalTo(label2).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [splitView2 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 就读阶段 *****//
    UILabel *label3 = [UILabel new];
    [contentView1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(splitView2.mas_bottom).offset(28);
        make.left.equalTo(splitView2).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label3 withName:@"就读阶段"];

    UIImageView *nextStep3 = [UIImageView new];
    [contentView1 addSubview:nextStep3];
    [nextStep3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label3.mas_bottom).offset(19);
        make.right.equalTo(label3);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep3 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    studyStageTextField = [UITextField new];
    [contentView1 addSubview:studyStageTextField];
    [studyStageTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label3.mas_bottom).offset(1);
        make.left.equalTo(label3);
        make.right.equalTo(nextStep3.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:studyStageTextField withTag:3];
    [studyStageTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIView *splitView3 = [UIView new];
    [contentView1 addSubview:splitView3];
    [splitView3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(studyStageTextField.mas_bottom).offset(1);
        make.left.equalTo(label3).offset(-5);
        make.right.equalTo(label3).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [splitView3 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    

    
    //***** 专业 *****//
    UILabel *label4 = [UILabel new];
    [contentView1 addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(splitView3.mas_bottom).offset(28);
       make.left.equalTo(splitView3).offset(5);
       make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label4 withName:@"专业"];

    UIImageView *nextStep4 = [UIImageView new];
    [contentView1 addSubview:nextStep4];
    [nextStep4 mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(label4.mas_bottom).offset(19);
       make.right.equalTo(label4);
       make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep4 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    majorTextField = [UITextField new];
    [contentView1 addSubview:majorTextField];
    [majorTextField mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(label4.mas_bottom).offset(1);
       make.left.equalTo(label4);
       make.right.equalTo(nextStep4.mas_left).offset(-15);
       make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:majorTextField withTag:4];
    [majorTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIView *splitView4 = [UIView new];
    [contentView1 addSubview:splitView4];
    [splitView4 mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(majorTextField.mas_bottom).offset(1);
       make.left.equalTo(label4).offset(-5);
       make.right.equalTo(label4).offset(5);
       make.height.mas_equalTo(@1);
    }];
    [splitView4 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    
    
    //***** 代办留学公司 *****//
    UILabel *label5 = [UILabel new];
    [contentView1 addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(splitView4.mas_bottom).offset(28);
      make.left.equalTo(splitView4).offset(5);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label5 withName:@"代办留学公司"];

    UIImageView *nextStep5 = [UIImageView new];
    [contentView1 addSubview:nextStep5];
    [nextStep5 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label5.mas_bottom).offset(19);
      make.right.equalTo(label5);
      make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep5 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    agentCompanyTextField = [UITextField new];
    [contentView1 addSubview:agentCompanyTextField];
    [agentCompanyTextField mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label5.mas_bottom).offset(1);
      make.left.equalTo(label5);
      make.right.equalTo(nextStep5.mas_left).offset(-15);
      make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:agentCompanyTextField withTag:5];
    [agentCompanyTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIView *splitView5 = [UIView new];
    [contentView1 addSubview:splitView5];
    [splitView5 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(agentCompanyTextField.mas_bottom).offset(1);
      make.left.equalTo(label5).offset(-5);
      make.right.equalTo(label5).offset(5);
      make.height.mas_equalTo(@1);
    }];
    [splitView5 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];

    
    
    //***** 就读国际学校 *****//
    UILabel *label6 = [UILabel new];
    [contentView1 addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(splitView5.mas_bottom).offset(28);
      make.left.equalTo(splitView5).offset(5);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label6 withName:@"就读国际学校"];

    UIImageView *nextStep6 = [UIImageView new];
    [contentView1 addSubview:nextStep6];
    [nextStep6 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label6.mas_bottom).offset(19);
      make.right.equalTo(label6);
      make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep6 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    internationalSchoolTextField = [UITextField new];
    [contentView1 addSubview:internationalSchoolTextField];
    [internationalSchoolTextField mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label6.mas_bottom).offset(1);
      make.left.equalTo(label6);
      make.right.equalTo(nextStep6.mas_left).offset(-15);
      make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:internationalSchoolTextField withTag:6];
    [internationalSchoolTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIView *splitView6 = [UIView new];
    [contentView1 addSubview:splitView6];
    [splitView6 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(internationalSchoolTextField.mas_bottom).offset(1);
      make.left.equalTo(label6).offset(-5);
      make.right.equalTo(label6).offset(5);
      make.height.mas_equalTo(@1);
    }];
    [splitView6 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];


    
    //***** 就读时间 *****//
    UILabel *label7 = [UILabel new];
    [contentView1 addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(splitView6.mas_bottom).offset(28);
      make.left.equalTo(splitView6).offset(5);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label7 withName:@"就读时间"];

    UIImageView *nextStep7 = [UIImageView new];
    [contentView1 addSubview:nextStep7];
    [nextStep7 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label7.mas_bottom).offset(15);
      make.right.equalTo(label7);
      make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep7 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    internationalDateTextField1 = [UITextField new];
    [contentView1 addSubview:internationalDateTextField1];
    [internationalDateTextField1 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label7.mas_bottom).offset(10);
      make.left.equalTo(label7);
      make.right.equalTo(nextStep7.mas_left).offset(-15);
      make.height.equalTo(@30);
    }];
    [self setTextFieldStyle:internationalDateTextField1 withTag:7];
    internationalDateTextField1.placeholder = @"请选择时间";
    [internationalDateTextField1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIImageView *nextStep8 = [UIImageView new];
    [contentView1 addSubview:nextStep8];
    [nextStep8 mas_makeConstraints:^(MASConstraintMaker *make){
     make.top.equalTo(internationalDateTextField1.mas_bottom).offset(15);
     make.right.equalTo(label7);
     make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep8 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    internationalDateTextField2 = [UITextField new];
    [contentView1 addSubview:internationalDateTextField2];
    [internationalDateTextField2 mas_makeConstraints:^(MASConstraintMaker *make){
     make.top.equalTo(internationalDateTextField1.mas_bottom).offset(10);
     make.left.equalTo(label7);
     make.right.equalTo(nextStep7.mas_left).offset(-15);
     make.height.equalTo(@30);
    }];
    [self setTextFieldStyle:internationalDateTextField2 withTag:8];
    internationalDateTextField2.placeholder = @"请选择季节班";
    [internationalDateTextField2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    //GPA视图
    UIView *gpaView = [UIView new];
    [contentView addSubview:gpaView];
    [gpaView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView1.mas_bottom).offset(20);
        make.left.equalTo(contentView1);
        make.right.equalTo(contentView1);
        make.height.mas_equalTo(@(60));
    }];
    gpaView.backgroundColor = [UIColor whiteColor];
    gpaView.layer.cornerRadius = 10;
    gpaView.layer.masksToBounds = YES;
    
    UILabel *label8 = [UILabel new];
    [gpaView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(gpaView).offset(10);
        make.left.equalTo(gpaView).offset(10);
        make.width.mas_equalTo(@(40));
        make.height.mas_equalTo(@(40));
    }];
    label8.text = @"GPA:";
    
    gpaTextField = [UITextField new];
    [gpaView addSubview:gpaTextField];
    [gpaTextField mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(gpaView).offset(10);
      make.left.equalTo(label8.mas_right).offset(10);
      make.right.equalTo(gpaView).offset(15);
      make.height.equalTo(@40);
    }];
    [self setTextFieldStyle:gpaTextField withTag:9];
    [gpaTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    splitView7 = [UIView new];
    [gpaView addSubview:splitView7];
    [splitView7 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(gpaTextField.mas_bottom);
      make.left.equalTo(gpaTextField);
      make.right.equalTo(gpaTextField).offset(-30);
      make.height.mas_equalTo(@1);
    }];
    [splitView7 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    
    //分数列表
    _scoreTableView = [UITableView new];
    [contentView addSubview:_scoreTableView];
    [_scoreTableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(gpaView.mas_bottom);
        make.left.equalTo(gpaView);
        make.right.equalTo(gpaView);
        make.height.mas_equalTo(@(K_NumberOfSections * (K_ScoreTableView_CellHeight + K_HeightForHeaderInSection))); // 6*(114 + 20)
    }];
    [_scoreTableView setBackgroundColor:[UIColor clearColor]];
    
    _scoreTableView.bounces = NO;
    _scoreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scoreTableView registerClass:[MineAddOfferScoreTableViewCell class] forCellReuseIdentifier:@"MineAddOfferScoreTableViewCell"];
    _scoreTableView.delegate = self;
    _scoreTableView.dataSource = self;
    _scoreTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _scoreTableView.showsVerticalScrollIndicator = NO;
    _scoreTableView.layer.cornerRadius = 10;
    _scoreTableView.scrollEnabled = NO;
    
    
    
    //上传offer
    UIView *uploadOfferView = [UIView new];
    [contentView addSubview:uploadOfferView];
    [uploadOfferView mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(_scoreTableView.mas_bottom).offset(20);
       make.left.equalTo(_scoreTableView);
       make.right.equalTo(_scoreTableView);
       make.height.mas_equalTo(@(150));
    }];
    uploadOfferView.backgroundColor = [UIColor whiteColor];
    uploadOfferView.layer.cornerRadius = 10;
    uploadOfferView.layer.masksToBounds = YES;

    UILabel *label9 = [UILabel new];
    [uploadOfferView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(uploadOfferView).offset(10);
       make.left.equalTo(uploadOfferView).offset(10);
       make.width.mas_equalTo(@(80));
       make.height.mas_equalTo(@(40));
    }];
    label9.text = @"上传Offer";
    
    uploadOfferButton = [UIButton new];
    [uploadOfferView addSubview:uploadOfferButton];
    [uploadOfferButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label9.mas_bottom).offset(10);
        make.left.equalTo(label9);
        make.size.mas_equalTo(CGSizeMake(78, 78));
    }];
    [uploadOfferButton setImage:[UIImage imageNamed:@"mine_upload_file"] forState:UIControlStateNormal];
    [uploadOfferButton setAdjustsImageWhenHighlighted:NO];
    [uploadOfferButton addTarget:self action:@selector(uploadOffer) forControlEvents:UIControlEventTouchUpInside];

    
    //内容
    contentTextView = [UITextView new];
    [contentView addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uploadOfferView.mas_bottom).offset(10);
        make.left.equalTo(uploadOfferView);
        make.right.equalTo(uploadOfferView);
        make.height.mas_equalTo(@(120));
    }];
    // contentTextView 占位符
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"您可以在这里输入内容...";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [contentTextView addSubview:placeHolderLabel];
    placeHolderLabel.font = contentTextView.font;
    [contentTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    contentTextView.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0].CGColor;
    contentTextView.layer.cornerRadius = 8;
    [contentTextView setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
    [contentTextView setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    contentTextView.delegate = self;
}

#pragma mark - 设置参数 -
-(void)setData
{
    for (int i = 0; i < 6; i++) {
        MineResultModel *model = [MineResultModel new];
        if (i == 0) {
            //TOEF
            model.examType = @"TOEFL";
            model.scoreATitle = @"L";
            model.scoreBTitle = @"S";
            model.scoreCTitle = @"R";
            model.scoreDTitle = @"W";
            model.totalScoreTitle = @"总分";
        } else if (i == 1) {
            //IELTS
            model.examType = @"IELTS";
            model.scoreATitle = @"L";
            model.scoreBTitle = @"S";
            model.scoreCTitle = @"R";
            model.scoreDTitle = @"W";
        } else if (i == 2) {
            //GRE
            model.examType = @"GRE";
            model.scoreATitle = @"L";
            model.scoreBTitle = @"Q";
            model.scoreCTitle = @"AW";
        } else if (i == 3) {
            //GMAT
            model.examType = @"GMAT";
            model.scoreATitle = @"V";
            model.scoreBTitle = @"Q";
            model.scoreCTitle = @"AW";
            model.scoreDTitle = @"IR";
        } else if (i == 4) {
            //SAT
            model.examType = @"SAT";
            model.scoreATitle = @"EBRW";
            model.scoreBTitle = @"M";
            model.scoreCTitle = @"ER";
            model.scoreDTitle = @"EA";
            model.scoreETitle = @"EW";
        } else if (i == 5) {
            //ACT
            model.examType = @"ACT";
            model.scoreATitle = @"R";
            model.scoreBTitle = @"E";
            model.scoreCTitle = @"M";
            model.scoreDTitle = @"S";
            model.scoreETitle = @"W";
        }
        
        [self.scoreArray addObject:model];
    }
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return K_ScoreTableView_CellHeight;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return K_NumberOfSections;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineAddOfferScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAddOfferScoreTableViewCell"];

    [cell updateCellWithModel:self.scoreArray[indexPath.section]];

    cell.indexPathSection = indexPath.section;

    cell.delegate = self;
    
    return cell;
}

#pragma mark - 设置header高度 -
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return K_HeightForHeaderInSection;
}

#pragma mark - 设置header样式 -
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - 点击cell -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"123");
}

//**********    tableView代理 end   **********//


#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    if (!companyName.length) {
        [AvalonsoftToast showWithMessage:@"公司名称不能为空！"];
    } else if (!location.length) {
        [AvalonsoftToast showWithMessage:@"公司所在地不能为空！"];
    } else if (!position.length) {
        [AvalonsoftToast showWithMessage:@"职位不能为空！"];
    } else if (!startDate.length) {
        [AvalonsoftToast showWithMessage:@"开始时间不能为空！"];
    } else if (!endDate.length) {
        [AvalonsoftToast showWithMessage:@"结束时间不能为空！"];
    } else if (!Description.length) {
        [AvalonsoftToast showWithMessage:@"活动描述不能为空！"];
    } else {
        [self saveMineAddWorkList];
    }
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSInteger tfTag = textField.tag - TEXTFIELD_TAG;
    
    switch (tfTag) {
        case 1: {
            [self resignFirstResponderForTextFields];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"澳洲", @"加拿大", @"爱尔兰", @"新西兰", @"新加坡", @"英国", @"美国", @"其他欧洲国家", @"其他亚洲国家与地区", @"其他"] DefaultSelValue:@"澳洲" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
             __strong typeof(weakSelf) strongSelf = weakSelf;

             strongSelf->country = selectValue;
             strongSelf->countryTextField.text = selectValue;
            }];
        }
            break;
        
        case 2:
        case 4:
        case 5:
        case 6: {
            return YES;
        }
            break;
        
        case 3: {
            [self resignFirstResponderForTextFields];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"文凭/本科：普通 UnderGraduate(University)", @"文凭/本科:艺术 UnderGraduate(Art school)", @"研究生:普通 Graduate(University)", @"研究生:艺术 Graduate(Art school)", @"MBA:普通 MBA(University)", @"MBA:艺术 MBA(Art school)"] DefaultSelValue:@"文凭/本科：普通 UnderGraduate(University)" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
            __strong typeof(weakSelf) strongSelf = weakSelf;

            strongSelf->studyStage = selectValue;
            strongSelf->studyStageTextField.text = selectValue;
            }];
        }
            break;
            
        case 7: {
            [self resignFirstResponderForTextFields];
            
            NSDate *now = [NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *nowStr = [fmt stringFromDate:now];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                strongSelf->internationalDate1 = selectValue;
                strongSelf->internationalDateTextField1.text = selectValue;
            }];
        }
            break;
            
        case 8: {
            [self resignFirstResponderForTextFields];

            AvalonsoftActionSheet *actionSheet = [[AvalonsoftActionSheet alloc] initSheetWithTitle:@"" style:AvalonsoftSheetStyleDefault itemTitles:@[@"春季班",@"秋季班"]];
            actionSheet.itemTextColor = RGBA_GGCOLOR(102, 102, 102, 1);

            __weak typeof(self) weakSelf = self;
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                __strong typeof(weakSelf) strongSelf = weakSelf;

                strongSelf->internationalDate2 = title;
                strongSelf->internationalDateTextField2.text = title;
            }];
        }
            break;

        case 9: {
            self->splitView7.hidden = NO;
            return YES;
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

#pragma mark - 输入框监听 -
- (void)textFieldDidChange:(UITextField*) sender {
    NSInteger tfTag = sender.tag - TEXTFIELD_TAG;
    switch (tfTag) {
        case 1: {
            companyName = sender.text;
        }
            break;

        case 2: {
            location = sender.text;
        }
            break;
            
        case 3: {
            position = sender.text;
        }
            break;
                    
        default:
            break;
    }
}

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [self resignFirstResponderForTextFields];
}

- (void)textViewDidChange:(UITextView *)textView
{
    Description = textView.text;
}

- (void)resignFirstResponderForTextFields
{
    self->splitView7.hidden = YES;

    [schoolTextField resignFirstResponder];
    [majorTextField resignFirstResponder];
    [agentCompanyTextField resignFirstResponder];
    [internationalSchoolTextField resignFirstResponder];
    [gpaTextField resignFirstResponder];
}

#pragma mark - 网络请求
- (void)saveMineAddWorkList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:strongSelf->companyName forKey:@"companyName"];
            [root setValue:strongSelf->location forKey:@"location"];
            [root setValue:strongSelf->position forKey:@"position"];
            [root setValue:strongSelf->startDate forKey:@"workStartDate"];
            [root setValue:strongSelf->endDate forKey:@"workEndDate"];
            [root setValue:strongSelf->Description forKey:@"description"];

            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_WORK_ADD method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
                        strongSelf.sendValueBlock(sendDic);
                        
                        //保存成功
                        [AvalonsoftToast showWithMessage:@"保存成功" image:@"login_success" duration:1];
                        [strongSelf.navigationController popViewControllerAnimated:YES];
                    }
                } @catch (NSException *exception) {
                    @throw exception;
                    //给出提示信息
                    [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }];
            
        } else {
            //没网
            //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}


#pragma mark - 上传图片
- (void)uploadOffer
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (image) {
            [strongSelf->uploadOfferButton setImage:image forState:UIControlStateNormal];
        }
    }];
}

#pragma mark - MineSelectButtonDelegate
- (void)actionOfSelect
{
    MineSelectOfferViewController *selectVC = [MineSelectOfferViewController new];
    [self.navigationController pushViewController:selectVC animated:YES];
}


- (void)actionOfShow
{
    MineResultShowViewController *showVC = [MineResultShowViewController new];
    MineResultModel *model = [MineResultModel new];
    model.examType = @"TOEFL";
    showVC.model = model;
    [self.navigationController pushViewController:showVC animated:YES];


    __weak typeof(self) weakSelf = self;
    [showVC setSendValueBlock:^(MineResultModel *model){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
//        [strongSelf queryMineExamScoreList];
    }];
}
@end





//-(void)resetSize
//{
//    CGFloat scoreTableViewHeight = 0;
//    if(self.scoreArray.count != 0){
//        scoreTableViewHeight = K_ScoreTableView_CellHeight*self.scoreArray.count + 10*self.scoreArray.count;
//    }
//
//    [_scoreTableView mas_updateConstraints:^(MASConstraintMaker *make){
//        make.height.mas_equalTo(@(scoreTableViewHeight));
//    }];
//
//    //设置内容视图尺寸
//    [contentView setContentSize:CGSizeMake(SCREEN_WIDTH, 10 + 6*K_DetailTableView_CellHeight + 10 + 42 + scoreTableViewHeight + 10 + 150 + 250)];
//
//}



