//
//  SystemSettingSecurityViewController.m
//  Cafe
//
//  Created by leo on 2020/1/2.
//  Copyright © 2020 leo. All rights reserved.
//
//  账号与安全

#import "SystemSettingSecurityViewController.h"

#import "SecurityModifyPhoneVC.h"           //更换手机号
#import "SecurityModifyPwdCheckSlctVC.h"    //选择验证方式

@interface SystemSettingSecurityViewController ()

{
    @private UIButton *backButton;          //左上角返回按钮
    @private UIView *navigationView;
    
    @private NSString *name;
    @private NSString *phone;
    @private NSString *email;
}

@property (nonatomic, strong) UIView *nameView;         //用户名
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *phoneView;        //手机号码
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UIView *emailView;        //邮箱
@property (nonatomic, strong) UILabel *emailLabel;

@property (nonatomic, strong) UIView *modifyPwdView;    //修改登录密码

@end

@implementation SystemSettingSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self setListener];
    [self setData];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);

    name = _UserInfo.userName;
    phone = _UserInfo.phoneNumber;
    email = _UserInfo.email;
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"账号与安全" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //***** 用户名 *****//
    _nameView = [UIView new];
    [self.view addSubview:_nameView];
    [_nameView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_nameView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *nameTitleLabel = [UILabel new];
    [_nameView addSubview:nameTitleLabel];
    [nameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_nameView).offset(13);
        make.left.equalTo(_nameView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    nameTitleLabel.numberOfLines = 0;
    nameTitleLabel.textAlignment = NSTextAlignmentLeft;
    nameTitleLabel.alpha = 1.0;
    NSMutableAttributedString *nameTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"用户名"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    nameTitleLabel.attributedText = nameTitleLabelString;
    
    _nameLabel = [UILabel new];
    [_nameView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_nameView).offset(14);
        make.right.equalTo(_nameView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 10 - 100 - 10 - 20, 20));
    }];
    _nameLabel.numberOfLines = 0;
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.alpha = 1.0;
    
    //分割线
    UIView *splitView1 = [UIView new];
    [_nameView addSubview:splitView1];
    [splitView1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(_nameView.mas_bottom).offset(-1);
        make.left.equalTo(_nameView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    [splitView1 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
    
    
    //***** 手机号码 *****//
    _phoneView = [UIView new];
    [self.view addSubview:_phoneView];
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_nameView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_phoneView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *phoneTitleLabel = [UILabel new];
    [_phoneView addSubview:phoneTitleLabel];
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_phoneView).offset(13);
        make.left.equalTo(_phoneView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    phoneTitleLabel.numberOfLines = 0;
    phoneTitleLabel.textAlignment = NSTextAlignmentLeft;
    phoneTitleLabel.alpha = 1.0;
    NSMutableAttributedString *phoneTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"手机号码"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    phoneTitleLabel.attributedText = phoneTitleLabelString;
    
    _phoneLabel = [UILabel new];
    [_phoneView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_phoneView).offset(14);
        make.right.equalTo(_phoneView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 10 - 100 - 10 - 20, 20));
    }];
    _phoneLabel.numberOfLines = 0;
    _phoneLabel.textAlignment = NSTextAlignmentRight;
    _phoneLabel.alpha = 1.0;
    
    //分割线
    UIView *splitView2 = [UIView new];
    [_phoneView addSubview:splitView2];
    [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(_phoneView.mas_bottom).offset(-1);
        make.left.equalTo(_phoneView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    [splitView2 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
    
    //***** 邮箱 *****//
    _emailView = [UIView new];
    [self.view addSubview:_emailView];
    [_emailView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_phoneView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_emailView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *emailTitleLabel = [UILabel new];
    [_emailView addSubview:emailTitleLabel];
    [emailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_emailView).offset(13);
        make.left.equalTo(_emailView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    emailTitleLabel.numberOfLines = 0;
    emailTitleLabel.textAlignment = NSTextAlignmentLeft;
    emailTitleLabel.alpha = 1.0;
    NSMutableAttributedString *emailTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"邮箱"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    emailTitleLabel.attributedText = emailTitleLabelString;
    
    UIImageView *nextStep1 = [UIImageView new];
    [_emailView addSubview:nextStep1];
    [nextStep1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_emailView).offset(17);
        make.right.equalTo(_emailView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [nextStep1 setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    _emailLabel = [UILabel new];
    [_emailView addSubview:_emailLabel];
    [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_emailView).offset(14);
        make.right.equalTo(_emailView).offset(-26);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 10 - 100 - 26 - 20, 20));
    }];
    _emailLabel.numberOfLines = 0;
    _emailLabel.textAlignment = NSTextAlignmentRight;
    _emailLabel.alpha = 1.0;
    
    //分割线
    UIView *splitView3 = [UIView new];
    [_emailView addSubview:splitView3];
    [splitView3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(_emailView.mas_bottom).offset(-1);
        make.left.equalTo(_emailView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    [splitView3 setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
    
    
    //***** 修改登录密码 *****//
    _modifyPwdView = [UIView new];
    [self.view addSubview:_modifyPwdView];
    [_modifyPwdView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_emailView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_modifyPwdView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *modifyPwdTitleLabel = [UILabel new];
    [_modifyPwdView addSubview:modifyPwdTitleLabel];
    [modifyPwdTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_modifyPwdView).offset(13);
        make.left.equalTo(_modifyPwdView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 22));
    }];
    modifyPwdTitleLabel.numberOfLines = 0;
    modifyPwdTitleLabel.textAlignment = NSTextAlignmentLeft;
    modifyPwdTitleLabel.alpha = 1.0;
    NSMutableAttributedString *modifyPwdTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"修改登录密码"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    modifyPwdTitleLabel.attributedText = modifyPwdTitleLabelString;
    
    UIImageView *nextStep2 = [UIImageView new];
    [_modifyPwdView addSubview:nextStep2];
    [nextStep2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_modifyPwdView).offset(17);
        make.right.equalTo(_modifyPwdView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [nextStep2 setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    
    //用户名
    _nameView.userInteractionEnabled = YES;
    UITapGestureRecognizer *nameViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameViewClick)];
    [_nameView addGestureRecognizer:nameViewTapGesture];
    
    //手机号码
    _phoneView.userInteractionEnabled = YES;
    UITapGestureRecognizer *phoneViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneViewClick)];
    [_phoneView addGestureRecognizer:phoneViewTapGesture];
    
    //邮箱
    _emailView.userInteractionEnabled = YES;
    UITapGestureRecognizer *emailViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emailViewClick)];
    [_emailView addGestureRecognizer:emailViewTapGesture];
    
    //修改登录密码
    _modifyPwdView.userInteractionEnabled = YES;
    UITapGestureRecognizer *modifyPwdViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modifyPwdViewClick)];
    [_modifyPwdView addGestureRecognizer:modifyPwdViewTapGesture];
    
}

#pragma mark - 设置参数 -
-(void)setData
{
    
    NSMutableAttributedString *nameLabelString = [[NSMutableAttributedString alloc] initWithString:name attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    _nameLabel.attributedText = nameLabelString;

    NSMutableAttributedString *phoneLabelString = [[NSMutableAttributedString alloc] initWithString:phone attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    _phoneLabel.attributedText = phoneLabelString;
    
    if([email isEqualToString:@""]){
        NSMutableAttributedString *emailLabelString = [[NSMutableAttributedString alloc] initWithString:@"未设置" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]}];
        _emailLabel.attributedText = emailLabelString;
        
    }else{
        NSMutableAttributedString *emailLabelString = [[NSMutableAttributedString alloc] initWithString:email attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
        _emailLabel.attributedText = emailLabelString;
        
    }
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 用户名 -
-(void)nameViewClick
{
    
}

#pragma mark - 手机号 -
-(void)phoneViewClick
{
    SecurityModifyPhoneVC *securityModifyPhoneVC = [SecurityModifyPhoneVC new];

    [self.navigationController pushViewController:securityModifyPhoneVC animated:YES];
}

#pragma mark - 邮箱 -
-(void)emailViewClick
{
    
}

#pragma mark - 修改登录密码 -
-(void)modifyPwdViewClick
{
    SecurityModifyPwdCheckSlctVC *securityModifyPwdCheckSlctVC = [SecurityModifyPwdCheckSlctVC new];

    [self.navigationController pushViewController:securityModifyPwdCheckSlctVC animated:YES];
}

@end
