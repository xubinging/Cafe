//
//  SecurityModifyPhoneVC.m
//  Cafe
//
//  Created by leo on 2020/1/2.
//  Copyright © 2020 leo. All rights reserved.
//
//  更换手机号

#import "SecurityModifyPhoneVC.h"

#import "AvalonsoftCountryCodeController.h" //国家代码选择

#define K_CODETIME 60      //验证码时间

@interface SecurityModifyPhoneVC ()<UITextFieldDelegate,AvalonsoftCountryCodeControllerDelegate>

{
    @private UIButton *backButton;              //左上角返回按钮
    @private UIView *navigationView;
    
    @private UILabel *phoneExplainLabel1;       //说明文字1
    @private UILabel *phoneExplainLabel2;       //说明文字2
    
    @private UIView *countryView;               //国家和地区
    @private UILabel *countryLabel;
    
    @private UIView *phoneView;                 //手机号视图
    @private UILabel *phonePrefixLabel;         //手机号前缀
    @private UITextField *phoneTextField;       //手机号输入框
    
    @private UIView *CodeView;                  //验证码视图
    @private UITextField *codeTextField;        //验证码输入框
    @private UIButton *getValidCodeButton;      //获取验证码按钮
    
    @private UIView *submitView;                //提交
    @private UIView *clickableSubmitView;       //可点击提交
    
    @private NSString *phoneStr;                //手机号
    
}

//验证码相关
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@end

@implementation SecurityModifyPhoneVC

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
    phoneStr = _UserInfo.phoneNumber;
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
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-120)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"更换手机号" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
}

#pragma mark - 初始化视图 -
-(void)initView
{
    phoneExplainLabel1 = [UILabel new];
    [self.view addSubview:phoneExplainLabel1];
    [phoneExplainLabel1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(25);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 24));
    }];
    [phoneExplainLabel1 setTextAlignment:NSTextAlignmentCenter];
    
    phoneExplainLabel2 = [UILabel new];
    [self.view addSubview:phoneExplainLabel2];
    [phoneExplainLabel2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneExplainLabel1.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 24));
    }];
    [phoneExplainLabel2 setTextAlignment:NSTextAlignmentCenter];
    NSMutableAttributedString *phoneExplainLabel2String = [[NSMutableAttributedString alloc] initWithString:@"请输入您当前使用的新手机号" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    phoneExplainLabel2.attributedText = phoneExplainLabel2String;
    
    
    //***** 国家和地区 *****//
    countryView = [UIView new];
    [self.view addSubview:countryView];
    [countryView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneExplainLabel2.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 320)/2);
        make.size.mas_equalTo(CGSizeMake(320, 46));
    }];
    countryView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    countryView.layer.cornerRadius = 23;
    
    UILabel *countryTitleLabel = [UILabel new];
    [countryView addSubview:countryTitleLabel];
    [countryTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryView).offset(12);
        make.left.equalTo(countryView).offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 22));
    }];
    countryTitleLabel.numberOfLines = 0;
    countryTitleLabel.textAlignment = NSTextAlignmentLeft;
    countryTitleLabel.alpha = 1.0;
    NSMutableAttributedString *countryTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"国家和地区"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    countryTitleLabel.attributedText = countryTitleLabelString;
    
    UIImageView *nextStep = [UIImageView new];
    [countryView addSubview:nextStep];
    [nextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryView).offset(17);
        make.right.equalTo(countryView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [nextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    countryLabel = [UILabel new];
    [countryView addSubview:countryLabel];
    [countryLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryView).offset(12);
        make.right.equalTo(nextStep.mas_left).offset(-10);
        make.left.equalTo(countryTitleLabel.mas_right).offset(10);
        make.height.mas_equalTo(@22);
    }];
    countryLabel.numberOfLines = 0;
    countryLabel.textAlignment = NSTextAlignmentRight;
    countryLabel.alpha = 1.0;
    [countryLabel setTextColor:RGBA_GGCOLOR(34, 34, 34, 1)];
    [countryLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    
    //***** 手机号视图 *****//
    phoneView = [UIView new];
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 320)/2);
        make.size.mas_equalTo(CGSizeMake(320, 46));
    }];
    phoneView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    phoneView.layer.cornerRadius = 23;
    
    phonePrefixLabel = [UILabel new];
    [phoneView addSubview:phonePrefixLabel];
    [phonePrefixLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneView).offset(12);
        make.left.equalTo(phoneView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 22));
    }];
    phonePrefixLabel.numberOfLines = 0;
    phonePrefixLabel.textAlignment = NSTextAlignmentLeft;
    phonePrefixLabel.alpha = 1.0;
    [phonePrefixLabel setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [phonePrefixLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];

    phoneTextField = [UITextField new];
    [phoneView addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneView).offset(12);
        make.left.equalTo(phonePrefixLabel.mas_right).offset(15);
        make.right.equalTo(phoneView).offset(-15);
        make.height.equalTo(@22);
    }];
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [phoneTextField setTextAlignment:NSTextAlignmentLeft];
    phoneTextField.clearButtonMode = UITextFieldViewModeNever;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *phonePlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"手机号"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    phoneTextField.attributedPlaceholder = phonePlaceholderString;
    //设置输入后文字样式
    [phoneTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [phoneTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    
    //***** 验证码 *****//
    CodeView = [UIView new];
    [self.view addSubview:CodeView];
    [CodeView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-320)/2);
        make.size.mas_equalTo(CGSizeMake(320, 46));
    }];
    
    //获取验证码按钮
    getValidCodeButton = [UIButton new];
    [CodeView addSubview:getValidCodeButton];
    [getValidCodeButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(CodeView);
        make.right.equalTo(CodeView);
        make.size.mas_equalTo(CGSizeMake(120, 46));
    }];
    [getValidCodeButton setBackgroundColor:RGBA_GGCOLOR(32, 188, 255, 1.0)];
    getValidCodeButton.layer.cornerRadius=23;
    //设置点击不变色
    getValidCodeButton.adjustsImageWhenHighlighted = NO;
    NSMutableAttributedString *getValidCodeButtonString = [[NSMutableAttributedString alloc] initWithString:@"获取验证码"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    [getValidCodeButton setAttributedTitle:getValidCodeButtonString forState:UIControlStateNormal];
    
    //验证码输入视图
    UIView *codeInputView = [UIView new];
    [CodeView addSubview:codeInputView];
    [codeInputView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(CodeView);
        make.left.equalTo(CodeView);
        make.right.equalTo(getValidCodeButton.mas_left).offset(-15);
        make.height.equalTo(@46);
    }];
    codeInputView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    codeInputView.layer.cornerRadius = 23;
    
    //验证码输入框
    codeTextField = [UITextField new];
    [codeInputView addSubview:codeTextField];
    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(codeInputView);
        make.left.equalTo(codeInputView).offset(20);
        make.right.equalTo(codeInputView).offset(-20);
        make.height.equalTo(@46);
    }];
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [codeTextField setTextAlignment:NSTextAlignmentLeft];
    codeTextField.clearButtonMode = UITextFieldViewModeNever;
    codeTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *codePlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"验证码"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    codeTextField.attributedPlaceholder = codePlaceholderString;
    //设置输入后文字样式
    [codeTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [codeTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];

    //10.提交视图
    submitView = [UIView new];
    [self.view addSubview:submitView];
    [submitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(CodeView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-355)/2);
        make.size.mas_equalTo(CGSizeMake(355, 46));
    }];
    submitView.layer.backgroundColor = [UIColor colorWithRed:158/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
    submitView.layer.cornerRadius = 23;
    
    //10-1.提交 文字标签
    UILabel *submitLabel = [UILabel new];
    [submitView addSubview:submitLabel];
    [submitLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(submitView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-32)/2);
        make.size.mas_equalTo(CGSizeMake(32, 22));
    }];
    submitLabel.numberOfLines = 0;
    submitLabel.textAlignment = NSTextAlignmentCenter;
    submitLabel.alpha = 1.0;
    NSMutableAttributedString *submitLabelString = [[NSMutableAttributedString alloc] initWithString:@"提交"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    submitLabel.attributedText = submitLabelString;
    
    //11.可点击的提交按钮，与上面那个位置重叠
    clickableSubmitView = [UIView new];
    [self.view addSubview:clickableSubmitView];
    [clickableSubmitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(CodeView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-355)/2);
        make.size.mas_equalTo(CGSizeMake(355, 46));
    }];
    clickableSubmitView.layer.cornerRadius = 23;
    clickableSubmitView.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.4].CGColor;
    clickableSubmitView.layer.shadowOffset = CGSizeMake(0,4);
    clickableSubmitView.layer.shadowOpacity = 1;
    clickableSubmitView.layer.shadowRadius = 10;
    
    [self.view layoutIfNeeded];
    //CAGradientLayer实现颜色渐变
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = clickableSubmitView.bounds;
    gl.cornerRadius = 23;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [clickableSubmitView.layer addSublayer:gl];
    
    //11-1.提交 文字标签
    UILabel *clickableSubmitLabel = [UILabel new];
    [clickableSubmitView addSubview:clickableSubmitLabel];
    [clickableSubmitLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(clickableSubmitView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-32)/2);
        make.size.mas_equalTo(CGSizeMake(32, 22));
    }];
    clickableSubmitLabel.numberOfLines = 0;
    clickableSubmitLabel.textAlignment = NSTextAlignmentCenter;
    clickableSubmitLabel.alpha = 1.0;
    NSMutableAttributedString *clickableSubmitLabelString = [[NSMutableAttributedString alloc] initWithString:@"提交"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    clickableSubmitLabel.attributedText = clickableSubmitLabelString;
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //国家和地区
    countryLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *countryLabelTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countryLabelClick)];
    [countryLabel addGestureRecognizer:countryLabelTapGesture];
    
    [phoneTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
    
    //手机号文本框监听
    [phoneTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //验证码文本框监听
    [codeTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //获取验证码
    [getValidCodeButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    
    //2个注册视图
    submitView.hidden = NO;
    submitView.userInteractionEnabled = NO;
    clickableSubmitView.hidden = YES;
    clickableSubmitView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *submitViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submitViewClick)];
    //设置需要连续点击几次才响应，默认点击1次
    [submitViewTapGesture setNumberOfTapsRequired:1];
    [clickableSubmitView addGestureRecognizer:submitViewTapGesture];
    
}

#pragma mark - 设置参数 -
-(void)setData
{
    //提示文字
    NSMutableAttributedString *phoneExplainLabel1String = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您的账号目前绑定手机号是%@",phoneStr] attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    
    [phoneExplainLabel1String addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]} range:NSMakeRange(0, 12)];

    [phoneExplainLabel1String addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:80/255.0 blue:63/255.0 alpha:1.0]} range:NSMakeRange(12, [phoneStr length])];
    
    phoneExplainLabel1.attributedText = phoneExplainLabel1String;
    
    //国家和地区
    [countryLabel setText:@"中国大陆"];
    
    //号码前缀
    NSString *phonePrefix = @"+86";
    [phonePrefixLabel setText:phonePrefix];
    CGFloat width = [UILabel getWidthWithText:phonePrefix font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    [phonePrefixLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(width, 22));
    }];
    
}

#pragma mark - 选择国家和地区 -
-(void)countryLabelClick
{
    AvalonsoftCountryCodeController *countryCodeVC = [[AvalonsoftCountryCodeController alloc] init];
    countryCodeVC.deleagete = self;
    [self.navigationController pushViewController:countryCodeVC animated:YES];
}

#pragma mark - AvalonsoftCountryCodeControllerDelegate
- (void)returnCountryName:(NSString *)countryName code:(NSString *)code
{
    //国家和地区
    [countryLabel setText:countryName];
    
    //代码
    NSString *slctCode = [NSString stringWithFormat:@"+%@",code];
    [phonePrefixLabel setText:slctCode];
    CGFloat width = [UILabel getWidthWithText:slctCode font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    [phonePrefixLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(width, 22));
    }];
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 输入框监听 -
-(void)textFieldDidChange
{
    //判断注册按钮是否可点击
    if(![phoneTextField.text isEqualToString:@""] && ![codeTextField.text isEqualToString:@""]){
        
        //注册视图可点击
        submitView.hidden = YES;
        
        clickableSubmitView.hidden = NO;
        
    }else{
        //有一个为空，不可点击
        submitView.hidden = NO;
        
        clickableSubmitView.hidden = YES;
    }
}

#pragma mark - 提交按钮点击事件 -
-(void)submitViewClick
{
    [AvalonsoftToast showWithMessage:@"提交手机号码修改"];
}

#pragma mark - 获取验证码按钮点击事件 -
- (void)getValidCode:(UIButton *)sender
{
    //获取验证码只验证手机号是否输入及其格式是否正确
    NSString *userPhone = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //手机号不可为空
    if([userPhone isEqualToString:@""]){
        [AvalonsoftToast showWithMessage:@"请输入手机号码"];
        return;
    }
    
    //手机格式检查
//    if(![_F validateMobile:userPhone]){
//        [AvalonsoftToast showWithMessage:@"请检查手机号码格式"];
//        return;
//    }
    
    //模拟发送成功
    [AvalonsoftToast showWithMessage:@"发送成功" image:@"login_success"];
    
    //停止交互
    getValidCodeButton.userInteractionEnabled = NO;
    
    //设置秒数
    NSMutableAttributedString *getValidCodeButtonString = [[NSMutableAttributedString alloc] initWithString:@"60s重新获取" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    [getValidCodeButton setAttributedTitle:getValidCodeButtonString forState:UIControlStateNormal];
    //设置背景色
    [getValidCodeButton setBackgroundColor:RGBA_GGCOLOR(188, 234, 255, 1.0)];
    
    //设置计时器
    self.timeCount = K_CODETIME;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:getValidCodeButton repeats:YES];
}

//定时器
- (void)reduceTime:(NSTimer *)codeTimer {
    
    self.timeCount--;
    
    if (self.timeCount == 0) {
        //恢复颜色
        NSMutableAttributedString *getValidCodeButtonString = [[NSMutableAttributedString alloc] initWithString:@"重新获取"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
        [getValidCodeButton setAttributedTitle:getValidCodeButtonString forState:UIControlStateNormal];
        
        [getValidCodeButton setBackgroundColor:RGBA_GGCOLOR(32, 188, 255, 1.0)];

        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        getValidCodeButton.userInteractionEnabled = YES;
        [self.timer invalidate];
        
    } else {
        NSString *str = [NSString stringWithFormat:@"%lds重新获取", (long)self.timeCount];
        NSMutableAttributedString *getValidCodeButtonString = [[NSMutableAttributedString alloc] initWithString:str attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
        [getValidCodeButton setAttributedTitle:getValidCodeButtonString forState:UIControlStateNormal];
        
        getValidCodeButton.userInteractionEnabled = NO;
    }
}

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [phoneTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
}

@end
