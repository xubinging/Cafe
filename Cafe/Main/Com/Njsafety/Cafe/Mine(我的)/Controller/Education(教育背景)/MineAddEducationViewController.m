//
//  MineAddEducationViewController.m
//  Cafe
//
//  Created by migu on 2020/5/23.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineAddEducationViewController.h"
#import "AvalonsoftImagePicker.h"
#import "Header.h"

#define TEXTFIELD_TAG 10000

@interface MineAddEducationViewController ()<UITextFieldDelegate>

{
    @private UIButton *backButton;              //左上角返回按钮
    @private UIView *navigationView;
    
    @private UIView *contentView;
    @private UIScrollView *contentScrollView;   //滑动视图
    @private UIButton *saveButton;              //保存按钮
    
    @private UITextField *statusTextField;      //状态
    @private UITextField *levelTextField;       //教育阶段
    @private UITextField *countryTextField;     //国家
    @private UITextField *orgTextField;         //机构
    @private UITextField *startTimeTextField;   //开始时间
    @private UITextField *endTimeTextField;     //结束时间
    @private UITextField *degreeTypeTextField;  //学位类型
    @private UITextField *majorTextField;       //专业
    @private UITextField *gradesTextField;      //成绩
}

@property (nonatomic, assign) NSInteger keyBoardHeight;
@property (nonatomic, strong) UITextField *selectedTextField;

@end

@implementation MineAddEducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self setData];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"添加教育背景"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
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
    
    [self initScrollView];
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
    contentScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
        
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 28, SCREEN_WIDTH - 20 - 30, 20)];
    [contentScrollView addSubview:Label1];
    [self setTitleLabelStyle:Label1 withName:@"状态"];

    UIImageView *nextStep1 = [UIImageView new];
    [contentScrollView addSubview:nextStep1];
    [nextStep1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(Label1.mas_bottom).offset(19);
        make.right.equalTo(Label1);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep1 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    statusTextField = [UITextField new];
    [contentScrollView addSubview:statusTextField];
    [statusTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(Label1.mas_bottom).offset(1);
        make.left.equalTo(Label1);
        make.right.equalTo(nextStep1.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:statusTextField withTag:1];

    UIView *splitView1 = [UIView new];
    [contentScrollView addSubview:splitView1];
    [splitView1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(statusTextField.mas_bottom).offset(1);
        make.left.equalTo(Label1).offset(-5);
        make.right.equalTo(Label1).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [splitView1 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    UILabel *label2 = [UILabel new];
    [contentScrollView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(splitView1.mas_bottom).offset(28);
        make.left.equalTo(splitView1).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label2 withName:@"教育阶段"];

    UIImageView *nextStep2 = [UIImageView new];
    [contentScrollView addSubview:nextStep2];
    [nextStep2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label2.mas_bottom).offset(19);
        make.right.equalTo(label2);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep2 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    levelTextField = [UITextField new];
    [contentScrollView addSubview:levelTextField];
    [levelTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label2.mas_bottom).offset(1);
        make.left.equalTo(label2);
        make.right.equalTo(nextStep2.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:levelTextField withTag:2];

    UIView *splitView2 = [UIView new];
    [contentScrollView addSubview:splitView2];
    [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(levelTextField.mas_bottom).offset(1);
        make.left.equalTo(label2).offset(-5);
        make.right.equalTo(label2).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [splitView2 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    
    UILabel *label3 = [UILabel new];
    [contentScrollView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(splitView2.mas_bottom).offset(28);
        make.left.equalTo(splitView2).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label3 withName:@"国家"];

    UIImageView *nextStep3 = [UIImageView new];
    [contentScrollView addSubview:nextStep3];
    [nextStep3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label3.mas_bottom).offset(19);
        make.right.equalTo(label3);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep3 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    countryTextField = [UITextField new];
    [contentScrollView addSubview:countryTextField];
    [countryTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label3.mas_bottom).offset(1);
        make.left.equalTo(label3);
        make.right.equalTo(nextStep3.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:countryTextField withTag:3];

    UIView *splitView3 = [UIView new];
    [contentScrollView addSubview:splitView3];
    [splitView3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryTextField.mas_bottom).offset(1);
        make.left.equalTo(label3).offset(-5);
        make.right.equalTo(label3).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [splitView3 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];

    
    UILabel *label4 = [UILabel new];
    [contentScrollView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(splitView3.mas_bottom).offset(28);
        make.left.equalTo(splitView3).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label4 withName:@"学校/机构名称"];

    UIImageView *nextStep4 = [UIImageView new];
    [contentScrollView addSubview:nextStep4];
    [nextStep4 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label4.mas_bottom).offset(19);
        make.right.equalTo(label4);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep4 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    orgTextField = [UITextField new];
    [contentScrollView addSubview:orgTextField];
    [orgTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(label4.mas_bottom).offset(1);
        make.left.equalTo(label4);
        make.right.equalTo(nextStep4.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:orgTextField withTag:4];
    [orgTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];


    UIView *splitView4 = [UIView new];
    [contentScrollView addSubview:splitView4];
    [splitView4 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(orgTextField.mas_bottom).offset(1);
        make.left.equalTo(label4).offset(-5);
        make.right.equalTo(label4).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [splitView4 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];

    
    
    UILabel *label5 = [UILabel new];
    [contentScrollView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(splitView4.mas_bottom).offset(28);
       make.left.equalTo(splitView4).offset(5);
       make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label5 withName:@"开始时间"];

    UIImageView *nextStep5 = [UIImageView new];
    [contentScrollView addSubview:nextStep5];
    [nextStep5 mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(label5.mas_bottom).offset(19);
       make.right.equalTo(label5);
       make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep5 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    startTimeTextField = [UITextField new];
    [contentScrollView addSubview:startTimeTextField];
    [startTimeTextField mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(label5.mas_bottom).offset(1);
       make.left.equalTo(label5);
       make.right.equalTo(nextStep5.mas_left).offset(-15);
       make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:startTimeTextField withTag:5];

    UIView *splitView5 = [UIView new];
    [contentScrollView addSubview:splitView5];
    [splitView5 mas_makeConstraints:^(MASConstraintMaker *make){
       make.top.equalTo(startTimeTextField.mas_bottom).offset(1);
       make.left.equalTo(label5).offset(-5);
       make.right.equalTo(label5).offset(5);
       make.height.mas_equalTo(@1);
    }];
    [splitView5 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    UILabel *label6 = [UILabel new];
    [contentScrollView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(splitView5.mas_bottom).offset(28);
      make.left.equalTo(splitView5).offset(5);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label6 withName:@"结束时间"];

    UIImageView *nextStep6 = [UIImageView new];
    [contentScrollView addSubview:nextStep6];
    [nextStep6 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label6.mas_bottom).offset(19);
      make.right.equalTo(label6);
      make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep6 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    endTimeTextField = [UITextField new];
    [contentScrollView addSubview:endTimeTextField];
    [endTimeTextField mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label6.mas_bottom).offset(1);
      make.left.equalTo(label6);
      make.right.equalTo(nextStep6.mas_left).offset(-15);
      make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:endTimeTextField withTag:6];

    UIView *splitView6 = [UIView new];
    [contentScrollView addSubview:splitView6];
    [splitView6 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(endTimeTextField.mas_bottom).offset(1);
      make.left.equalTo(label6).offset(-5);
      make.right.equalTo(label6).offset(5);
      make.height.mas_equalTo(@1);
    }];
    [splitView6 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    
    UILabel *label7 = [UILabel new];
    [contentScrollView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(splitView6.mas_bottom).offset(28);
      make.left.equalTo(splitView6).offset(5);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label7 withName:@"学位类型"];

    UIImageView *nextStep7 = [UIImageView new];
    [contentScrollView addSubview:nextStep7];
    [nextStep7 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label7.mas_bottom).offset(19);
      make.right.equalTo(label7);
      make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep7 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    degreeTypeTextField = [UITextField new];
    [contentScrollView addSubview:degreeTypeTextField];
    [degreeTypeTextField mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label7.mas_bottom).offset(1);
      make.left.equalTo(label7);
      make.right.equalTo(nextStep7.mas_left).offset(-15);
      make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:degreeTypeTextField withTag:7];

    UIView *splitView7 = [UIView new];
    [contentScrollView addSubview:splitView7];
    [splitView7 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(degreeTypeTextField.mas_bottom).offset(1);
      make.left.equalTo(label7).offset(-5);
      make.right.equalTo(label7).offset(5);
      make.height.mas_equalTo(@1);
    }];
    [splitView7 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    UILabel *label8 = [UILabel new];
    [contentScrollView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(splitView7.mas_bottom).offset(28);
      make.left.equalTo(splitView7).offset(5);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label8 withName:@"专业"];

    UIImageView *nextStep8 = [UIImageView new];
    [contentScrollView addSubview:nextStep8];
    [nextStep8 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label8.mas_bottom).offset(19);
      make.right.equalTo(label8);
      make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep8 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    majorTextField = [UITextField new];
    [contentScrollView addSubview:majorTextField];
    [majorTextField mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label8.mas_bottom).offset(1);
      make.left.equalTo(label8);
      make.right.equalTo(nextStep8.mas_left).offset(-15);
      make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:majorTextField withTag:8];

    UIView *splitView8 = [UIView new];
    [contentScrollView addSubview:splitView8];
    [splitView8 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(majorTextField.mas_bottom).offset(1);
      make.left.equalTo(label8).offset(-5);
      make.right.equalTo(label8).offset(5);
      make.height.mas_equalTo(@1);
    }];
    [splitView8 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];

    
    
    UILabel *label9 = [UILabel new];
    [contentScrollView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(splitView8.mas_bottom).offset(28);
      make.left.equalTo(splitView8).offset(5);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:label9 withName:@"成绩"];

    UIImageView *nextStep9 = [UIImageView new];
    [contentScrollView addSubview:nextStep9];
    [nextStep9 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label9.mas_bottom).offset(19);
      make.right.equalTo(label9);
      make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nextStep9 setImage:[UIImage imageNamed:@"mine_nextstep"]];

    gradesTextField = [UITextField new];
    [contentScrollView addSubview:gradesTextField];
    [gradesTextField mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(label9.mas_bottom).offset(1);
      make.left.equalTo(label9);
      make.right.equalTo(nextStep9.mas_left).offset(-15);
      make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:gradesTextField withTag:9];
    [gradesTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];


    UIView *splitView9 = [UIView new];
    [contentScrollView addSubview:splitView9];
    [splitView9 mas_makeConstraints:^(MASConstraintMaker *make){
      make.top.equalTo(gradesTextField.mas_bottom).offset(1);
      make.left.equalTo(label9).offset(-5);
      make.right.equalTo(label9).offset(5);
      make.height.mas_equalTo(@1);
    }];
    [splitView9 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
}


#pragma mark - 设置参数 -
-(void)setData
{
    statusTextField.text = self.model.status;
    levelTextField.text = self.model.level;
    countryTextField.text = self.model.country;
    orgTextField.text = self.model.institutionName;
    startTimeTextField.text = self.model.startTime;
    endTimeTextField.text = self.model.graduationDate;
    degreeTypeTextField.text = self.model.degreeType;
    majorTextField.text = self.model.major;
    gradesTextField.text = self.model.grades;
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    if ([self.model.actionType isEqualToString:@"add"]) {
        [self saveMineEducation];

    } else if ([self.model.actionType isEqualToString:@"edit"]) {
        [self editMineEducation];
    }
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    NSInteger tfTag = textField.tag - TEXTFIELD_TAG;
    
    switch (tfTag) {
        case 4:
        case 9: {
            return YES;
        }
            break;
        
        case 1: {
            [self resignFirstResponderForTextField];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"在读 CURRENTLY STUDYING",@"毕业 GRADUATED"] DefaultSelValue:@"在读 CURRENTLY STUDYING" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
                __strong typeof(weakSelf) strongSelf = weakSelf;

                strongSelf.model.status = selectValue;
                strongSelf->statusTextField.text = selectValue;
            }];
        }
            break;
            
        case 2: {
            [self resignFirstResponderForTextField];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"中学",@"国际学校",@"本科（语言/预科）",@"研究生（语言/预科）",@"合作办学",@"普通（文凭/文科）",@"艺术（文凭/文科）",@"普通（研究生）",@"艺术（研究生）",@"普通（MBA）",@"艺术（MBA）"] DefaultSelValue:@"中学" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
                __strong typeof(weakSelf) strongSelf = weakSelf;

                strongSelf.model.level = selectValue;
                strongSelf->levelTextField.text = selectValue;
            }];
        }
            break;
            
        case 3: {
            [self resignFirstResponderForTextField];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"澳洲", @"加拿大", @"爱尔兰", @"新西兰", @"新加坡", @"英国", @"美国", @"其他欧洲国家", @"其他亚洲国家与地区", @"其他"] DefaultSelValue:@"澳洲" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
                __strong typeof(weakSelf) strongSelf = weakSelf;

                strongSelf.model.country = selectValue;
                strongSelf->countryTextField.text = selectValue;
            }];
        }
            break;
            
        case 5: {
           [self resignFirstResponderForTextField];
           
           NSDate *now = [NSDate date];
           NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
           fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
           NSString *nowStr = [fmt stringFromDate:now];

           __weak typeof(self) weakSelf = self;
           [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
               __strong typeof(weakSelf) strongSelf = weakSelf;
               
               strongSelf.model.startTime = selectValue;
               strongSelf->startTimeTextField.text = selectValue;
           }];
        }
            break;
        
        case 6: {
            [self resignFirstResponderForTextField];
            
            NSDate *now = [NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *nowStr = [fmt stringFromDate:now];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                strongSelf.model.graduationDate = selectValue;
                strongSelf->endTimeTextField.text = selectValue;
            }];
        }
            break;
            
        case 7: {
            [self resignFirstResponderForTextField];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"Dip.", @"A.S.", @"A.A.", @"B.A.", @"B.S. or B.Sc", @"LLB", @"BEng or BE", @"BEd", @"BArch", @"BBA", @"BComm", @"BFA"] DefaultSelValue:@"Dip." IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
                __strong typeof(weakSelf) strongSelf = weakSelf;

                strongSelf.model.degreeType = selectValue;
                strongSelf->degreeTypeTextField.text = selectValue;
            }];
        }
            break;

        case 8: {
            [self resignFirstResponderForTextField];

            //TODO:xubing 需要通过接口，拿到专业类型，再展示
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
        case 4: {
            self.model.institutionName = sender.text;
            orgTextField.text = self.model.institutionName;
        }
            break;
            
        case 9: {
            self.model.grades = sender.text;
            gradesTextField.text = self.model.grades;
        }
            break;
                    
        default:
            break;
    }
}

- (void)resignFirstResponderForTextField
{
    [orgTextField resignFirstResponder];
    [gradesTextField resignFirstResponder];
}


#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [self resignFirstResponderForTextField];
}


#pragma mark - 网络请求
- (void)saveMineEducation
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:strongSelf.model.addTime forKey:@"addTime"];
            [root setValue:strongSelf.model.country forKey:@"country"];
            [root setValue:strongSelf.model.countryName forKey:@"countryName"];
            [root setValue:strongSelf.model.countryNameEn forKey:@"countryNameEn"];
            [root setValue:strongSelf.model.degreeType forKey:@"degreeType"];
            [root setValue:strongSelf.model.displayHome forKey:@"displayHome"];
            [root setValue:strongSelf.model.examType forKey:@"examType"];
            [root setValue:strongSelf.model.graduationDate forKey:@"graduationDate"];
            [root setValue:strongSelf.model.ID forKey:@"id"];
            [root setValue:strongSelf.model.highSchoolId forKey:@"highSchoolId"];
            [root setValue:strongSelf.model.insId forKey:@"insId"];
            [root setValue:strongSelf.model.institutionName forKey:@"institutionName"];
            [root setValue:strongSelf.model.level forKey:@"level"];
            [root setValue:strongSelf.model.major forKey:@"major"];
            [root setValue:strongSelf.model.otherCountry forKey:@"otherCountry"];
            [root setValue:@"false" forKey:@"showSchool"]; 
            [root setValue:strongSelf.model.startTime forKey:@"startDate"];
            [root setValue:strongSelf.model.status forKey:@"status"];
            [root setValue:strongSelf.model.universityId forKey:@"universityId"];
            [root setValue:strongSelf.model.grades forKey:@"grades"];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EDUCATION_ADD method:HttpRequestPost paramenters:root prepareExecute:^{

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);

                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        MineEducationModel *model = [MineEducationModel modelWithDict:rspData];

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


- (void)editMineEducation
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:strongSelf.model.addTime forKey:@"addTime"];
            [root setValue:strongSelf.model.country forKey:@"country"];
            [root setValue:strongSelf.model.countryName forKey:@"countryName"];
            [root setValue:strongSelf.model.countryNameEn forKey:@"countryNameEn"];
            [root setValue:strongSelf.model.degreeType forKey:@"degreeType"];
            [root setValue:strongSelf.model.displayHome forKey:@"displayHome"];
            [root setValue:strongSelf.model.examType forKey:@"examType"];
            [root setValue:strongSelf.model.graduationDate forKey:@"graduationDate"];
            [root setValue:strongSelf.model.ID forKey:@"id"];
            [root setValue:strongSelf.model.highSchoolId forKey:@"highSchoolId"];
            [root setValue:strongSelf.model.insId forKey:@"insId"];
            [root setValue:strongSelf.model.institutionName forKey:@"institutionName"];
            [root setValue:strongSelf.model.level forKey:@"level"];
            [root setValue:strongSelf.model.major forKey:@"major"];
            [root setValue:strongSelf.model.otherCountry forKey:@"otherCountry"];
            [root setValue:@"false" forKey:@"showSchool"];
            [root setValue:strongSelf.model.startTime forKey:@"startDate"];
            [root setValue:strongSelf.model.status forKey:@"status"];
            [root setValue:strongSelf.model.universityId forKey:@"universityId"];
            [root setValue:strongSelf.model.grades forKey:@"grades"];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EDUCATION_UPDATE method:HttpRequestPost paramenters:root prepareExecute:^{

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);

                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        MineEducationModel *model = [MineEducationModel modelWithDict:rspData];

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


#pragma mark  键盘出现时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyBoardHeight = keyboardRect.size.height;
    //注意下句代码，为了避免键盘第一次出现时，输入框的位置不发生改变
    [self textFieldDidBeginEditing:self.selectedTextField];
}

#pragma mark 改变输入框的坐标
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.selectedTextField = textField;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = -(self.keyBoardHeight);
        self.view.frame = frame;
    }];
}

#pragma mark 恢复输入框的位置

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
