//
//  SecurityModifyPwdVC.m
//  Cafe
//
//  Created by leo on 2020/1/2.
//  Copyright © 2020 leo. All rights reserved.
//
//  验证手机 -- 修改密码

#import "SecurityModifyPwdVC.h"

@interface SecurityModifyPwdVC ()

{
    @private UIButton *backButton;              //左上角返回按钮
    @private UIView *navigationView;
    
    @private UIView *passwordView;              //密码视图
    @private UIView *passwordConfirmView;       //确认密码视图
    @private UIView *registView;                //注册视图
    @private UIView *clickableRegistView;       //可点击的注册视图

    @private UIButton *showPsdButton;           //显示密码按钮
    @private UIButton *showPsdConfirmButton;    //显示确认密码按
    
    @private UITextField *psdTextField;         //密码输入框
    @private UITextField *psdConfirmTextField;  //确认密码输入框
    
    @private BOOL isShowPsd;                    //是否明文显示密码，默认为NO
    @private BOOL isShowConfirmPsd;             //是否明文显示确认密码，默认为NO
    
}

@end

@implementation SecurityModifyPwdVC

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
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);

    isShowPsd = NO;
    isShowConfirmPsd = NO;
    
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
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-120)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"设置新密码" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //3.密码view
    passwordView = [UIView new];
    [self.view addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    passwordView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    passwordView.layer.cornerRadius = 23;
    
    //3-1.密码图标
    UIImageView *psdImageView = [UIImageView new];
    [passwordView addSubview:psdImageView];
    [psdImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView).offset(14);
        make.left.equalTo(passwordView).offset(15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [psdImageView setImage:[UIImage imageNamed:@"login_psd"]];
    
    //3-2.隐藏/显示密码按钮
    showPsdButton = [UIButton new];
    [passwordView addSubview:showPsdButton];
    [showPsdButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView).offset(15);
        make.right.equalTo(passwordView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    //设置点击不变色
    showPsdButton.adjustsImageWhenHighlighted = NO;
    [showPsdButton setBackgroundImage:[UIImage imageNamed:@"login_psd_hide"] forState:UIControlStateNormal];
    
    //3-3.密码输入框
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
    NSMutableAttributedString *psdPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"输入新的密码" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    psdTextField.attributedPlaceholder = psdPlaceholderString;
    //设置输入后文字样式
    [psdTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [psdTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    //4.确认密码view
    passwordConfirmView = [UIView new];
    [self.view addSubview:passwordConfirmView];
    [passwordConfirmView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    passwordConfirmView.layer.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:247/255.0 alpha:1.0].CGColor;
    passwordConfirmView.layer.cornerRadius = 23;
    
    //4-1.确认密码图标
    UIImageView *psdConfirmImageView = [UIImageView new];
    [passwordConfirmView addSubview:psdConfirmImageView];
    [psdConfirmImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordConfirmView).offset(14);
        make.left.equalTo(passwordConfirmView).offset(15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [psdConfirmImageView setImage:[UIImage imageNamed:@"login_psd"]];
    
    //4-2.隐藏/显示密码按钮
    showPsdConfirmButton = [UIButton new];
    [passwordConfirmView addSubview:showPsdConfirmButton];
    [showPsdConfirmButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordConfirmView).offset(15);
        make.right.equalTo(passwordConfirmView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    //设置点击不变色
    showPsdConfirmButton.adjustsImageWhenHighlighted = NO;
    [showPsdConfirmButton setBackgroundImage:[UIImage imageNamed:@"login_psd_hide"] forState:UIControlStateNormal];
    
    //4-3.密码输入框
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
    NSMutableAttributedString *psdConfirmPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"再次输入新密码" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    psdConfirmTextField.attributedPlaceholder = psdConfirmPlaceholderString;
    //设置输入后文字样式
    [psdConfirmTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [psdConfirmTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    //***** 提示标签 *****//
    UILabel *explainLabel = [UILabel new];
    [self.view addSubview:explainLabel];
    [explainLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordConfirmView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(28);
        make.size.mas_equalTo(CGSizeMake(200, 18));
    }];
    explainLabel.numberOfLines = 0;
    explainLabel.textAlignment = NSTextAlignmentLeft;
    explainLabel.alpha = 1.0;
    NSMutableAttributedString *explainLabelString = [[NSMutableAttributedString alloc] initWithString:@"6-20位密码、数字或字符"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    explainLabel.attributedText = explainLabelString;
    
    //5.注册视图
    registView = [UIView new];
    [self.view addSubview:registView];
    [registView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(explainLabel.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-355)/2);
        make.size.mas_equalTo(CGSizeMake(355, 46));
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
    NSMutableAttributedString *registLabelString = [[NSMutableAttributedString alloc] initWithString:@"提交"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    registLabel.attributedText = registLabelString;
    
    //11.可点击的登录按钮，与上面那个位置重叠，但是只有在用户信息和密码都不为空时才出现，替代上面登录视图的位置
    clickableRegistView = [UIView new];
    [self.view addSubview:clickableRegistView];
    [clickableRegistView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(explainLabel.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-355)/2);
        make.size.mas_equalTo(CGSizeMake(355, 46));
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
    NSMutableAttributedString *clickableRegistLabelString = [[NSMutableAttributedString alloc] initWithString:@"提交"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    clickableRegistLabel.attributedText = clickableRegistLabelString;
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //显示密码按钮
    [showPsdButton addTarget:self action:@selector(showPsdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //显示确认密码按钮
    [showPsdConfirmButton addTarget:self action:@selector(showPsdConfirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //密码文本框监听
    [psdTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //密码确认文本框监听
    [psdConfirmTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //2个注册视图
    registView.hidden = NO;
    registView.userInteractionEnabled = NO;
    clickableRegistView.hidden = YES;
    clickableRegistView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *registViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registViewClick)];
    //设置需要连续点击几次才响应，默认点击1次
    [registViewTapGesture setNumberOfTapsRequired:1];
    [clickableRegistView addGestureRecognizer:registViewTapGesture];
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
    if(![psdTextField.text isEqualToString:@""] && ![psdConfirmTextField.text isEqualToString:@""]){
        
        //注册视图可点击
        registView.hidden = YES;
        
        clickableRegistView.hidden = NO;
        
    }else{
        //有一个为空，不可点击
        registView.hidden = NO;
        
        clickableRegistView.hidden = YES;
    }
}

#pragma mark - 注册按钮点击事件 -
-(void)registViewClick
{
    //判断两次密码输入是否一致
    NSString *newPsdStr= [psdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *newPsdConfirmStr= [psdConfirmTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(!([newPsdStr isEqualToString:newPsdConfirmStr])){
        [AvalonsoftToast showWithMessage:@"两次密码输入不一致，请确认。"];
        return;
    }
    
    [AvalonsoftToast showWithMessage:@"密码修改成功，跳转到首页"];
}

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [psdTextField resignFirstResponder];
    [psdConfirmTextField resignFirstResponder];
}

@end
