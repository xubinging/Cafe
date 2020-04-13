//
//  SecurityModifyPwdCheckSlctVC.m
//  Cafe
//
//  Created by leo on 2020/1/2.
//  Copyright © 2020 leo. All rights reserved.
//
//  身份验证

#import "SecurityModifyPwdCheckSlctVC.h"

#import "SecurityModifyPwdCheckPhoneVC.h"   //验证手机号
#import "SecurityModifyPwdCheckPwdVC.h"     //原始密码认证

@interface SecurityModifyPwdCheckSlctVC ()

{
    @private UIButton *backButton;          //左上角返回按钮
    @private UIView *navigationView;
}

@property (nonatomic, strong) UIView *checkPhoneView;
@property (nonatomic, strong) UIView *checkOriginalPwdView;

@end

@implementation SecurityModifyPwdCheckSlctVC

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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"身份验证" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
}

#pragma mark - 初始化视图 -
-(void)initView
{
    UILabel *explainLabel = [[UILabel alloc] init];
    [self.view addSubview:explainLabel];
    [explainLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    explainLabel.numberOfLines = 0;
    explainLabel.textAlignment = NSTextAlignmentLeft;
    explainLabel.alpha = 1.0;
    NSMutableAttributedString *explainLabelString = [[NSMutableAttributedString alloc] initWithString:@"请先进行身份验证"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    explainLabel.attributedText = explainLabelString;
    
    
    //***** 手机验证码验证 *****//
    _checkPhoneView = [UIView new];
    [self.view addSubview:_checkPhoneView];
    [_checkPhoneView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(explainLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_checkPhoneView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *checkPhoneTitleLabel = [UILabel new];
    [_checkPhoneView addSubview:checkPhoneTitleLabel];
    [checkPhoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_checkPhoneView).offset(13);
        make.left.equalTo(_checkPhoneView).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 22));
    }];
    checkPhoneTitleLabel.numberOfLines = 0;
    checkPhoneTitleLabel.textAlignment = NSTextAlignmentLeft;
    checkPhoneTitleLabel.alpha = 1.0;
    NSMutableAttributedString *checkPhoneTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"手机验证码验证"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    checkPhoneTitleLabel.attributedText = checkPhoneTitleLabelString;
    
    UIImageView *nextStep1 = [UIImageView new];
    [_checkPhoneView addSubview:nextStep1];
    [nextStep1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_checkPhoneView).offset(17);
        make.right.equalTo(_checkPhoneView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [nextStep1 setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    //分割线
    UIView *splitView = [UIView new];
    [_checkPhoneView addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(_checkPhoneView.mas_bottom).offset(-1);
        make.left.equalTo(_checkPhoneView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    [splitView setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
    
    
    //***** 原始密码验证 *****//
    _checkOriginalPwdView = [UIView new];
    [self.view addSubview:_checkOriginalPwdView];
    [_checkOriginalPwdView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_checkPhoneView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
    }];
    [_checkOriginalPwdView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *checkOriginalPwdTitleLabel = [UILabel new];
    [_checkOriginalPwdView addSubview:checkOriginalPwdTitleLabel];
    [checkOriginalPwdTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_checkOriginalPwdView).offset(13);
        make.left.equalTo(_checkOriginalPwdView).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 22));
    }];
    checkOriginalPwdTitleLabel.numberOfLines = 0;
    checkOriginalPwdTitleLabel.textAlignment = NSTextAlignmentLeft;
    checkOriginalPwdTitleLabel.alpha = 1.0;
    NSMutableAttributedString *checkOriginalPwdTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"原始密码验证"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    checkOriginalPwdTitleLabel.attributedText = checkOriginalPwdTitleLabelString;
    
    UIImageView *nextStep2 = [UIImageView new];
    [_checkOriginalPwdView addSubview:nextStep2];
    [nextStep2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_checkOriginalPwdView).offset(17);
        make.right.equalTo(_checkOriginalPwdView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [nextStep2 setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{

    _checkPhoneView.userInteractionEnabled = YES;
    UITapGestureRecognizer *checkPhoneViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkPhoneViewClick)];
    [_checkPhoneView addGestureRecognizer:checkPhoneViewTapGesture];

    _checkOriginalPwdView.userInteractionEnabled = YES;
    UITapGestureRecognizer *checkOriginalPwdViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkOriginalPwdViewClick)];
    [_checkOriginalPwdView addGestureRecognizer:checkOriginalPwdViewTapGesture];
    
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 验证手机号码 -
-(void)checkPhoneViewClick
{
    SecurityModifyPwdCheckPhoneVC *securityModifyPwdCheckPhoneVC = [SecurityModifyPwdCheckPhoneVC new];

    [self.navigationController pushViewController:securityModifyPwdCheckPhoneVC animated:YES];
}

#pragma mark - 验证原始密码 -
-(void)checkOriginalPwdViewClick
{
    SecurityModifyPwdCheckPwdVC *securityModifyPwdCheckPwdVC = [SecurityModifyPwdCheckPwdVC new];

    [self.navigationController pushViewController:securityModifyPwdCheckPwdVC animated:YES];
}

@end
