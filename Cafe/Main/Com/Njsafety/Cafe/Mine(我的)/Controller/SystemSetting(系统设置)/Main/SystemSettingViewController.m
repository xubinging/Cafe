//
//  SystemSettingViewController.m
//  Cafe
//
//  Created by leo on 2020/1/1.
//  Copyright © 2020 leo. All rights reserved.
//
//  系统设置

#import "SystemSettingViewController.h"

#import "SystemSettingPersonalDataViewController.h"     //个人资料
#import "SystemSettingSecurityViewController.h"         //账号与安全
#import "SystemSettingMessageViewController.h"          //消息与推送通知
#import "SystemSettingPlatformViewController.h"         //关于平台

@interface SystemSettingViewController ()

{
    @private UIButton *backButton;          //左上角返回按钮
}

@property (nonatomic, strong) UIView *personalDataView;     //个人资料
@property (nonatomic, strong) UIView *securityView;         //账号与安全
@property (nonatomic, strong) UIView *messageView;          //消息与推送通知
@property (nonatomic, strong) UIView *promptToneView;       //提示音
@property (nonatomic, strong) UIView *platformView;         //关于平台
@property (nonatomic, strong) UILabel *versionLabel;        //清理本地缓存按钮
@property (nonatomic, strong) UIView *cleanCacheView;       //清理本地缓存
@property (nonatomic, strong) UILabel *cleanCacheLabel;     //清理本地缓存按钮
@property (nonatomic, strong) UIView *logoutView;           //退出登录

@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initView];
    [self setListener];
    [self setVeision];
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

#pragma mark - 初始化视图 -
-(void)initView
{
    //1.顶部导航视图
    UIView *navigationView = [UIView new];
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
    
    //标题
    UILabel *titleLabel = [UILabel new];
    [navigationView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-100)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"系统设置"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
    //个人资料
    _personalDataView = [UIView new];
    [self.view addSubview:_personalDataView];
    [_personalDataView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_personalDataView setBackgroundColor:RGBA_GGCOLOR(255, 255, 255, 1)];
    
    UILabel *personalDataLabel = [UILabel new];
    [_personalDataView addSubview:personalDataLabel];
    [personalDataLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_personalDataView);
        make.left.equalTo(_personalDataView).offset(10);;
        make.size.mas_equalTo(CGSizeMake(150, 48));
    }];
    personalDataLabel.numberOfLines = 0;
    personalDataLabel.textAlignment = NSTextAlignmentLeft;
    personalDataLabel.alpha = 1.0;
    NSMutableAttributedString *personalDataLabelString = [[NSMutableAttributedString alloc] initWithString:@"个人资料" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    personalDataLabel.attributedText = personalDataLabelString;
    
    UIImageView *personalDataNextStep = [UIImageView new];
    [_personalDataView addSubview:personalDataNextStep];
    [personalDataNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_personalDataView).offset(17);
        make.right.equalTo(_personalDataView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [personalDataNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    //分割线
    UIView *splitView = [UIView new];
    [self.view addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_personalDataView).offset(47);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    [splitView setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
    
    //账号与安全
    _securityView = [UIView new];
    [self.view addSubview:_securityView];
    [_securityView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_personalDataView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_securityView setBackgroundColor:RGBA_GGCOLOR(255, 255, 255, 1)];
    
    UILabel *securityLabel = [UILabel new];
    [_securityView addSubview:securityLabel];
    [securityLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_securityView);
        make.left.equalTo(_securityView).offset(10);;
        make.size.mas_equalTo(CGSizeMake(150, 48));
    }];
    securityLabel.numberOfLines = 0;
    securityLabel.textAlignment = NSTextAlignmentLeft;
    securityLabel.alpha = 1.0;
    NSMutableAttributedString *securityLabelString = [[NSMutableAttributedString alloc] initWithString:@"账号与安全" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    securityLabel.attributedText = securityLabelString;
    
    UIImageView *securityNextStep = [UIImageView new];
    [_securityView addSubview:securityNextStep];
    [securityNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_securityView).offset(17);
        make.right.equalTo(_securityView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [securityNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    //消息与推送通知
    _messageView = [UIView new];
    [self.view addSubview:_messageView];
    [_messageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_securityView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_messageView setBackgroundColor:RGBA_GGCOLOR(255, 255, 255, 1)];
    
    UILabel *messageLabel = [UILabel new];
    [_messageView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_messageView);
        make.left.equalTo(_messageView).offset(10);;
        make.size.mas_equalTo(CGSizeMake(150, 48));
    }];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentLeft;
    messageLabel.alpha = 1.0;
    NSMutableAttributedString *messageLabelString = [[NSMutableAttributedString alloc] initWithString:@"消息与推送通知" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    messageLabel.attributedText = messageLabelString;
    
    UIImageView *messageNextStep = [UIImageView new];
    [_messageView addSubview:messageNextStep];
    [messageNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_messageView).offset(17);
        make.right.equalTo(_messageView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [messageNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    //提示音
    _promptToneView = [UIView new];
    [self.view addSubview:_promptToneView];
    [_promptToneView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_messageView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_promptToneView setBackgroundColor:RGBA_GGCOLOR(255, 255, 255, 1)];
    
    UILabel *promptToneLabel = [UILabel new];
    [_promptToneView addSubview:promptToneLabel];
    [promptToneLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_promptToneView);
        make.left.equalTo(_promptToneView).offset(10);;
        make.size.mas_equalTo(CGSizeMake(150, 48));
    }];
    promptToneLabel.numberOfLines = 0;
    promptToneLabel.textAlignment = NSTextAlignmentLeft;
    promptToneLabel.alpha = 1.0;
    NSMutableAttributedString *promptToneLabelString = [[NSMutableAttributedString alloc] initWithString:@"提示音" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    promptToneLabel.attributedText = promptToneLabelString;
    
    //提示音开关按钮
    UISwitch *promptToneSwitch = [UISwitch new];
    [_promptToneView addSubview:promptToneSwitch];
    [promptToneSwitch mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_promptToneView).offset(9);
        make.right.equalTo(_promptToneView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
//    // 设置控件开启状态填充色
//    promptToneSwitch.onTintColor = RGBA_GGCOLOR(52, 199, 92, 1);
//    // 设置控件关闭状态填充色
//    promptToneSwitch.tintColor = RGBA_GGCOLOR(0, 0, 0, 1);
//    // 设置控件开关按钮颜色
//    promptToneSwitch.thumbTintColor = [UIColor whiteColor];
    // 当控件值变化时触发changeColor方法
    [promptToneSwitch addTarget:self action:@selector(promptToneSwitchChange:) forControlEvents:UIControlEventValueChanged];
    
    //关于平台
    _platformView = [UIView new];
    [self.view addSubview:_platformView];
    [_platformView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_promptToneView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_platformView setBackgroundColor:RGBA_GGCOLOR(255, 255, 255, 1)];
    
    UILabel *platformLabel = [UILabel new];
    [_platformView addSubview:platformLabel];
    [platformLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_platformView);
        make.left.equalTo(_platformView).offset(10);;
        make.size.mas_equalTo(CGSizeMake(150, 48));
    }];
    platformLabel.numberOfLines = 0;
    platformLabel.textAlignment = NSTextAlignmentLeft;
    platformLabel.alpha = 1.0;
    NSMutableAttributedString *platformLabelString = [[NSMutableAttributedString alloc] initWithString:@"关于平台" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    platformLabel.attributedText = platformLabelString;
    
    _versionLabel = [UILabel new];
    [_platformView addSubview:_versionLabel];
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_platformView).offset(14);
        make.right.equalTo(_platformView).offset(-26);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    [_versionLabel setTextAlignment:NSTextAlignmentRight];
    
    UIImageView *platformNextStep = [UIImageView new];
    [_platformView addSubview:platformNextStep];
    [platformNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_platformView).offset(17);
        make.right.equalTo(_platformView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [platformNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    //清理本地缓存
    _cleanCacheView = [UIView new];
    [self.view addSubview:_cleanCacheView];
    [_cleanCacheView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_platformView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_cleanCacheView setBackgroundColor:RGBA_GGCOLOR(255, 255, 255, 1)];
    
    _cleanCacheLabel = [UILabel new];
    [_cleanCacheView addSubview:_cleanCacheLabel];
    [_cleanCacheLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_cleanCacheView).offset(13);
        make.left.equalTo(_cleanCacheView).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 22));
    }];
    NSMutableAttributedString *cleanCacheString = [[NSMutableAttributedString alloc] initWithString:@"清理本地缓存"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [_cleanCacheLabel setAttributedText:cleanCacheString];
    [_cleanCacheLabel setTextAlignment:NSTextAlignmentLeft];

    //退出登录
    _logoutView = [UIView new];
    [self.view addSubview:_logoutView];
    [_logoutView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_cleanCacheView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-355)/2);
        make.size.mas_equalTo(CGSizeMake(355, 46));
    }];
    _logoutView.layer.cornerRadius = 25;
    
    [self.view layoutIfNeeded];
    //CAGradientLayer实现颜色渐变
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = _logoutView.bounds;
    gl.cornerRadius = 25;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [_logoutView.layer addSublayer:gl];
    
    //11-1.注册 文字标签
    UILabel *logoutLabel = [UILabel new];
    [_logoutView addSubview:logoutLabel];
    [logoutLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_logoutView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-64)/2);
        make.size.mas_equalTo(CGSizeMake(64, 22));
    }];
    logoutLabel.numberOfLines = 0;
    logoutLabel.textAlignment = NSTextAlignmentCenter;
    logoutLabel.alpha = 1.0;
    NSMutableAttributedString *logoutLabelString = [[NSMutableAttributedString alloc] initWithString:@"退出登录"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    logoutLabel.attributedText = logoutLabelString;
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //个人资料
    _personalDataView.userInteractionEnabled = YES;
    UITapGestureRecognizer *personalDataViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalDataViewClick)];
    [_personalDataView addGestureRecognizer:personalDataViewTapGesture];
    
    //账号与安全
    _securityView.userInteractionEnabled = YES;
    UITapGestureRecognizer *securityViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(securityViewClick)];
    [_securityView addGestureRecognizer:securityViewTapGesture];
    
    //消息与推送通知
    _messageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *messageViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageViewClick)];
    [_messageView addGestureRecognizer:messageViewTapGesture];
    
    //关于平台
    _platformView.userInteractionEnabled = YES;
    UITapGestureRecognizer *platformViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(platformViewClick)];
    [_platformView addGestureRecognizer:platformViewTapGesture];
    
    //清理本地缓存按钮
    _cleanCacheLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *cleanCacheLabelTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cleanCacheLabelClick)];
    [_cleanCacheLabel addGestureRecognizer:cleanCacheLabelTapGesture];
    
    //退出登录
    _logoutView.userInteractionEnabled = YES;
    UITapGestureRecognizer *logoutViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoutViewClick)];
    [_logoutView addGestureRecognizer:logoutViewTapGesture];
    
}

-(void)setVeision
{
    NSMutableAttributedString *versionLabelString = [[NSMutableAttributedString alloc] initWithString:@"版本 1.0.1"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]}];

    _versionLabel.attributedText = versionLabelString;
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 个人资料 -
-(void)personalDataViewClick
{
    SystemSettingPersonalDataViewController *personalDataVC = [SystemSettingPersonalDataViewController new];

    [self.navigationController pushViewController:personalDataVC animated:YES];
}

#pragma mark - 账号与安全 -
-(void)securityViewClick
{
    SystemSettingSecurityViewController *securityVC = [SystemSettingSecurityViewController new];

    [self.navigationController pushViewController:securityVC animated:YES];
}

#pragma mark - 消息与推送通知 -
-(void)messageViewClick
{
    SystemSettingMessageViewController *messageVC = [SystemSettingMessageViewController new];

    [self.navigationController pushViewController:messageVC animated:YES];

}

#pragma mark - 关于平台 -
-(void)platformViewClick
{
    SystemSettingPlatformViewController *platformVC = [SystemSettingPlatformViewController new];

    [self.navigationController pushViewController:platformVC animated:YES];
}

#pragma mark - 清理本地缓存按钮 -
-(void)cleanCacheLabelClick
{
    AvalonsoftMsgAlertView *alertView = [AvalonsoftMsgAlertView showWithTitle:@"确定清理本地缓存？" content:@"" buttonTitles:@[@"取消",@"确定"] buttonClickedBlock:^(NSInteger buttonIndex){
        
        if(buttonIndex == 1){
            [AvalonsoftToast showWithMessage:@"清理本地缓存"];
        }
        
    }];
    [alertView setMainButtonIndex:1];
}

#pragma mark - 退出登录 -
-(void)logoutViewClick
{
    AvalonsoftMsgAlertView *alertView = [AvalonsoftMsgAlertView showWithTitle:@"提示" content:@"确定退出登录？" buttonTitles:@[@"取消",@"确定"] buttonClickedBlock:^(NSInteger buttonIndex){
        
        if(buttonIndex == 1){
            [AvalonsoftToast showWithMessage:@"退出登录"];
        }
        
    }];
    [alertView setMainButtonIndex:1];
}

#pragma mark - 提示音开关 -
-(void)promptToneSwitchChange:(UISwitch *)swi{
    if(swi.isOn){
        [AvalonsoftToast showWithMessage:@"提示音打开"];
        
    }else{
        [AvalonsoftToast showWithMessage:@"提示音关闭"];
    }
}

@end
