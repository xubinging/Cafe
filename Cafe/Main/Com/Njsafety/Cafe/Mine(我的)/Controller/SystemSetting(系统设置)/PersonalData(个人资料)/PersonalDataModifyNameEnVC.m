//
//  PersonalDataModifyNameEnVC.m
//  Cafe
//
//  Created by gexy on 2020/3/14.
//  Copyright © 2020 leo. All rights reserved.
//

#import "PersonalDataModifyNameEnVC.h"

@interface PersonalDataModifyNameEnVC ()

{
    @private UIButton *backButton;              //左上角返回按钮
    @private UIButton *saveButton;              //右上角保存按钮
    
    @private UIView *navigationView;
    
    @private UITextField *nameEnTextField;    //英文名输入框
    @private UIButton *nameEnClearButton;     //清空英文名按钮
    
    @private NSString *nameEn;                //英文名
}
@end

@implementation PersonalDataModifyNameEnVC

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
    if(!(_dataDic[@"nameEn"] == nil)){
        nameEn = _dataDic[@"nameEn"];
        
    }else{
        nameEn = @"";
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
    UILabel *titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(16);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.alpha = 1.0;

    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"英文名"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
    
    //分割线
    UIView *splitView = [UIView new];
    [self.view addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(107);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    [splitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    //用户清空按钮
    nameEnClearButton = [UIButton new];
    [self.view addSubview:nameEnClearButton];
    [nameEnClearButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(73);
        make.right.equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    //设置点击不变色
    nameEnClearButton.adjustsImageWhenHighlighted = NO;
    [nameEnClearButton setBackgroundImage:[UIImage imageNamed:@"login_del"] forState:UIControlStateNormal];
    
    
    //用户输入框
    nameEnTextField = [UITextField new];
    [self.view addSubview:nameEnTextField];
    [nameEnTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(71);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(nameEnClearButton.mas_left).offset(-10);
        make.height.equalTo(@20);
    }];
    [nameEnTextField setTextAlignment:NSTextAlignmentLeft];
    nameEnTextField.clearButtonMode = UITextFieldViewModeNever;
    nameEnTextField.borderStyle = UITextBorderStyleNone;
    //设置占位文字样式
    NSMutableAttributedString *userInfoPlaceholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入英文名" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
    nameEnTextField.attributedPlaceholder = userInfoPlaceholderString;
    //设置输入后文字样式
    [nameEnTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [nameEnTextField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //清除用户账户信息按钮
    if([nameEn isEqualToString:@""]){
        nameEnClearButton.hidden = YES;
    }
    [nameEnClearButton addTarget:self action:@selector(userClearButtonClick) forControlEvents:UIControlEventTouchUpInside];

    //用户信息文本框监听
    [nameEnTextField becomeFirstResponder];
    [nameEnTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - 设置参数 -
-(void)setData
{
    [nameEnTextField setText:nameEn];
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
    NSString *nameEnStr = [nameEnTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([nameEnStr isEqualToString:@""]){
        [AvalonsoftToast showWithMessage:@"用户名不可以为空"];
        return;
    }
    
    nameEn = nameEnStr;
    //模拟保存成功
//    [AvalonsoftToast showWithMessage:@"修改成功" image:@"login_success" duration:1];
    
    //延迟退出
    [self performSelector:@selector(modifyUserNameSuccess) withObject:nil afterDelay:0.5];
}

-(void)modifyUserNameSuccess{
    //设置回调
    NSDictionary *sendDataDic = @{@"nameEn":nameEn};
    //Block传值step 3:传值类将要传的值传入自己的block中
    self.sendValueBlock(sendDataDic);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - userClearButton点击事件 -
-(void)userClearButtonClick
{
    [nameEnTextField setText:@""];
    
    nameEnClearButton.hidden = YES;
}

#pragma mark - 输入框监听 -
-(void)textFieldDidChange
{
    //判断清空用户信息按钮是否显示
    if(![nameEnTextField.text isEqualToString:@""]){
        //不为空
        nameEnClearButton.hidden = NO;
        
    }else{
        nameEnClearButton.hidden = YES;
        
    }
}

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [nameEnTextField resignFirstResponder];
}

@end
