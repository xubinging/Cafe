//
//  AcSysFindPsdSetNewPsd.m
//  Cafe
//
//  Created by leo on 2019/12/13.
//  Copyright © 2019 leo. All rights reserved.
//
//  找回密码 -- 设置新密码

#import "AcSysFindPsdSetNewPsd.h"   //验证手机页面

#import "AcSysLogin.h"

@interface AcSysFindPsdSetNewPsd ()

{
    @private UIView *navigationView;            //导航
    @private UIButton *backButton;              //左上角返回按钮
    
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

@implementation AcSysFindPsdSetNewPsd

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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"设置新密码" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
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
        make.top.equalTo(navigationView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 80)/2);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [loginIcon setImage:[UIImage imageNamed:@"login_icon"]];
    
    //标签
    UILabel *titleLabel = [UILabel new];
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
    
    //3.密码view
    passwordView = [UIView new];
    [self.view addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(titleLabel.mas_bottom).offset(30);
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
        make.left.equalTo(passwordView).offset(16);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [psdImageView setImage:[UIImage imageNamed:@"login_psd"]];
    
    //3-2.隐藏/显示密码按钮
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
    NSMutableAttributedString *psdPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"请设置新密码(6-64位字符)"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
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
        make.left.equalTo(passwordConfirmView).offset(16);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [psdConfirmImageView setImage:[UIImage imageNamed:@"login_psd"]];
    
    //4-2.隐藏/显示密码按钮
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
    NSMutableAttributedString *psdConfirmPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"再次确认新密码(6-64位字符)"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    psdConfirmTextField.attributedPlaceholder = psdConfirmPlaceholderString;
    //设置输入后文字样式
    [psdConfirmTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [psdConfirmTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    
    //5.注册视图
    registView = [UIView new];
    [self.view addSubview:registView];
    [registView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordConfirmView.mas_bottom).offset(30);
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
    NSMutableAttributedString *registLabelString = [[NSMutableAttributedString alloc] initWithString:@"确定"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    registLabel.attributedText = registLabelString;
    
    //11.可点击的登录按钮，与上面那个位置重叠，但是只有在用户信息和密码都不为空时才出现，替代上面登录视图的位置
    clickableRegistView = [UIView new];
    [self.view addSubview:clickableRegistView];
    [clickableRegistView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordConfirmView.mas_bottom).offset(30);
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
    NSMutableAttributedString *clickableRegistLabelString = [[NSMutableAttributedString alloc] initWithString:@"确定"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
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
    
    if(![_F checkPassword:newPsdStr]){
        [AvalonsoftToast showWithMessage:@"请输入6-64位数字和字母组合密码"];
        return;
    }
    
    if(!([newPsdStr isEqualToString:newPsdConfirmStr])){
        [AvalonsoftToast showWithMessage:@"两次密码输入不一致，请确认"];
        return;
    }
    
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool hasNet) {
        if (hasNet) {
            
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            
            [root setValue:self->_dataDic[@"telephone"] forKey:@"telephone"];
            [root setValue:self->_dataDic[@"code"] forKey:@"code"];
            [root setValue:newPsdStr forKey:@"password"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:USERCENTER_SERVER_URL actionName:FINDPSD_RESET_PWD method:HttpRequestPost paramenters:root prepareExecute:^{
                
                [AvalonsoftLoadingHUD showIndicatorWithStatus:@"验证信息中..."];
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                //隐藏加载框
                [AvalonsoftLoadingHUD dismiss];
                
                [self handleNetworkRequestWithResponseObject:responseObject eventType:FINDPSD_RESET_PWD];
                
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
        if([eventType isEqualToString:FINDPSD_RESET_PWD]){
            if(responseModel.rescode == 200){
                
                [AvalonsoftToast showWithMessage:@"密码修改成功" image:@"login_success" duration:1];
                
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

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [psdTextField resignFirstResponder];
    [psdConfirmTextField resignFirstResponder];
}

@end
