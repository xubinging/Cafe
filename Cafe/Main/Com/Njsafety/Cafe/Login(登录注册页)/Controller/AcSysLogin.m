//
//  AcSysLogin.m
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//
//  登录页

#import "AcSysLogin.h"

#import "AcSysRegist.h"                 //注册页面
#import "AcSysFindPsdVerifyPhone.h"     //找回密码 -- 验证手机

#import "MainTabBarViewController.h"    //底部导航布局

#define K_CODETIME 60                    //验证码时间

@interface AcSysLogin ()

{
    @private UIView *navigationView;            //导航
    @private UIButton *backButton;              //左上角返回按钮
    
    @private UILabel *titleLabel;               //图片下的标题
    
    //密码登录视图，一开始显示的
    @private UIView *passwordLoginView;         //密码登录视图
    @private UIView *userView;                  //用户名手机号视图
    @private UIView *passwordView;              //密码视图
    @private UITextField *userInfoTextField;    //用户信息输入框
    @private UITextField *psdTextField;         //用户密码输入框
    @private UIButton *userClearButton;         //清空用户信息按钮
    @private UIButton *showPsdButton;           //切换秘文明文按钮
    
    //快捷登录视图，一开始隐藏的
    @private UIView *quickLoginView;            //快捷登录视图
    @private UIView *phoneView;                 //手机号视图
    @private UIView *CodeView;                  //验证码视图
    @private UITextField *phoneTextField;       //手机号输入框
    @private UITextField *codeTextField;        //验证码输入框
    @private UIButton *getValidCodeButton;      //获取验证码按钮
    
    //其他按钮和视图
    @private UIButton *findPsdButton;           //找回密码按钮
    @private UIButton *quickLoginButton;        //快捷登录按钮
    @private UIView *loginView;                 //登录视图
    @private UIView *clickableLoginView;        //可点击的登录视图
    @private UIView *registView;                //注册视图
    
    //是否明文显示密码，默认为NO
    @private BOOL isShowPsd;
    
    @private AvalonsoftUserDefaultsModel *userDefaultsModel;
}

//验证码相关
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@end

@implementation AcSysLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initTopView];             //初始化顶部视图
    [self initPasswordLoginView];   //密码登录
    [self initQuickLoginView];      //快捷登录
    [self initView];
    [self setListener];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    isShowPsd = NO;
    
    userDefaultsModel = [AvalonsoftUserDefaultsModel userDefaultsModel];
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
    //1.顶部导航视图
    navigationView = [UIView new];
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, NavBarHeight));
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
    [backButton setBackgroundImage:[UIImage imageNamed:@"login_del_back"] forState:UIControlStateNormal];
    
    //标题
    UILabel *titleLabel = [UILabel new];
    [navigationView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH - 100)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"登录" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
    //分割线
    UIView *splitView = [UIView new];
    [navigationView addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(navigationView).offset(-1);
        make.left.right.equalTo(navigationView);
        make.height.equalTo(@1);
    }];
    splitView.layer.backgroundColor = [UIColor colorWithRed:229/255.0 green:237/255.0 blue:240/255.0 alpha:1.0].CGColor;
}

#pragma mark - 初始化顶部视图 -
-(void)initTopView
{
    //图片
    UIImageView *loginIcon = [UIImageView new];
    [self.view addSubview:loginIcon];
    [loginIcon mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 80)/2);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [loginIcon setImage:[UIImage imageNamed:@"login_icon"]];
    
    //标签
    titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(loginIcon.mas_bottom).offset(-5);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 120)/2);
        make.size.mas_equalTo(CGSizeMake(120, 28));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"留学咖啡馆" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 20],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化密码登录视图 -
-(void)initPasswordLoginView
{
    //密码登录视图
    passwordLoginView = [UIView new];
    [self.view addSubview:passwordLoginView];
    [passwordLoginView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(titleLabel.mas_bottom).offset(30);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(46 + 15 + 46));
    }];
    passwordLoginView.hidden = NO;
    
    //4.用户view
    userView = [UIView new];
    [passwordLoginView addSubview:userView];
    [userView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordLoginView);
        make.left.equalTo(passwordLoginView).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    userView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    userView.layer.cornerRadius = 23;
    
    //4-1.用户图标
    UIImageView *userLogoImageView = [UIImageView new];
    [userView addSubview:userLogoImageView];
    [userLogoImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userView).offset(14);
        make.left.equalTo(userView).offset(16);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    [userLogoImageView setImage:[UIImage imageNamed:@"login_user"]];
    
    //4-2.用户清空按钮
    userClearButton = [UIButton new];
    [userView addSubview:userClearButton];
    [userClearButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userView).offset(15);
        make.right.equalTo(userView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    //设置点击不变色
    userClearButton.adjustsImageWhenHighlighted = NO;
    [userClearButton setBackgroundImage:[UIImage imageNamed:@"login_del"] forState:UIControlStateNormal];
    
    //4-3.用户输入框
    userInfoTextField = [UITextField new];
    [userView addSubview:userInfoTextField];
    [userInfoTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userView).offset(8);
        make.left.equalTo(userLogoImageView.mas_right).offset(14);
        make.right.equalTo(userClearButton.mas_left).offset(-10);
        make.height.equalTo(@30);
    }];
    [userInfoTextField setTextAlignment:NSTextAlignmentLeft];
    userInfoTextField.clearButtonMode = UITextFieldViewModeNever;
    userInfoTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *userInfoPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"手机号 / 邮箱 / 用户名"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    userInfoTextField.attributedPlaceholder = userInfoPlaceholderString;
    //设置输入后文字样式
    [userInfoTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [userInfoTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];

    //5.密码view
    passwordView = [UIView new];
    [passwordLoginView addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userView.mas_bottom).offset(15);
        make.left.equalTo(passwordLoginView).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    passwordView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    passwordView.layer.cornerRadius = 23;
    
    //5-1.密码图标
    UIImageView *psdImageView = [UIImageView new];
    [passwordView addSubview:psdImageView];
    [psdImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView).offset(14);
        make.left.equalTo(passwordView).offset(16);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [psdImageView setImage:[UIImage imageNamed:@"login_psd"]];
    
    //5-2.隐藏/显示密码按钮
    showPsdButton = [UIButton new];
    [passwordView addSubview:showPsdButton];
    [showPsdButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView).offset(15);
        make.right.equalTo(passwordView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    //设置点击不变色
    showPsdButton.adjustsImageWhenHighlighted = NO;
    [showPsdButton setBackgroundImage:[UIImage imageNamed:@"login_psd_hide"] forState:UIControlStateNormal];
    
    //5-3.密码输入框
    psdTextField = [UITextField new];
    [passwordView addSubview:psdTextField];
    [psdTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView).offset(8);
        make.left.equalTo(psdImageView.mas_right).offset(14);
        make.right.equalTo(showPsdButton.mas_left).offset(-10);
        make.height.equalTo(@30);
    }];
    psdTextField.secureTextEntry=YES;
    [psdTextField setTextAlignment:NSTextAlignmentLeft];
    psdTextField.clearButtonMode = UITextFieldViewModeNever;
    psdTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *psdPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"密码"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    psdTextField.attributedPlaceholder = psdPlaceholderString;
    //设置输入后文字样式
    [psdTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [psdTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
}

#pragma mark - 初始化快捷登录视图 -
-(void)initQuickLoginView
{
    //快捷登录视图
    quickLoginView = [UIView new];
    [self.view addSubview:quickLoginView];
    [quickLoginView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(titleLabel.mas_bottom).offset(30);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(46 + 15 + 46));
    }];
    quickLoginView.hidden = YES;
    
    //3.手机号view
    phoneView = [UIView new];
    [quickLoginView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(quickLoginView);
        make.left.equalTo(quickLoginView).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    phoneView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    phoneView.layer.cornerRadius = 23;
    
    //3-1.手机号图标
    UIImageView *phoneImageView = [UIImageView new];
    [phoneView addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneView).offset(13);
        make.left.equalTo(phoneView).offset(16);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [phoneImageView setImage:[UIImage imageNamed:@"regist_phone"]];
    
    //3-2.手机号输入框
    phoneTextField = [UITextField new];
    [phoneView addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneView).offset(8);
        make.left.equalTo(phoneImageView.mas_right).offset(13);
        make.right.equalTo(phoneView).offset(-16-16-10);
        make.height.equalTo(@30);
    }];
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [phoneTextField setTextAlignment:NSTextAlignmentLeft];
    phoneTextField.clearButtonMode = UITextFieldViewModeNever;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *phonePlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入注册手机号码"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    phoneTextField.attributedPlaceholder = phonePlaceholderString;
    //设置输入后文字样式
    [phoneTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [phoneTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    //4.验证码view
    CodeView = [UIView new];
    [quickLoginView addSubview:CodeView];
    [CodeView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneView.mas_bottom).offset(15);
        make.left.equalTo(quickLoginView).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    
    //4-1.获取验证码按钮
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
    
    //4-2.验证码输入视图
    UIView *codeInputView = [UIView new];
    [CodeView addSubview:codeInputView];
    [codeInputView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(CodeView);
        make.left.equalTo(CodeView);
        make.right.equalTo(getValidCodeButton.mas_left).offset(-15);
        make.height.equalTo(@46);
    }];
    codeInputView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    codeInputView.layer.cornerRadius = 23;
    
    //4-3.验证码图标
    UIImageView *codeImageView = [UIImageView new];
    [codeInputView addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(codeInputView).offset(14);
        make.left.equalTo(codeInputView).offset(16);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [codeImageView setImage:[UIImage imageNamed:@"login_user"]];
    
    //4-4.验证码输入框
    codeTextField = [UITextField new];
    [codeInputView addSubview:codeTextField];
    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(codeInputView).offset(8);
        make.left.equalTo(codeImageView.mas_right).offset(15);
        make.right.equalTo(codeInputView).offset(-16);
        make.height.equalTo(@30);
    }];
    [codeTextField setTextAlignment:NSTextAlignmentLeft];
    codeTextField.clearButtonMode = UITextFieldViewModeNever;
    codeTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *codePlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"短信验证码"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    codeTextField.attributedPlaceholder = codePlaceholderString;
    //设置输入后文字样式
    [codeTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [codeTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];

}

#pragma mark - 初始化视图 -
-(void)initView
{
    //6.找回密码按钮
    findPsdButton = [UIButton new];
    [self.view addSubview:findPsdButton];
    [findPsdButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView.mas_bottom).offset(6);
        make.left.equalTo(passwordView).offset(10);
        make.size.mas_equalTo(CGSizeMake(56, 35));
    }];
    //设置点击不变色
    findPsdButton.adjustsImageWhenHighlighted = NO;
    NSMutableAttributedString *findPsdButtonString = [[NSMutableAttributedString alloc] initWithString:@"找回密码" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [findPsdButton setAttributedTitle:findPsdButtonString forState:UIControlStateNormal];
    
    //快捷登录 quickLoginButton
    quickLoginButton = [UIButton new];
    [self.view addSubview:quickLoginButton];
    [quickLoginButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView.mas_bottom).offset(6);
        make.right.equalTo(passwordView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(56, 35));
    }];
    //设置点击不变色
    quickLoginButton.adjustsImageWhenHighlighted = NO;
    quickLoginButton.selected = NO;
    NSMutableAttributedString *quickLoginButtonNormalString = [[NSMutableAttributedString alloc] initWithString:@"快捷登录" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [quickLoginButton setAttributedTitle:quickLoginButtonNormalString forState:UIControlStateNormal];
    
    NSMutableAttributedString *quickLoginButtonSelectedString = [[NSMutableAttributedString alloc] initWithString:@"密码登录" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [quickLoginButton setAttributedTitle:quickLoginButtonSelectedString forState:UIControlStateSelected];
    
    //7.登录按钮
    loginView = [UIView new];
    [self.view addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(findPsdButton.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    loginView.layer.backgroundColor = [UIColor colorWithRed:158/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
    loginView.layer.cornerRadius = 23;
    
    //7-1.登录 文字标签
    UILabel *loginLabel = [UILabel new];
    [loginView addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(loginView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 32)/2);
        make.size.mas_equalTo(CGSizeMake(32, 22));
    }];
    loginLabel.numberOfLines = 0;
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.alpha = 1.0;
    NSMutableAttributedString *loginLabelString = [[NSMutableAttributedString alloc] initWithString:@"登录"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    loginLabel.attributedText = loginLabelString;
    
    //7.可点击的登录按钮，与上面那个位置重叠，但是只有在用户信息和密码都不为空时才出现，替代上面登录视图的位置
    clickableLoginView = [UIView new];
    [self.view addSubview:clickableLoginView];
    [clickableLoginView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(findPsdButton.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    clickableLoginView.layer.cornerRadius = 23;
    clickableLoginView.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.4].CGColor;
    clickableLoginView.layer.shadowOffset = CGSizeMake(0,4);
    clickableLoginView.layer.shadowOpacity = 1;
    clickableLoginView.layer.shadowRadius = 10;
    
    [self.view layoutIfNeeded];
    //CAGradientLayer实现颜色渐变
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = clickableLoginView.bounds;
    gl.cornerRadius = 23;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [clickableLoginView.layer addSublayer:gl];
    
    //7-1.登录 文字标签
    UILabel *clickableLoginLabel = [UILabel new];
    [clickableLoginView addSubview:clickableLoginLabel];
    [clickableLoginLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(clickableLoginView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 32)/2);
        make.size.mas_equalTo(CGSizeMake(32, 22));
    }];
    clickableLoginLabel.numberOfLines = 0;
    clickableLoginLabel.textAlignment = NSTextAlignmentCenter;
    clickableLoginLabel.alpha = 1.0;
    NSMutableAttributedString *clickableLoginLabelString = [[NSMutableAttributedString alloc] initWithString:@"登录"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    clickableLoginLabel.attributedText = clickableLoginLabelString;
    
    //8.注册按钮
    registView = [UIView new];
    [self.view addSubview:registView];
    [registView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(findPsdButton.mas_bottom).offset(30 + 46 + 15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    registView.layer.borderWidth = 1;
    registView.layer.borderColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor;
    registView.layer.cornerRadius = 23;
    
    //8-1.注册 文字标签
    UILabel *registLabel = [UILabel new];
    [registView addSubview:registLabel];
    [registLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(registView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-32)/2);
        make.size.mas_equalTo(CGSizeMake(32, 22));
    }];
    registLabel.numberOfLines = 0;
    registLabel.textAlignment = NSTextAlignmentCenter;
    registLabel.alpha = 1.0;
    NSMutableAttributedString *registLabelString = [[NSMutableAttributedString alloc] initWithString:@"注册"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    registLabel.attributedText = registLabelString;
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //***** 密码登录相关 begin *****//
    //清除用户账户信息按钮
    userClearButton.hidden = YES;
    [userClearButton addTarget:self action:@selector(userClearButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //切换密码秘文明文显示按钮
    [showPsdButton addTarget:self action:@selector(showPsdButtonClick) forControlEvents:UIControlEventTouchUpInside];

    //用户信息文本框监听
    [userInfoTextField addTarget:self action:@selector(userInfoTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //用户密码文本框监听
    [psdTextField addTarget:self action:@selector(psdTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    //***** 密码登录相关 end *****//
    
    
    //***** 快捷登录相关 begin *****//
    //获取验证码
    [getValidCodeButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    
    //手机号文本框监听
    [phoneTextField addTarget:self action:@selector(quickLoginViewTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //验证码文本框监听
    [codeTextField addTarget:self action:@selector(quickLoginViewTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    //***** 快捷登录相关 end *****//
    
    
    //找回密码按钮
    [findPsdButton addTarget:self action:@selector(findPsdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //快捷登录按钮
    [quickLoginButton addTarget:self action:@selector(quickLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //2个登录view 添加事件
    loginView.hidden = NO;
    loginView.userInteractionEnabled = NO;
    clickableLoginView.hidden = YES;
    clickableLoginView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *loginViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginViewClick)];
    //设置需要连续点击几次才响应，默认点击1次
    [loginViewTapGesture setNumberOfTapsRequired:1];
    [clickableLoginView addGestureRecognizer:loginViewTapGesture];
    
    //注册按钮
    registView.userInteractionEnabled = YES;
    UITapGestureRecognizer *registViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registViewClick)];
    //设置需要连续点击几次才响应，默认点击1次
    [registViewTapGesture setNumberOfTapsRequired:1];
    [registView addGestureRecognizer:registViewTapGesture];

}

#pragma mark - backButtonClick点击事件 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//*************** 密码登录相关 begin **************//
#pragma mark - userClearButton点击事件 -
-(void)userClearButtonClick
{
    [userInfoTextField setText:@""];
    
    userClearButton.hidden = YES;
    
    //判断登录按钮是否可点击
    [self passwordLoginViewTextFieldDidChange];
}

#pragma mark - showPsdButton点击事件 -
-(void)showPsdButtonClick
{
    if(isShowPsd){
        //此时为明文显示，点击按钮切换为秘文显示
        isShowPsd = NO;
        [showPsdButton setBackgroundImage:[UIImage imageNamed:@"login_psd_hide"] forState:UIControlStateNormal];
        
        NSString *tempPwdStr = psdTextField.text;
        psdTextField.text = @"";    //这句代码可以防止切换的时候光标偏移
        psdTextField.secureTextEntry = YES;
        psdTextField.text = tempPwdStr;
        
    }else{
        //此时为秘文显示，点击按钮切换为明文显示
        isShowPsd = YES;
        [showPsdButton setBackgroundImage:[UIImage imageNamed:@"login_psd_show"] forState:UIControlStateNormal];
        
        NSString *tempPwdStr = psdTextField.text;
        psdTextField.text = @"";    //这句代码可以防止切换的时候光标偏移
        psdTextField.secureTextEntry = NO;
        psdTextField.text = tempPwdStr;
    }
}

#pragma mark - 用户信息输入框监听 -
-(void)userInfoTextFieldDidChange
{
    //判断清空用户信息按钮是否显示
    if(![userInfoTextField.text isEqualToString:@""]){
        //不为空
        userClearButton.hidden = NO;
        
    }else{
        userClearButton.hidden = YES;
    }
    
    //判断登录按钮是否可点击
    [self passwordLoginViewTextFieldDidChange];
}

#pragma mark - 密码输入框监听 -
-(void)psdTextFieldDidChange
{
    //判断登录按钮是否可点击
    [self passwordLoginViewTextFieldDidChange];
}
//*************** 密码登录相关 end **************//

#pragma mark - 找回密码按钮点击事件 -
-(void)findPsdButtonClick
{
    //跳转到找回密码
    AcSysFindPsdVerifyPhone *acSysFindPsdVerifyPhone = [AcSysFindPsdVerifyPhone new];
    [self.navigationController pushViewController:acSysFindPsdVerifyPhone animated:YES];
}

#pragma mark - 快捷登录按钮点击 -
-(void)quickLoginButtonClick
{
    [userInfoTextField resignFirstResponder];
    [psdTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
    
    quickLoginButton.selected = !quickLoginButton.selected;
    
    if(quickLoginButton.selected){
        //选中状态，显示快捷登录
        passwordLoginView.hidden = YES;
        quickLoginView.hidden = NO;
        
        //对快捷登录里的两个输入框进行判断
        [self quickLoginViewTextFieldDidChange];
        
    }else{
        //非选中状态，显示密码登录
        passwordLoginView.hidden = NO;
        quickLoginView.hidden = YES;
        
        //对密码登录里的两个输入框进行判断
        [self passwordLoginViewTextFieldDidChange];
    }
}

#pragma mark - 登录按钮点击事件 -
-(void)loginViewClick
{
    if(!passwordLoginView.hidden){
        //用户名密码登录
        [self doPasswordLogin];
        
    }else if(!quickLoginView.hidden){
        //快捷登录
        [self doQuickLogin];
    }
}

#pragma mark - 注册按钮点击事件 -
-(void)registViewClick
{
    //跳转到注册
    AcSysRegist *acSysRegist = [AcSysRegist new];
    [self.navigationController pushViewController:acSysRegist animated:YES];
}

#pragma mark - 判断登录按钮是否可点击 -
-(void)passwordLoginViewTextFieldDidChange
{
    //判断登录按钮是否可点击
    if(![userInfoTextField.text isEqualToString:@""] && ![psdTextField.text isEqualToString:@""]){
        //用户信息和密码都不为空，登录视图可以点击
        loginView.hidden = YES;
        
        clickableLoginView.hidden = NO;
        
    }else{
        //有一个为空，不可点击
        loginView.hidden = NO;
        
        clickableLoginView.hidden = YES;
    }
}

//*************** 快捷登录相关 begin **************//
#pragma mark - 获取验证码按钮点击事件 -
- (void)getValidCode:(UIButton *)sender
{
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool hasNet){
        if(hasNet){
            //有网
            //获取验证码只验证手机号是否输入及其格式是否正确
            NSString *userPhone = [self->phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            //手机号不可为空
            if([userPhone isEqualToString:@""]){
                [AvalonsoftToast showWithMessage:@"请输入手机号码"];
                return;
            }
            
            //手机格式检查
            if(![_F validateMobile:userPhone]){
                [AvalonsoftToast showWithMessage:@"请输入正确的手机号码"];
                return;
            }
            
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:userPhone forKey:@"telephone"];
            [root setValue:@"1" forKey:@"smsType"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:LOGIN_SEND_SMS method:HttpRequestPost paramenters:root prepareExecute:^{
                
                [AvalonsoftLoadingHUD showIndicatorWithStatus:@"验证码获取中..."];
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                //隐藏加载框
                [AvalonsoftLoadingHUD dismiss];
                
                [self handleNetworkRequestWithResponseObject:responseObject eventType:LOGIN_SEND_SMS];
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
                
                [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
            }];
            
        }else{
            //没网
            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"设备未连接网络，请连接网络后重试！" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}

#pragma mark - 定时器 -
- (void)reduceTime:(NSTimer *)codeTimer
{
    self.timeCount--;
    
    if (self.timeCount == 0) {
        //恢复颜色
        NSMutableAttributedString *getValidCodeButtonString = [[NSMutableAttributedString alloc] initWithString:@"重新获取" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
        [getValidCodeButton setAttributedTitle:getValidCodeButtonString forState:UIControlStateNormal];
        
        [getValidCodeButton setBackgroundColor:RGBA_GGCOLOR(32, 188, 255, 1.0)];

        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        getValidCodeButton.userInteractionEnabled = YES;
        [self.timer invalidate];
        
    } else {
        NSString *str = [NSString stringWithFormat:@"%ldS", (long)self.timeCount];
        NSMutableAttributedString *getValidCodeButtonString = [[NSMutableAttributedString alloc] initWithString:str attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
        [getValidCodeButton setAttributedTitle:getValidCodeButtonString forState:UIControlStateNormal];
        
        getValidCodeButton.userInteractionEnabled = NO;
    }
}

#pragma mark - 快捷登录输入框监听 -
-(void)quickLoginViewTextFieldDidChange
{
    //判断下一步按钮是否可点击
    if(![phoneTextField.text isEqualToString:@""] && ![codeTextField.text isEqualToString:@""] ){
        
        //下一步视图可点击
        loginView.hidden = YES;
        
        clickableLoginView.hidden = NO;
        
    }else{
        //有一个为空，不可点击
        loginView.hidden = NO;
        
        clickableLoginView.hidden = YES;
    }
}
//*************** 快捷登录相关 end **************//

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [userInfoTextField resignFirstResponder];
    [psdTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
}

#pragma mark - 用户名密码登录 -
-(void)doPasswordLogin
{
    NSString *userName = [userInfoTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd = [psdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool hasNet) {
        if (hasNet) {
            
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:userName forKey:@"userName"];
            [root setValue:pwd forKey:@"password"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:USERCENTER_SERVER_URL actionName:LOGIN_PASSWORD_LOGIN method:HttpRequestPost paramenters:root prepareExecute:^{
                
                [AvalonsoftLoadingHUD showIndicatorWithStatus:@"验证登陆信息中..."];
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                //隐藏加载框
                [AvalonsoftLoadingHUD dismiss];
                
                [self handleNetworkRequestWithResponseObject:responseObject eventType:LOGIN_PASSWORD_LOGIN];
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
                
                [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
            }];
            
        } else {
            //没网
            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"设备未连接网络，请连接网络后重试！" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}

#pragma mark - 快捷登录 -
-(void)doQuickLogin
{
    NSString *telephone = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *code = [codeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool hasNet) {
        if (hasNet) {
            
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:telephone forKey:@"telephone"];
            [root setValue:code forKey:@"code"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:USERCENTER_SERVER_URL actionName:LOGIN_TELEPHONE_LOGIN method:HttpRequestPost paramenters:root prepareExecute:^{
                
                [AvalonsoftLoadingHUD showIndicatorWithStatus:@"验证登陆信息中..."];
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                //隐藏加载框
                [AvalonsoftLoadingHUD dismiss];
                
                [self handleNetworkRequestWithResponseObject:responseObject eventType:LOGIN_TELEPHONE_LOGIN];
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
                
                [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
            }];
            
        } else {
            //没网
            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"设备未连接网络，请连接网络后重试！" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}

#pragma mark - 网络请求处理 -
-(void)handleNetworkRequestWithResponseObject:(id)responseObject eventType:(NSString *)eventType
{
//    NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
    
    //使用responseObject对_M进行MVC赋值
    _M *responseModel = [_M createResponseJsonObj:responseObject];
    
//    NSLog(@"rescode-->msg: %ld-->%@",responseModel.rescode,responseModel.msg);
    
    @try {
        if([eventType isEqualToString:LOGIN_PASSWORD_LOGIN]){
            if(responseModel.rescode == 200){
                
                NSDictionary *data = responseModel.data;
                
                self->userDefaultsModel.token = [data objectForKey:@"token"];
                
                NSNumber *sourceNumber = [NSNumber numberWithLong:[data[@"source"] longValue]];
                NSString *sourceStr = [sourceNumber stringValue];
                userDefaultsModel.source = sourceStr;
                
                userDefaultsModel.userName = [data objectForKey:@"userName"];
                userDefaultsModel.userId = [data objectForKey:@"userId"];
                userDefaultsModel.accountId = [data objectForKey:@"accountId"];
                
                NSDictionary *user = [data objectForKey:@"user"];
                userDefaultsModel.password = [user objectForKey:@"password"];
                userDefaultsModel.identify = [user objectForKey:@"identify"];

                //跳转到首页
                MainTabBarViewController *homeView = [MainTabBarViewController new];
                [self.navigationController pushViewController:homeView animated:YES];
                
            }else{
                //给出提示信息
                [AvalonsoftMsgAlertView showWithTitle:@"信息" content:responseModel.msg buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            }
            
        }else if([eventType isEqualToString:LOGIN_SEND_SMS]){
            if(responseModel.rescode == 200){
                
                [AvalonsoftToast showWithMessage:@"验证码发送成功"];
                
                //停止交互
                getValidCodeButton.userInteractionEnabled = NO;
                
                //设置秒数
                NSMutableAttributedString *getValidCodeButtonString = [[NSMutableAttributedString alloc] initWithString:@"60S" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
                [getValidCodeButton setAttributedTitle:getValidCodeButtonString forState:UIControlStateNormal];
                //设置背景色
                [getValidCodeButton setBackgroundColor:RGBA_GGCOLOR(188, 234, 255, 1.0)];
                
                //设置计时器
                self.timeCount = K_CODETIME;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:getValidCodeButton repeats:YES];
                
            }else{
                //给出提示信息
                [AvalonsoftMsgAlertView showWithTitle:@"信息" content:responseModel.msg buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            }
            
        }else if([eventType isEqualToString:LOGIN_TELEPHONE_LOGIN]){
            if(responseModel.rescode == 200){
                
                NSDictionary *data = responseModel.data;
                
                self->userDefaultsModel.token = [data objectForKey:@"token"];
                
                NSNumber *sourceNumber = [NSNumber numberWithLong:[data[@"source"] longValue]];
                NSString *sourceStr = [sourceNumber stringValue];
                userDefaultsModel.source = sourceStr;
                
                userDefaultsModel.userName = [data objectForKey:@"userName"];
                userDefaultsModel.userId = [data objectForKey:@"userId"];
                userDefaultsModel.accountId = [data objectForKey:@"accountId"];
                
                NSDictionary *user = [data objectForKey:@"user"];
                userDefaultsModel.password = [user objectForKey:@"password"];
                userDefaultsModel.identify = [user objectForKey:@"identify"];

                //跳转到首页
                MainTabBarViewController *homeView = [MainTabBarViewController new];
                [self.navigationController pushViewController:homeView animated:YES];
                
            }else{
                //给出提示信息
                [AvalonsoftMsgAlertView showWithTitle:@"信息" content:responseModel.msg buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            }
            
        }
        
    } @catch (NSException *exception) {
        @throw exception;
        //给出提示信息
        [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
    }
}

@end
