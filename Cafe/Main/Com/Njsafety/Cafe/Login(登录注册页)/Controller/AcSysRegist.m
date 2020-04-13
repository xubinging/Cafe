//
//  AcSysRegist.m
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//
//  新用户注册

#import "AcSysRegist.h"

#import "AcSysLogin.h"
#import "AcSysRegistService.h"  //查看注册条款

#define K_CODETIME 60           //验证码时间
#define K_POPUPMENU_TITLES @[@"学生", @"校友", @"家长&亲友", @"其他"]

@interface AcSysRegist ()<UITextFieldDelegate,YBPopupMenuDelegate>

{
    @private UIView *navigationView;            //导航
    @private UIButton *backButton;              //左上角返回按钮
    
    @private UIView *userView;                  //用户视图
    @private UIView *passwordView;              //密码视图
    @private UIView *passwordConfirmView;       //确认密码视图
    @private UIView *phoneView;                 //手机号视图
    @private UIView *CodeView;                  //验证码视图
    @private UIView *idCardView;                //身份视图
    @private UIView *registView;                //注册视图
    @private UIView *clickableRegistView;       //可点击的注册视图

    @private UIButton *showPsdButton;           //显示密码按钮
    @private UIButton *showPsdConfirmButton;    //显示确认密码按钮
    @private UIButton *getValidCodeButton;      //获取验证码按钮
    @private UIButton *slctIdCardButton;        //选择身份的按钮
    @private UIButton *acceptServiceButton;     //同意注册条款按钮

    @private UITextField *userInfoTextField;    //用户信息输入框
    @private UITextField *psdTextField;         //密码输入框
    @private UITextField *psdConfirmTextField;  //确认密码输入框
    @private UITextField *phoneTextField;       //手机号输入框
    @private UITextField *codeTextField;        //验证码输入框
    @private UITextField *idCardTextField;      //身份输入框，不可编辑的
    @private UILabel *serviceLabel;             //条款标签

    @private BOOL isShowPsd;                    //是否明文显示密码，默认为NO
    @private BOOL isShowConfirmPsd;             //是否明文显示确认密码，默认为NO
    @private BOOL isServiceLabelSlct;           //条款是否选中
    
}

//验证码相关
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@end

@implementation AcSysRegist

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self setListener];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    isShowPsd = NO;
    isShowConfirmPsd = NO;
    isServiceLabelSlct = NO;
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
    [backButton setBackgroundImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"新用户注册" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
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

#pragma mark - 初始化视图 -
-(void)initView
{
    //图片
    UIImageView *loginIcon = [UIImageView new];
    [self.view addSubview:loginIcon];
    [loginIcon mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 80)/2);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [loginIcon setImage:[UIImage imageNamed:@"login_icon"]];
    
    //标签
    UILabel *titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(loginIcon.mas_bottom).offset(-5);;
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 120)/2);
        make.size.mas_equalTo(CGSizeMake(120, 28));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"留学咖啡馆" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 20],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
    //3.用户view
    userView = [UIView new];
    [self.view addSubview:userView];
    [userView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    userView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    userView.layer.cornerRadius = 23;
    
    //3-1.用户图标
    UIImageView *userLogoImageView = [UIImageView new];
    [userView addSubview:userLogoImageView];
    [userLogoImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userView).offset(13);
        make.left.equalTo(userView).offset(16);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [userLogoImageView setImage:[UIImage imageNamed:@"regist_user"]];
    
    //3-2.用户输入框
    userInfoTextField = [UITextField new];
    [userView addSubview:userInfoTextField];
    [userInfoTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userView).offset(8);
        make.left.equalTo(userLogoImageView.mas_right).offset(13);
        make.right.equalTo(userView).offset(-16-16-10);
        make.height.equalTo(@30);
    }];
    [userInfoTextField setTextAlignment:NSTextAlignmentLeft];
    userInfoTextField.clearButtonMode = UITextFieldViewModeNever;
    userInfoTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *userInfoPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入用户名"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    userInfoTextField.attributedPlaceholder = userInfoPlaceholderString;
    //设置输入后文字样式
    [userInfoTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [userInfoTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    //4.密码view
    passwordView = [UIView new];
    [self.view addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    passwordView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    passwordView.layer.cornerRadius = 23;
    
    //4-1.密码图标
    UIImageView *psdImageView = [UIImageView new];
    [passwordView addSubview:psdImageView];
    [psdImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView).offset(14);
        make.left.equalTo(passwordView).offset(16);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [psdImageView setImage:[UIImage imageNamed:@"login_psd"]];
    
    //4-2.隐藏/显示密码按钮
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
    
    //4-3.密码输入框
    psdTextField = [UITextField new];
    [passwordView addSubview:psdTextField];
    [psdTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView).offset(8);
        make.left.equalTo(psdImageView.mas_right).offset(15);
        make.right.equalTo(showPsdButton.mas_left).offset(-10);
        make.height.equalTo(@30);
    }];
    psdTextField.secureTextEntry=YES;
    [psdTextField setTextAlignment:NSTextAlignmentLeft];
    psdTextField.clearButtonMode = UITextFieldViewModeNever;
    psdTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *psdPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入密码(6-64位字符)"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    psdTextField.attributedPlaceholder = psdPlaceholderString;
    //设置输入后文字样式
    [psdTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [psdTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    //5.确认密码view
    passwordConfirmView = [UIView new];
    [self.view addSubview:passwordConfirmView];
    [passwordConfirmView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    passwordConfirmView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    passwordConfirmView.layer.cornerRadius = 23;
    
    //5-1.确认密码图标
    UIImageView *psdConfirmImageView = [UIImageView new];
    [passwordConfirmView addSubview:psdConfirmImageView];
    [psdConfirmImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordConfirmView).offset(14);
        make.left.equalTo(passwordConfirmView).offset(16);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [psdConfirmImageView setImage:[UIImage imageNamed:@"login_psd"]];
    
    //5-2.隐藏/显示密码按钮
    showPsdConfirmButton = [UIButton new];
    [passwordConfirmView addSubview:showPsdConfirmButton];
    [showPsdConfirmButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordConfirmView).offset(15);
        make.right.equalTo(passwordConfirmView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    //设置点击不变色
    showPsdConfirmButton.adjustsImageWhenHighlighted = NO;
    [showPsdConfirmButton setBackgroundImage:[UIImage imageNamed:@"login_psd_hide"] forState:UIControlStateNormal];
    
    //5-3.密码输入框
    psdConfirmTextField = [UITextField new];
    [passwordConfirmView addSubview:psdConfirmTextField];
    [psdConfirmTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordConfirmView).offset(8);
        make.left.equalTo(psdConfirmImageView.mas_right).offset(15);
        make.right.equalTo(showPsdConfirmButton.mas_left).offset(-10);
        make.height.equalTo(@30);
    }];
    psdConfirmTextField.secureTextEntry=YES;
    [psdConfirmTextField setTextAlignment:NSTextAlignmentLeft];
    psdConfirmTextField.clearButtonMode = UITextFieldViewModeNever;
    psdConfirmTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *psdConfirmPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"再次确认密码(6-64位字符)"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    psdConfirmTextField.attributedPlaceholder = psdConfirmPlaceholderString;
    //设置输入后文字样式
    [psdConfirmTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [psdConfirmTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    //6.手机号view
    phoneView = [UIView new];
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordConfirmView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    phoneView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    phoneView.layer.cornerRadius = 23;
    
    //6-1.手机号图标
    UIImageView *phoneImageView = [UIImageView new];
    [phoneView addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneView).offset(13);
        make.left.equalTo(phoneView).offset(16);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [phoneImageView setImage:[UIImage imageNamed:@"regist_phone"]];
    
    //6-2.手机号输入框
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
    NSMutableAttributedString *phonePlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    phoneTextField.attributedPlaceholder = phonePlaceholderString;
    //设置输入后文字样式
    [phoneTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [phoneTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    //7.验证码view
    CodeView = [UIView new];
    [self.view addSubview:CodeView];
    [CodeView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    
    //7-1.获取验证码按钮
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
    
    //7-2.验证码输入视图
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
    
    //7-3.验证码图标
    UIImageView *codeImageView = [UIImageView new];
    [codeInputView addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(codeInputView).offset(14);
        make.left.equalTo(codeInputView).offset(16);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [codeImageView setImage:[UIImage imageNamed:@"login_user"]];
    
    //7-4.验证码输入框
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
    
    //8.身份view
    idCardView = [UIView new];
    [self.view addSubview:idCardView];
    [idCardView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(CodeView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    idCardView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    idCardView.layer.cornerRadius = 23;
    
    //8-1.身份图标
    UIImageView *idCardImageView = [UIImageView new];
    [idCardView addSubview:idCardImageView];
    [idCardImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(idCardView).offset(13);
        make.left.equalTo(idCardView).offset(16);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [idCardImageView setImage:[UIImage imageNamed:@"regist_idcard"]];
    
    //8-2.选择身份按钮
    slctIdCardButton = [UIButton new];
    [idCardView addSubview:slctIdCardButton];
    [slctIdCardButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(idCardView).offset(13);
        make.right.equalTo(idCardView.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    //设置点击不变色
    slctIdCardButton.adjustsImageWhenHighlighted = NO;
    [slctIdCardButton setBackgroundImage:[UIImage imageNamed:@"regist_down"] forState:UIControlStateNormal];
    
    //8-3.身份输入框
    idCardTextField = [UITextField new];
    [idCardView addSubview:idCardTextField];
    [idCardTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(idCardView).offset(8);
        make.left.equalTo(idCardImageView.mas_right).offset(13);
        make.right.equalTo(slctIdCardButton.mas_left).offset(-15);
        make.height.equalTo(@30);
    }];
    [idCardTextField setTextAlignment:NSTextAlignmentLeft];
    idCardTextField.clearButtonMode = UITextFieldViewModeNever;
    idCardTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *idCardPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"请选择您的身份"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    idCardTextField.attributedPlaceholder = idCardPlaceholderString;
    //设置输入后文字样式
    [idCardTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [idCardTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    //设置代理，然后设置不可编辑
    idCardTextField.delegate = self;
    
    //9.注册条款按钮
    acceptServiceButton = [UIButton new];
    [self.view addSubview:acceptServiceButton];
    [acceptServiceButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(idCardView.mas_bottom).offset(12);
        make.left.equalTo(idCardView.mas_left);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    //设置点击不变色
    acceptServiceButton.adjustsImageWhenHighlighted = NO;
    acceptServiceButton.layer.cornerRadius = 7;
    acceptServiceButton.layer.borderWidth = 0.5;
    acceptServiceButton.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0].CGColor;
    
    //9-1.注册条款文字
    serviceLabel = [UILabel new];
    [self.view addSubview:serviceLabel];
    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(idCardView.mas_bottom).offset(10);
        make.left.equalTo(acceptServiceButton.mas_right).offset(6);
        make.size.mas_equalTo(CGSizeMake(170, 18));
    }];
    serviceLabel.numberOfLines = 0;
    serviceLabel.textAlignment = NSTextAlignmentLeft;
    serviceLabel.alpha = 1.0;
    
    NSMutableAttributedString *serviceLabelString = [[NSMutableAttributedString alloc] initWithString:@"同意《留学咖啡馆注册条款》"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]}];

    [serviceLabelString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]} range:NSMakeRange(0, 2)];

    [serviceLabelString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:46/255.0 blue:80/255.0 alpha:1.0]} range:NSMakeRange(2, 11)];
    serviceLabel.attributedText = serviceLabelString;
    
    //10.注册视图
    registView = [UIView new];
    [self.view addSubview:registView];
    [registView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(idCardView.mas_bottom).offset(10+20+20);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    registView.layer.backgroundColor = [UIColor colorWithRed:158/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
    registView.layer.cornerRadius = 23;
    
    //10-1.注册 文字标签
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
    NSMutableAttributedString *registLabelString = [[NSMutableAttributedString alloc] initWithString:@"注册"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    registLabel.attributedText = registLabelString;
    
    //11.可点击的登录按钮，与上面那个位置重叠，但是只有在用户信息和密码都不为空时才出现，替代上面登录视图的位置
    clickableRegistView = [UIView new];
    [self.view addSubview:clickableRegistView];
    [clickableRegistView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(idCardView.mas_bottom).offset(10+20+20);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    clickableRegistView.layer.cornerRadius = 23;
    clickableRegistView.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.4].CGColor;
    clickableRegistView.layer.shadowOffset = CGSizeMake(0,4);
    clickableRegistView.layer.shadowOpacity = 1;
    clickableRegistView.layer.shadowRadius = 10;
    
    [self.view layoutIfNeeded];
    //CAGradientLayer实现颜色渐变
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = clickableRegistView.bounds;
    gl.cornerRadius = 23;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [clickableRegistView.layer addSublayer:gl];
    
    //11-1.注册 文字标签
    UILabel *clickableRegistLabel = [UILabel new];
    [clickableRegistView addSubview:clickableRegistLabel];
    [clickableRegistLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(clickableRegistView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-32)/2);
        make.size.mas_equalTo(CGSizeMake(32, 22));
    }];
    clickableRegistLabel.numberOfLines = 0;
    clickableRegistLabel.textAlignment = NSTextAlignmentCenter;
    clickableRegistLabel.alpha = 1.0;
    NSMutableAttributedString *clickableRegistLabelString = [[NSMutableAttributedString alloc] initWithString:@"注册"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    clickableRegistLabel.attributedText = clickableRegistLabelString;
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //显示密码按钮
    [showPsdButton addTarget:self action:@selector(showPsdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //显示确认密码按钮
    [showPsdConfirmButton addTarget:self action:@selector(showPsdConfirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //用户信息文本框监听
    [userInfoTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //密码文本框监听
    [psdTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //密码确认文本框监听
    [psdConfirmTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //手机号文本框监听
    [phoneTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //验证码文本框监听
    [codeTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //身份文本框监听
    [idCardTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //2个注册视图
    registView.hidden = NO;
    registView.userInteractionEnabled = NO;
    clickableRegistView.hidden = YES;
    clickableRegistView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *registViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registViewClick)];
    //设置需要连续点击几次才响应，默认点击1次
    [registViewTapGesture setNumberOfTapsRequired:1];
    [clickableRegistView addGestureRecognizer:registViewTapGesture];
    
    //选择身份
    [slctIdCardButton addTarget:self action:@selector(slctIdCardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //获取验证码
    [getValidCodeButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];

    //条款按钮
    [acceptServiceButton addTarget:self action:@selector(acceptServiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //查看条款
    serviceLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *serviceLabelTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceLabelClick)];
    //设置需要连续点击几次才响应，默认点击1次
    [serviceLabelTapGesture setNumberOfTapsRequired:1];
    [serviceLabel addGestureRecognizer:serviceLabelTapGesture];
    
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 显示密码按钮点击事件 -
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

#pragma mark - 显示确认密码按钮点击事件 -
-(void)showPsdConfirmButtonClick
{
    if(isShowConfirmPsd){
        //此时为明文显示，点击按钮切换为秘文显示
        isShowConfirmPsd = NO;
        [showPsdConfirmButton setBackgroundImage:[UIImage imageNamed:@"login_psd_hide"] forState:UIControlStateNormal];
        
        NSString *tempPwdStr = psdConfirmTextField.text;
        psdConfirmTextField.text = @"";    //这句代码可以防止切换的时候光标偏移
        psdConfirmTextField.secureTextEntry = YES;
        psdConfirmTextField.text = tempPwdStr;
        
    }else{
        //此时为秘文显示，点击按钮切换为明文显示
        isShowConfirmPsd = YES;
        [showPsdConfirmButton setBackgroundImage:[UIImage imageNamed:@"login_psd_show"] forState:UIControlStateNormal];
        
        NSString *tempPwdStr = psdConfirmTextField.text;
        psdConfirmTextField.text = @"";    //这句代码可以防止切换的时候光标偏移
        psdConfirmTextField.secureTextEntry = NO;
        psdConfirmTextField.text = tempPwdStr;
    }
}

#pragma mark - 输入框监听 -
-(void)textFieldDidChange
{
    //判断注册按钮是否可点击
    if(![userInfoTextField.text isEqualToString:@""] && ![psdTextField.text isEqualToString:@""]
       && ![psdConfirmTextField.text isEqualToString:@""] && ![phoneTextField.text isEqualToString:@""]
       && ![codeTextField.text isEqualToString:@""] && ![idCardTextField.text isEqualToString:@""]
       && isServiceLabelSlct){
        
        //注册视图可点击
        registView.hidden = YES;
        
        clickableRegistView.hidden = NO;
        
    }else{
        //有一个为空，不可点击
        registView.hidden = NO;
        
        clickableRegistView.hidden = YES;
    }
}

#pragma mark - 选择身份按钮点击事件 -
-(void)slctIdCardButtonClick:(UIButton *)sender
{
    //显示弹框
    [YBPopupMenu showRelyOnView:sender titles:K_POPUPMENU_TITLES icons:nil menuWidth:140 delegate:self];
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
    if(![_F validateMobile:userPhone]){
        [AvalonsoftToast showWithMessage:@"请输入正确的手机号码"];
        return;
    }
    
    //先判断手机号是否已存在
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool hasNet){
        if(hasNet){
            //有网
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            
            [root setValue:userPhone forKey:@"phonenumber"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:REGIST_CHECK_PHONENUM method:HttpRequestPost paramenters:root prepareExecute:^{
                
                [AvalonsoftLoadingHUD showIndicatorWithStatus:@"手机号码验证中..."];
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                //隐藏加载框
                [AvalonsoftLoadingHUD dismiss];
                
                [self handleNetworkRequestWithResponseObject:responseObject eventType:REGIST_CHECK_PHONENUM];
                
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

//定时器
- (void)reduceTime:(NSTimer *)codeTimer
{
    
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
        NSString *str = [NSString stringWithFormat:@"%ldS", (long)self.timeCount];
        NSMutableAttributedString *getValidCodeButtonString = [[NSMutableAttributedString alloc] initWithString:str attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
        [getValidCodeButton setAttributedTitle:getValidCodeButtonString forState:UIControlStateNormal];
        
        getValidCodeButton.userInteractionEnabled = NO;
    }
}

#pragma mark - 点击同意条款按钮 -
-(void)acceptServiceButtonClick
{
    if(isServiceLabelSlct){
        //选中状态，点击取消选中
        isServiceLabelSlct = NO;
        
        acceptServiceButton.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0].CGColor;
        [acceptServiceButton setBackgroundImage:[_F imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(14, 14)] forState:UIControlStateNormal];
        
    }else{
        //未选中，点击选中
        isServiceLabelSlct = YES;
        
        acceptServiceButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [acceptServiceButton setBackgroundImage:[UIImage imageNamed:@"regist_slct"] forState:UIControlStateNormal];
        
    }
    
    //判断一下注册按钮是否显示
    [self textFieldDidChange];
}

#pragma mark - 点击查看条款 -
-(void)serviceLabelClick
{
    //跳转到注册
    AcSysRegistService *acSysRegistService = [AcSysRegistService new];
    [self.navigationController pushViewController:acSysRegistService animated:YES];
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    NSString *slctOption = K_POPUPMENU_TITLES[index];
    
    [idCardTextField setText:slctOption];
    
    [self textFieldDidChange];
}

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [userInfoTextField resignFirstResponder];
    [psdTextField resignFirstResponder];
    [psdConfirmTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
    [idCardTextField resignFirstResponder];
}

#pragma mark - 设置UITextField不可编辑 -
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

#pragma mark - 注册按钮点击事件 -
-(void)registViewClick
{
    NSString *userName = [userInfoTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [psdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *confirmPassword= [psdConfirmTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *phonenumber = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *code = [codeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *identify = [idCardTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //校验密码
    if(![_F checkPassword:password]){
        [AvalonsoftToast showWithMessage:@"请输入6-64位数字和字母组合密码"];
        return;
    }
    
    if(!([password isEqualToString:confirmPassword])){
        [AvalonsoftToast showWithMessage:@"两次密码输入不一致，请确认"];
        return;
    }
    
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool hasNet){
        if(hasNet){
            //有网
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:userName forKey:@"userName"];
            [root setValue:password forKey:@"password"];
            [root setValue:phonenumber forKey:@"phonenumber"];
            [root setValue:code forKey:@"code"];
            [root setValue:identify forKey:@"identify"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:REGIST_ACCOUNT method:HttpRequestPost paramenters:root prepareExecute:^{
                
                [AvalonsoftLoadingHUD showIndicatorWithStatus:@"注册中..."];
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                //隐藏加载框
                [AvalonsoftLoadingHUD dismiss];
                
                [self handleNetworkRequestWithResponseObject:responseObject eventType:REGIST_ACCOUNT];
                
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

#pragma mark - 网络请求处理 -
-(void)handleNetworkRequestWithResponseObject:(id)responseObject eventType:(NSString *)eventType
{
//    NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
    
    //使用responseObject对_M进行MVC赋值
    _M *responseModel = [_M createResponseJsonObj:responseObject];
    
//    NSLog(@"rescode-->msg: %ld-->%@",responseModel.rescode,responseModel.msg);
    
    @try {
        if([eventType isEqualToString:REGIST_CHECK_PHONENUM]){
            if(responseModel.rescode == 200){
                
                //手机号码未被注册，发送验证码
                NSString *userPhone = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                NSMutableDictionary *root = [NSMutableDictionary dictionary];
                [root setValue:userPhone forKey:@"telephone"];
                
                [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:REGIST_SEND_SMS method:HttpRequestPost paramenters:root prepareExecute:^{
                    
                    [AvalonsoftLoadingHUD showIndicatorWithStatus:@"验证码获取中..."];
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    
                    //隐藏加载框
                    [AvalonsoftLoadingHUD dismiss];
                    
                    [self handleNetworkRequestWithResponseObject:responseObject eventType:REGIST_SEND_SMS];
                    
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    //请求失败
                    NSLog(@"%@",error);
                    
                    [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
                }];
                
            }else{
                //给出提示信息
                [AvalonsoftMsgAlertView showWithTitle:@"信息" content:responseModel.msg buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            }
            
        }else if([eventType isEqualToString:REGIST_SEND_SMS]){
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
            
        }else if([eventType isEqualToString:REGIST_ACCOUNT]){
            if(responseModel.rescode == 200){

                [AvalonsoftToast showWithMessage:@"注册成功" image:@"login_success" duration:1];
                
                [self performSelector:@selector(pageBackToLogin) withObject:nil afterDelay:1.5];

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

#pragma mark - 返回到登录页 -
-(void)pageBackToLogin
{
    AcSysLogin *login = [AcSysLogin new];
    [self.navigationController pushViewController:login animated:YES];
}

@end
