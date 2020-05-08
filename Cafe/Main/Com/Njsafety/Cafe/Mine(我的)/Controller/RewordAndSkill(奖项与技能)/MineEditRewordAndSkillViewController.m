//
//  MineEditRewordAndSkillViewController.m
//  Cafe
//
//  Created by migu on 2020/5/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineEditRewordAndSkillViewController.h"

#define TEXTFIELD_TAG 10000

@interface MineEditRewordAndSkillViewController () <UITextFieldDelegate>
{
    @private UIButton *backButton;              //左上角返回按钮
    @private UIButton *saveButton;              //右上角保存按钮
    @private UIView *navigationView;
   
    @private UIView *contentView;
    @private UITextField *nameTextField;        //名称
    @private UITextField *dateTextField;        //日期
    @private UITextField *levelTextField;       //等级程度
   
    @private NSString *name;
    @private NSString *date;
    @private NSString *level;
    @private NSString *ID;
    @private NSString *type;
}

@end

@implementation MineEditRewordAndSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self getParentVars];
    [self initNavigationView];
    [self initView];
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
    if(_dataDic != nil){
        if(_dataDic[@"name"]){
            name = _dataDic[@"name"];
        }else{
            name = @"";
        }
        
        if(_dataDic[@"date"]){
            date = _dataDic[@"date"];
        }else{
            date = @"";
        }
        
        if(_dataDic[@"level"]){
            level = _dataDic[@"level"];
        }else{
            level = @"";
        }
        
        if(_dataDic[@"id"]){
            ID = _dataDic[@"id"];
        }else{
            ID = @"";
        }
        
        if(_dataDic[@"type"]){
            type = _dataDic[@"type"];
        }else{
            type = @"";
        }
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
    //内容视图
    contentView = [UIView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-80-TabbarSafeBottomMargin);
    }];
    contentView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contentView.layer.cornerRadius = 8;
    contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,0);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 10;
    
    [self.view layoutIfNeeded];
        
    //***** 名称 *****//
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 28, SCREEN_WIDTH - 20 - 30, 20)];
    [contentView addSubview:nameLabel];
    [self setTitleLabelStyle:nameLabel withName:@"名称"];

    UIImageView *nameNextStep = [UIImageView new];
    [contentView addSubview:nameNextStep];
    [nameNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(nameLabel.mas_bottom).offset(19);
        make.right.equalTo(nameLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [nameNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    nameTextField = [UITextField new];
    [contentView addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(nameLabel.mas_bottom).offset(1);
        make.left.equalTo(nameLabel);
        make.right.equalTo(nameNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:nameTextField withTag:1];
    [nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIView *nameSplitView = [UIView new];
    [contentView addSubview:nameSplitView];
    [nameSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(nameTextField.mas_bottom).offset(1);
        make.left.equalTo(nameLabel).offset(-5);
        make.right.equalTo(nameLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [nameSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    //***** 日期 *****//
    UILabel *dateLabel = [UILabel new];
    [contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(nameSplitView.mas_bottom).offset(28);
        make.left.equalTo(nameSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:dateLabel withName:@"日期"];

    UIImageView *dateNextStep = [UIImageView new];
    [contentView addSubview:dateNextStep];
    [dateNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateLabel.mas_bottom).offset(19);
        make.right.equalTo(dateLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [dateNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    dateTextField = [UITextField new];
    [contentView addSubview:dateTextField];
    [dateTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateLabel.mas_bottom).offset(1);
        make.left.equalTo(dateLabel);
        make.right.equalTo(dateNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:dateTextField withTag:2];

    UIView *dateSplitView = [UIView new];
    [contentView addSubview:dateSplitView];
    [dateSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateTextField.mas_bottom).offset(1);
        make.left.equalTo(dateLabel).offset(-5);
        make.right.equalTo(dateLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [dateSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 等级程度 *****//
    UILabel *levelLabel = [UILabel new];
    [contentView addSubview:levelLabel];
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateSplitView.mas_bottom).offset(28);
        make.left.equalTo(dateSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:levelLabel withName:@"等级程度"];

    UIImageView *levelNextStep = [UIImageView new];
    [contentView addSubview:levelNextStep];
    [levelNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(levelLabel.mas_bottom).offset(19);
        make.right.equalTo(levelLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [levelNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    levelTextField = [UITextField new];
    [contentView addSubview:levelTextField];
    [levelTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(levelLabel.mas_bottom).offset(1);
        make.left.equalTo(levelLabel);
        make.right.equalTo(levelNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:levelTextField withTag:3];
    [levelTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIView *levelSplitView = [UIView new];
    [contentView addSubview:levelSplitView];
    [levelSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(levelTextField.mas_bottom).offset(1);
        make.left.equalTo(levelLabel).offset(-5);
        make.right.equalTo(levelLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [levelSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
}

#pragma mark - 设置参数 -
-(void)setData
{
    nameTextField.text = name;
    
    ///TODO:xubing date还是long类型，建议平台转为字符串
    if ([date isKindOfClass:[NSString class]]) {
        dateTextField.text = date;
    } else {
        dateTextField.text = [NSString stringWithFormat:@"%@",date];;
    }
    
    levelTextField.text = level;
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    if ([type isEqualToString:@"awardEdit"]) {
        [self saveMineEditRewordList];
    } else if ([type isEqualToString:@"skillEdit"]) {
        [self saveMineEditSkillList];
    }
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSInteger tfTag = textField.tag - TEXTFIELD_TAG;
    
    switch (tfTag) {
        case 1:
        case 3: {
            return YES;
        }
            break;
        
        case 2: {
            [nameTextField resignFirstResponder];
            [levelTextField resignFirstResponder];
            
            //日期
            NSDate *now = [NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *nowStr = [fmt stringFromDate:now];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
                __strong typeof(weakSelf) strongSelf = weakSelf;
                ///TODO:xubing date格式不用转换，否则接口不通
//                strongSelf->date = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//                strongSelf->dateTextField.text = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                
                strongSelf->date = selectValue;
                strongSelf->dateTextField.text = selectValue;
            }];
        }
            break;
            
        default:
            break;
    }
    
    return NO;
}

#pragma mark - 统一设置标题label格式 -
-(void)setTitleLabelStyle:(UILabel *)titleLabel withName:(NSString *)labelName
{
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:labelName attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 统一textfield格式 -
-(void)setTextFieldStyle:(UITextField *)textField withTag:(NSInteger)tag
{
    textField.tag = tag + TEXTFIELD_TAG;
    textField.delegate = self;
    [textField setTextAlignment:NSTextAlignmentLeft];
    textField.clearButtonMode = UITextFieldViewModeNever;
    textField.borderStyle = UITextBorderStyleNone;
    //设置输入后文字样式
    [textField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [textField setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
}


#pragma mark - 输入框监听 -
- (void)textFieldDidChange:(UITextField*) sender {
    NSInteger tfTag = sender.tag - TEXTFIELD_TAG;
    switch (tfTag) {
        case 1: {
            name = sender.text;
        }
            break;
            
        case 3: {
            level = sender.text;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - touch screen hide soft keyboard -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [nameTextField resignFirstResponder];
    [levelTextField resignFirstResponder];
}


#pragma mark - 网络请求
- (void)saveMineEditRewordList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:strongSelf->name forKey:@"awardName"];
            [root setValue:strongSelf->date forKey:@"awardDate"];
            [root setValue:strongSelf->level forKey:@"rankOrLevel"];
            [root setValue:strongSelf->ID forKey:@"id"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EDU_AWARD_UPDATE method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
                        strongSelf.sendValueBlock(sendDic);
                        
                        //保存成功
                        [AvalonsoftToast showWithMessage:@"修改成功" image:@"login_success" duration:1];
                        [strongSelf.navigationController popViewControllerAnimated:YES];
                    }
                } @catch (NSException *exception) {
                    @throw exception;
                    //给出提示信息
                    [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }];
            
        } else {
            //没网
            //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)saveMineEditSkillList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:strongSelf->name forKey:@"skillDesc"];
            [root setValue:strongSelf->date forKey:@"skillDate"];
            [root setValue:strongSelf->level forKey:@"rankOrLevel"];
            [root setValue:strongSelf->ID forKey:@"id"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EDU_SKILL_UPDATE method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
                        strongSelf.sendValueBlock(sendDic);
                        
                        //保存成功
                        [AvalonsoftToast showWithMessage:@"修改成功" image:@"login_success" duration:1];
                        [strongSelf.navigationController popViewControllerAnimated:YES];
                    }
                } @catch (NSException *exception) {
                    @throw exception;
                    //给出提示信息
                    [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }];
            
        } else {
            //没网
            //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
