//
//  PersonalDataPrepareCourseVC.m
//  Cafe
//
//  Created by leo on 2020/1/5.
//  Copyright © 2020 leo. All rights reserved.
//
//  国内预科

#import "PersonalDataPrepareCourseVC.h"

@interface PersonalDataPrepareCourseVC ()<UITextFieldDelegate>

{
    @private UIButton *backButton;              //左上角返回按钮
    
    @private UIView *navigationView;
    @private UIView *contentView;
    @private UIView *registView;                //注册视图
    @private UIView *clickableRegistView;       //可点击的注册视图
    
    @private UITextField *courseTextField;
    @private UITextField *countryTextField;
    
    @private NSString *domesticPreparatoryType; //国内预科
    @private NSString *country;                 //留学国家

    @private NSMutableDictionary *sendMultiDic; //保存数据
}

@end

@implementation PersonalDataPrepareCourseVC

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
    if(_dataDic[@"domesticPreparatoryType"]){
        domesticPreparatoryType = _dataDic[@"domesticPreparatoryType"];
    }else{
        domesticPreparatoryType = @"";
    }
    
    if(_dataDic[@"country"]){
        country = _dataDic[@"country"];
    }else{
        country = @"";
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
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20,530));
    }];
    contentView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contentView.layer.cornerRadius = 8;
    contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,0);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 10;
    
    //国内预科
    UILabel *courseLabel = [UILabel new];
    [contentView addSubview:courseLabel];
    [courseLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView).offset(20);
        make.left.equalTo(contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100,20));
    }];
    courseLabel.numberOfLines = 0;
    courseLabel.textAlignment = NSTextAlignmentLeft;
    courseLabel.alpha = 1.0;
    NSMutableAttributedString *courseLabelString = [[NSMutableAttributedString alloc] initWithString:@"国内预科"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    courseLabel.attributedText = courseLabelString;
    
    UIImageView *courseNextStep = [UIImageView new];
    [contentView addSubview:courseNextStep];
    [courseNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(courseLabel.mas_bottom).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [courseNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    courseTextField = [UITextField new];
    [contentView addSubview:courseTextField];
    [courseTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(courseLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(courseNextStep.mas_left).offset(-15);
        make.height.equalTo(@22);
    }];
    courseTextField.tag = 1;
    courseTextField.delegate = self;
    [courseTextField setTextAlignment:NSTextAlignmentLeft];
    courseTextField.clearButtonMode = UITextFieldViewModeNever;
    courseTextField.borderStyle = UITextBorderStyleNone;
    //设置输入后文字样式
    [courseTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [courseTextField setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
     
    UIView *courseSplitView = [UIView new];
    [contentView addSubview:courseSplitView];
    [courseSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(courseTextField.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    [courseSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    

    //面向国家
    UILabel *countryLabel = [UILabel new];
    [contentView addSubview:countryLabel];
    [countryLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(courseSplitView).offset(28);
        make.left.equalTo(contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100,20));
    }];
    countryLabel.numberOfLines = 0;
    countryLabel.textAlignment = NSTextAlignmentLeft;
    countryLabel.alpha = 1.0;
    NSMutableAttributedString *countryLabelString = [[NSMutableAttributedString alloc] initWithString:@"留学国家"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    countryLabel.attributedText = countryLabelString;
    
    UIImageView *countryNextStep = [UIImageView new];
    [contentView addSubview:countryNextStep];
    [countryNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryLabel.mas_bottom).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [countryNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    countryTextField = [UITextField new];
    [contentView addSubview:countryTextField];
    [countryTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(countryNextStep.mas_left).offset(-15);
        make.height.equalTo(@22);
    }];
    countryTextField.tag = 2;
    countryTextField.delegate = self;
    [countryTextField setTextAlignment:NSTextAlignmentLeft];
    countryTextField.clearButtonMode = UITextFieldViewModeNever;
    countryTextField.borderStyle = UITextBorderStyleNone;
    //设置输入后文字样式
    [countryTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [countryTextField setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
     
    UIView *countrySplitView = [UIView new];
    [contentView addSubview:countrySplitView];
    [countrySplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryTextField.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    [countrySplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //10.注册视图
    registView = [UIView new];
    [contentView addSubview:registView];
    [registView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countrySplitView.mas_bottom).offset(260);
        make.left.equalTo(contentView).offset((SCREEN_WIDTH-325)/2);
        make.size.mas_equalTo(CGSizeMake(325, 46));
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
    NSMutableAttributedString *registLabelString = [[NSMutableAttributedString alloc] initWithString:@"保存"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    registLabel.attributedText = registLabelString;
    
    //11.可点击的登录按钮，与上面那个位置重叠，但是只有在用户信息和密码都不为空时才出现，替代上面登录视图的位置
    clickableRegistView = [UIView new];
    [self.view addSubview:clickableRegistView];
    [clickableRegistView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countrySplitView.mas_bottom).offset(260);
        make.left.equalTo(contentView).offset((SCREEN_WIDTH-325)/2);
        make.size.mas_equalTo(CGSizeMake(325, 46));
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
    NSMutableAttributedString *clickableRegistLabelString = [[NSMutableAttributedString alloc] initWithString:@"保存"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    clickableRegistLabel.attributedText = clickableRegistLabelString;
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    
    //2个注册视图
    registView.hidden = YES;
    registView.userInteractionEnabled = NO;
    
    clickableRegistView.hidden = NO;
    clickableRegistView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *registViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveButtonClick)];
    //设置需要连续点击几次才响应，默认点击1次
    [registViewTapGesture setNumberOfTapsRequired:1];
    [clickableRegistView addGestureRecognizer:registViewTapGesture];
    
}

#pragma mark - 设置参数 -
-(void)setData
{
    
    courseTextField.text = domesticPreparatoryType;
    
    countryTextField.text = country;

}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    if([courseTextField.text isEqualToString:@""]){
        [AvalonsoftToast showWithMessage:@"请选择国内预科类型"];
        return;
    }
    
    if([countryTextField.text isEqualToString:@""]){
        [AvalonsoftToast showWithMessage:@"请选择面向国家"];
        return;
    }
        
    //模拟保存成功
//    [AvalonsoftToast showWithMessage:@"保存成功" image:@"login_success" duration:1];
    
    //延迟推出
//    [self performSelector:@selector(saveSuccess) withObject:nil afterDelay:1.5];
    
    [self saveSuccess];
}

-(void)saveSuccess{
    //设置回调
    NSDictionary *sendDataDic = @{@"domesticPreparatoryType":domesticPreparatoryType,
                                  @"country":country
    };
    
    sendMultiDic = [NSMutableDictionary dictionary];
    [sendMultiDic setDictionary:sendDataDic];
    [self updateUserInfo:sendMultiDic];
    
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 1){
        //国内预科
        [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"本科预科", @"研究生预科", @"艺术本科预科", @"艺术研究生预科"] DefaultSelValue:@"研究生预科" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
            //回调
            self->domesticPreparatoryType = selectValue;
            self->courseTextField.text = selectValue;
            
        }];
        
    }else if(textField.tag == 2){
        //面向国家
        [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"加拿大 Canada", @"美国 United States", @"澳洲 Australia", @"新西兰 New Zealand", @"英国 United Kingdom"] DefaultSelValue:@"美国 United States" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
            //回调
            self->country = selectValue;
            self->countryTextField.text = selectValue;
            
        }];
    }
    
    return NO;
}

#pragma mark - 所有网络请求处理都在这里进行 -
-(void)updateUserInfo:(NSMutableDictionary *) root {
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
            if (has) {
                [root setValue:[_UserInfo accountId] forKey:@"accountId"];

                [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO method:HttpRequestPost paramenters:root prepareExecute:^{
                                        
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO];
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    //请求失败
                    NSLog(@"%@",error);
                    
                    [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
                }];
                
            } else {
                //没网
                //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            }
        }];
}

-(void)handleNetworkRequestWithResponseObject:(id)responseObject eventType:(NSString *)eventType
{
    NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
    //使用responseObject对_M进行MVC赋值
    _M *responseModel = [_M createResponseJsonObj:responseObject];
    
    NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
    
    @try {
        if ([eventType isEqualToString:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO]) {
            if(responseModel.rescode == 200){
                [AvalonsoftToast showWithMessage:@"更新成功"];
            
                //Block传值step 3:传值类将要传的值传入自己的block中
                self.sendValueBlock(sendMultiDic);
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [AvalonsoftToast showWithMessage:@"更新失败"];
            }
        }
    } @catch (NSException *exception) {
        @throw exception;
        //给出提示信息
        [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
    }
}
@end
