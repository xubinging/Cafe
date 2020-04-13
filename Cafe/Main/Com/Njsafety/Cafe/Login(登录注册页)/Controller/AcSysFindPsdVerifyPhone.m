//
//  AcSysFindPsdVerifyPhone.m
//  Cafe
//
//  Created by leo on 2019/12/13.
//  Copyright © 2019 leo. All rights reserved.
//
//  找回密码 -- 验证手机

#import "AcSysFindPsdVerifyPhone.h"

#import "AcSysLogin.h"              //登录页
#import "AcSysFindPsdSetNewPsd.h"   //重新设置密码

#define K_CODETIME 60      //验证码时间

@interface AcSysFindPsdVerifyPhone ()

{
    @private UIView *navigationView;            //导航
    @private UIButton *backButton;              //左上角返回按钮
    
    @private UIView *phoneView;                 //手机号视图
    @private UIView *CodeView;                  //验证码视图
    @private UIView *nextStepView;              //下一步视图
    @private UIView *clickableNextStepView;     //可点击的下一步视图
        
    @private UIButton *getValidCodeButton;      //获取验证码按钮
        
    @private UITextField *phoneTextField;       //手机号输入框
    @private UITextField *codeTextField;        //验证码输入框
    
}

//验证码相关
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@end

@implementation AcSysFindPsdVerifyPhone

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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"找回密码" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
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
    
    //3.手机号view
    phoneView = [UIView new];
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(titleLabel.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
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
    [self.view addSubview:CodeView];
    [CodeView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(phoneView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
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
    
    //5.下一步视图
    nextStepView = [UIView new];
    [self.view addSubview:nextStepView];
    [nextStepView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(CodeView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    nextStepView.layer.backgroundColor = [UIColor colorWithRed:158/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
    nextStepView.layer.cornerRadius = 23;
    
    //5-1.下一步 文字标签
    UILabel *nextStepLabel = [UILabel new];
    [nextStepView addSubview:nextStepLabel];
    [nextStepLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(nextStepView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-100)/2);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    nextStepLabel.numberOfLines = 0;
    nextStepLabel.textAlignment = NSTextAlignmentCenter;
    nextStepLabel.alpha = 1.0;
    NSMutableAttributedString *nextStepLabelString = [[NSMutableAttributedString alloc] initWithString:@"下一步"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    nextStepLabel.attributedText = nextStepLabelString;
    
    //5.可点击的下一步按钮，与上面那个位置重叠
    clickableNextStepView = [UIView new];
    [self.view addSubview:clickableNextStepView];
    [clickableNextStepView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(CodeView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-319)/2);
        make.size.mas_equalTo(CGSizeMake(319, 46));
    }];
    clickableNextStepView.layer.cornerRadius = 23;
    clickableNextStepView.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.4].CGColor;
    clickableNextStepView.layer.shadowOffset = CGSizeMake(0,4);
    clickableNextStepView.layer.shadowOpacity = 1;
    clickableNextStepView.layer.shadowRadius = 10;
    
    [self.view layoutIfNeeded];
    //CAGradientLayer实现颜色渐变
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = clickableNextStepView.bounds;
    gl.cornerRadius = 23;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [clickableNextStepView.layer addSublayer:gl];
    
    //5-1.下一步 文字标签
    UILabel *clickableNextStepLabel = [UILabel new];
    [clickableNextStepView addSubview:clickableNextStepLabel];
    [clickableNextStepLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(clickableNextStepView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-100)/2);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    clickableNextStepLabel.numberOfLines = 0;
    clickableNextStepLabel.textAlignment = NSTextAlignmentCenter;
    clickableNextStepLabel.alpha = 1.0;
    NSMutableAttributedString *clickableNextStepLabelString = [[NSMutableAttributedString alloc] initWithString:@"下一步"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    clickableNextStepLabel.attributedText = clickableNextStepLabelString;
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //获取验证码
    [getValidCodeButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    
    //手机号文本框监听
    [phoneTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //验证码文本框监听
    [codeTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    //2个下一步视图
    nextStepView.hidden = NO;
    nextStepView.userInteractionEnabled = NO;
    clickableNextStepView.hidden = YES;
    clickableNextStepView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *nextStepViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextStepViewClick)];
    //设置需要连续点击几次才响应，默认点击1次
    [nextStepViewTapGesture setNumberOfTapsRequired:1];
    [clickableNextStepView addGestureRecognizer:nextStepViewTapGesture];
    
}

#pragma mark - 下一步按钮点击事件 -
-(void)nextStepViewClick
{
    NSString *telephone = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *code = [codeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool hasNet) {
        if (hasNet) {
            
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:telephone forKey:@"telephone"];
            [root setValue:code forKey:@"code"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:USERCENTER_SERVER_URL actionName:FINDPSD_CHECK_PHONENUMANDCODE method:HttpRequestPost paramenters:root prepareExecute:^{
                
                [AvalonsoftLoadingHUD showIndicatorWithStatus:@"验证信息中..."];
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                //隐藏加载框
                [AvalonsoftLoadingHUD dismiss];
                
                [self handleNetworkRequestWithResponseObject:responseObject eventType:FINDPSD_CHECK_PHONENUMANDCODE];
                
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

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取验证码按钮点击事件 -
- (void)getValidCode:(UIButton *)sender
{
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
    
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool hasNet){
        if(hasNet){
            //有网
            NSMutableDictionary *root = [_F createRequestDicWithEventAction:@"" eventType:@""];
            
            NSString *url = [[NSString alloc] init];
            url = [USERCENTER_SERVER_URL stringByAppendingFormat:@"/%@%@",FINDPSD_CHECK_PHONENUM, userPhone];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithActionUrlAndParam:url method:HttpRequestPost paramenters:root prepareExecute:^{
                
                [AvalonsoftLoadingHUD showIndicatorWithStatus:@"手机号码验证中..."];
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //隐藏加载框
                [AvalonsoftLoadingHUD dismiss];
                
                //处理网络请求结果
                [self handleNetworkRequestWithResponseObject:responseObject eventType:FINDPSD_CHECK_PHONENUM];
                
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

#pragma mark - 输入框监听 -
-(void)textFieldDidChange
{
    //判断下一步按钮是否可点击
    if(![phoneTextField.text isEqualToString:@""] && ![codeTextField.text isEqualToString:@""] ){
        
        //下一步视图可点击
        nextStepView.hidden = YES;
        
        clickableNextStepView.hidden = NO;
        
    }else{
        //有一个为空，不可点击
        nextStepView.hidden = NO;
        
        clickableNextStepView.hidden = YES;
    }
}

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [phoneTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
}

#pragma mark - 网络请求处理 -
-(void)handleNetworkRequestWithResponseObject:(id)responseObject eventType:(NSString *)eventType
{
//    NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
    
    //使用responseObject对_M进行MVC赋值
    _M *responseModel = [_M createResponseJsonObj:responseObject];
    
//    NSLog(@"rescode-->msg: %ld-->%@",responseModel.rescode,responseModel.msg);
    
    @try {
        if([eventType isEqualToString:FINDPSD_CHECK_PHONENUM]){
            if(responseModel.rescode == 200){
                
                //获取验证码
                NSString *userPhone = [self->phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                NSMutableDictionary *root = [_F createRequestDicWithEventAction:@"" eventType:@""];

                NSString *url = [[NSString alloc] init];
                url = [USERCENTER_SERVER_URL stringByAppendingFormat:@"/%@%@",FINDPSD_SEND_SMS, userPhone];
                
                [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithActionUrlAndParam:url method:HttpRequestPost paramenters:root prepareExecute:^{
                    
                    [AvalonsoftLoadingHUD showIndicatorWithStatus:@"验证码获取中..."];
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    //隐藏加载框
                    [AvalonsoftLoadingHUD dismiss];
                    
                    //处理网络请求结果
                    [self handleNetworkRequestWithResponseObject:responseObject eventType:FINDPSD_SEND_SMS];
                    
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    //请求失败
                    NSLog(@"%@",error);
                    
                    [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
                }];
                
            }else{
                //给出提示信息
                [AvalonsoftMsgAlertView showWithTitle:@"信息" content:responseModel.msg buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            }
            
        }else if([eventType isEqualToString:FINDPSD_SEND_SMS]){
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
            
        }else if([eventType isEqualToString:FINDPSD_CHECK_PHONENUMANDCODE]){
            if(responseModel.rescode == 200){
                
                //把手机号和验证码传到修改密码页面
                NSString *telephone = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                NSString *code = [codeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                NSDictionary *dataDic = @{
                    @"telephone":telephone,
                    @"code":code
                };
                
                //跳转到修改密码
                AcSysFindPsdSetNewPsd *acSysFindPsdSetNewPsd = [AcSysFindPsdSetNewPsd new];
                acSysFindPsdSetNewPsd.dataDic = dataDic;
                [self.navigationController pushViewController:acSysFindPsdSetNewPsd animated:YES];
                
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
