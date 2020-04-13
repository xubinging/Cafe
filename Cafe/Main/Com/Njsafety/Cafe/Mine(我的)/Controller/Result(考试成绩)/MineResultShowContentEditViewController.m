//
//  MineResultShowContentEditViewController.m
//  Cafe
//
//  Created by leo on 2020/1/7.
//  Copyright © 2020 leo. All rights reserved.
//
//  编辑考试地点、参加的培训机构及各项分数等内容

#import "MineResultShowContentEditViewController.h"

@interface MineResultShowContentEditViewController ()

{
    @private UIButton *backButton;              //左上角返回按钮
    @private UIButton *saveButton;              //右上角保存按钮
    
    @private UIView *navigationView;
    
    @private UILabel *titleLabel;               //标题标签
    @private UITextField *contentTextField;     //内容输入框
    @private UIButton *contentClearButton;      //内容清空按钮
    
    @private NSString *title;                   //标题
    @private NSString *content;                 //内容
}

@end

@implementation MineResultShowContentEditViewController

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
    if(!(_dataDic[@"title"] == nil)){
        title = _dataDic[@"title"];
        
    }else{
        title = @"";
    }
    
    if(!(_dataDic[@"content"] == nil)){
        content = _dataDic[@"content"];
        
    }else{
        content = @"";
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
    
    //右上角保存按钮
    saveButton = [UIButton new];
    [navigationView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(navigationView).offset(-10);
        make.bottom.equalTo(navigationView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(28, 20));
    }];
    //设置点击不变色
    saveButton.adjustsImageWhenHighlighted = NO;
    NSMutableAttributedString *saveButtonString = [[NSMutableAttributedString alloc] initWithString:@"保存"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [saveButton setAttributedTitle:saveButtonString forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //标题
    titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(16);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.alpha = 1.0;
    
    //分割线
    UIView *splitView = [UIView new];
    [self.view addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(107);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    [splitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    //清空按钮
    contentClearButton = [UIButton new];
    [self.view addSubview:contentClearButton];
    [contentClearButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(73);
        make.right.equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    //设置点击不变色
    contentClearButton.adjustsImageWhenHighlighted = NO;
    [contentClearButton setBackgroundImage:[UIImage imageNamed:@"login_del"] forState:UIControlStateNormal];
    
    
    //用户输入框
    contentTextField = [UITextField new];
    [self.view addSubview:contentTextField];
    [contentTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(71);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(contentClearButton.mas_left).offset(-10);
        make.height.equalTo(@20);
    }];
    [contentTextField setTextAlignment:NSTextAlignmentLeft];
    contentTextField.clearButtonMode = UITextFieldViewModeNever;
    contentTextField.borderStyle = UITextBorderStyleNone;
    //设置输入后文字样式
    [contentTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [contentTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //清除用户账户信息按钮
    if([content isEqualToString:@""]){
        contentClearButton.hidden = YES;
    }
    [contentClearButton addTarget:self action:@selector(contentClearButtonClick) forControlEvents:UIControlEventTouchUpInside];

    //用户信息文本框监听
    [contentTextField becomeFirstResponder];
    [contentTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - 设置参数 -
-(void)setData
{
    //设置占位文字样式
    NSMutableAttributedString *tfPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入内容" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    contentTextField.attributedPlaceholder = tfPlaceholderString;
    
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:title attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
    [contentTextField setText:content];
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    //去除首尾空格
    NSString *contentStr = [contentTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([contentStr isEqualToString:@""]){
        [AvalonsoftToast showWithMessage:@"内容不可以为空"];
        return;
    }
    
    content = contentStr;
    //模拟保存成功
    [AvalonsoftToast showWithMessage:@"保存成功" image:@"login_success" duration:1];
    
    //延迟推出
    [self performSelector:@selector(modifySuccess) withObject:nil afterDelay:1.5];
}

-(void)modifySuccess{
    //设置回调
    NSDictionary *sendDataDic = @{@"content":content};
    //Block传值step 3:传值类将要传的值传入自己的block中
    self.sendValueBlock(sendDataDic);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - userClearButton点击事件 -
-(void)contentClearButtonClick
{
    [contentTextField setText:@""];
    
    contentClearButton.hidden = YES;
}

#pragma mark - 输入框监听 -
-(void)textFieldDidChange
{
    //判断清空用户信息按钮是否显示
    if(![contentTextField.text isEqualToString:@""]){
        //不为空
        contentClearButton.hidden = NO;
        
    }else{
        contentClearButton.hidden = YES;
        
    }
}

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [contentTextField resignFirstResponder];
}


@end
