//
//  SystemSettingMessageViewController.m
//  Cafe
//
//  Created by leo on 2020/1/1.
//  Copyright © 2020 leo. All rights reserved.
//
//  消息与推送通知

#import "SystemSettingMessageViewController.h"

@interface SystemSettingMessageViewController ()

{
    @private UIButton *backButton;          //左上角返回按钮
}

@end

@implementation SystemSettingMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initView];
    [self setListener];
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
    //***** 顶部导航视图 *****//
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
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-120)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"消息与推送通知"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
    //***** 消息 *****//
    UILabel *userMessageLabel = [UILabel new];
    [self.view addSubview:userMessageLabel];
    [userMessageLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 18));
    }];
    userMessageLabel.numberOfLines = 0;
    userMessageLabel.textAlignment = NSTextAlignmentLeft;
    userMessageLabel.alpha = 1.0;
    NSMutableAttributedString *userMessageLabelString = [[NSMutableAttributedString alloc] initWithString:@"消息"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    userMessageLabel.attributedText = userMessageLabelString;
    
    //用户消息提醒
    UIView *userMessagView = [UIView new];
    [self.view addSubview:userMessagView];
    [userMessagView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userMessageLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
    }];
    userMessagView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    
    UILabel *userMessagViewTitleLabel = [UILabel new];
    [userMessagView addSubview:userMessagViewTitleLabel];
    [userMessagViewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userMessagView).offset(13);
        make.left.equalTo(userMessagView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    userMessagViewTitleLabel.numberOfLines = 0;
    userMessagViewTitleLabel.textAlignment = NSTextAlignmentLeft;
    userMessagViewTitleLabel.alpha = 1.0;
    NSMutableAttributedString *userMessagViewTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"用户消息提醒"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    userMessagViewTitleLabel.attributedText = userMessagViewTitleLabelString;
    
    UILabel *userMessagViewContentLabel = [UILabel new];
    [userMessagView addSubview:userMessagViewContentLabel];
    [userMessagViewContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(userMessagView).offset(-13);
        make.left.equalTo(userMessagView).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 18));
    }];
    userMessagViewContentLabel.numberOfLines = 0;
    userMessagViewContentLabel.textAlignment = NSTextAlignmentLeft;
    userMessagViewContentLabel.alpha = 1.0;
    NSMutableAttributedString *userMessagViewContentLabelString = [[NSMutableAttributedString alloc] initWithString:@"赞过、被赞、回复的消息"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]}];
    userMessagViewContentLabel.attributedText = userMessagViewContentLabelString;
    
    //用户消息提醒开关
    UISwitch *userMessagSwitch = [UISwitch new];
    [userMessagView addSubview:userMessagSwitch];
    [userMessagSwitch mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userMessagView).offset(20);
        make.right.equalTo(userMessagView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [userMessagSwitch addTarget:self action:@selector(userMessagSwitchChange:) forControlEvents:UIControlEventValueChanged];

    //***** 推送 *****//
    UILabel *sendLabel = [UILabel new];
    [self.view addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userMessagView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 18));
    }];
    sendLabel.numberOfLines = 0;
    sendLabel.textAlignment = NSTextAlignmentLeft;
    sendLabel.alpha = 1.0;
    NSMutableAttributedString *sendLabelString = [[NSMutableAttributedString alloc] initWithString:@"推送"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    sendLabel.attributedText = sendLabelString;
    
    //互动消息
    UIView *interactMessagView = [UIView new];
    [self.view addSubview:interactMessagView];
    [interactMessagView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(sendLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 56));
    }];
    interactMessagView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    
    UILabel *interactMessagViewTitleLabel = [UILabel new];
    [interactMessagView addSubview:interactMessagViewTitleLabel];
    [interactMessagViewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(interactMessagView).offset(18);
        make.left.equalTo(interactMessagView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    interactMessagViewTitleLabel.numberOfLines = 0;
    interactMessagViewTitleLabel.textAlignment = NSTextAlignmentLeft;
    interactMessagViewTitleLabel.alpha = 1.0;
    NSMutableAttributedString *interactMessagViewTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"互动消息"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    interactMessagViewTitleLabel.attributedText = interactMessagViewTitleLabelString;
    
    //互动消息开关
    UISwitch *interactMessagSwitch = [UISwitch new];
    [interactMessagView addSubview:interactMessagSwitch];
    [interactMessagSwitch mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(interactMessagView).offset(12);
        make.right.equalTo(interactMessagView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [interactMessagSwitch addTarget:self action:@selector(interactMessagSwitchChange:) forControlEvents:UIControlEventValueChanged];
    
    //分割线1
    UIView *splitView1 = [UIView new];
    [interactMessagView addSubview:splitView1];
    [splitView1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(interactMessagView.mas_bottom).offset(-1);
        make.left.equalTo(interactMessagView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    [splitView1 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
    
    //动态更新提醒
    UIView *renewMessagView = [UIView new];
    [self.view addSubview:renewMessagView];
    [renewMessagView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(interactMessagView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 56));
    }];
    renewMessagView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    
    UILabel *renewMessagViewTitleLabel = [UILabel new];
    [renewMessagView addSubview:renewMessagViewTitleLabel];
    [renewMessagViewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(renewMessagView).offset(18);
        make.left.equalTo(renewMessagView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    renewMessagViewTitleLabel.numberOfLines = 0;
    renewMessagViewTitleLabel.textAlignment = NSTextAlignmentLeft;
    renewMessagViewTitleLabel.alpha = 1.0;
    NSMutableAttributedString *renewMessagViewTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"动态更新提醒"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    renewMessagViewTitleLabel.attributedText = renewMessagViewTitleLabelString;
    
    //动态更新提醒开关
    UISwitch *renewMessagSwitch = [UISwitch new];
    [renewMessagView addSubview:renewMessagSwitch];
    [renewMessagSwitch mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(renewMessagView).offset(12);
        make.right.equalTo(renewMessagView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [renewMessagSwitch addTarget:self action:@selector(renewMessagSwitchChange:) forControlEvents:UIControlEventValueChanged];
    
    //分割线2
    UIView *splitView2 = [UIView new];
    [renewMessagView addSubview:splitView2];
    [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(renewMessagView.mas_bottom).offset(-1);
        make.left.equalTo(renewMessagView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    [splitView2 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
    
    //系统通知
    UIView *systemMessagView = [UIView new];
    [self.view addSubview:systemMessagView];
    [systemMessagView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(renewMessagView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 56));
    }];
    systemMessagView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    
    UILabel *systemMessagViewTitleLabel = [UILabel new];
    [systemMessagView addSubview:systemMessagViewTitleLabel];
    [systemMessagViewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(systemMessagView).offset(18);
        make.left.equalTo(systemMessagView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    systemMessagViewTitleLabel.numberOfLines = 0;
    systemMessagViewTitleLabel.textAlignment = NSTextAlignmentLeft;
    systemMessagViewTitleLabel.alpha = 1.0;
    NSMutableAttributedString *systemMessagViewTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"系统通知"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    systemMessagViewTitleLabel.attributedText = systemMessagViewTitleLabelString;
    
    //动态更新提醒开关
    UISwitch *systemMessagSwitch = [UISwitch new];
    [systemMessagView addSubview:systemMessagSwitch];
    [systemMessagSwitch mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(systemMessagView).offset(12);
        make.right.equalTo(systemMessagView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [systemMessagSwitch addTarget:self action:@selector(systemMessagSwitchChange:) forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 用户消息提醒开关 -
-(void)userMessagSwitchChange:(UISwitch *)swi{
    if(swi.isOn){
        [AvalonsoftToast showWithMessage:@"用户消息提醒打开"];
        
    }else{
        [AvalonsoftToast showWithMessage:@"用户消息提醒关闭"];
    }
}

#pragma mark - 互动消息开关 -
-(void)interactMessagSwitchChange:(UISwitch *)swi{
    if(swi.isOn){
        [AvalonsoftToast showWithMessage:@"互动消息打开"];
        
    }else{
        [AvalonsoftToast showWithMessage:@"互动消息关闭"];
    }
}

#pragma mark - 动态更新提醒 -
-(void)renewMessagSwitchChange:(UISwitch *)swi{
    if(swi.isOn){
        [AvalonsoftToast showWithMessage:@"动态更新提醒打开"];
        
    }else{
        [AvalonsoftToast showWithMessage:@"动态更新提醒关闭"];
    }
}

#pragma mark - 系统通知 -
-(void)systemMessagSwitchChange:(UISwitch *)swi{
    if(swi.isOn){
        [AvalonsoftToast showWithMessage:@"系统通知打开"];
        
    }else{
        [AvalonsoftToast showWithMessage:@"系统通知关闭"];
    }
}

@end
