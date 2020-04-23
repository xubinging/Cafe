//
//  MineAddRewordAndSkillViewController.m
//  Cafe
//
//  Created by migu on 2020/4/20.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineAddRewordAndSkillViewController.h"
#import "MineResultShowContentEditViewController.h"

#define TEXTFIELD_TAG 10000

@interface MineAddRewordAndSkillViewController () <UITextFieldDelegate>
{
    @private UIButton *backButton;              //左上角返回按钮
    @private UIView *navigationView;
   
    @private UIView *contentView;
    @private UIButton *saveButton;              //可点击的操作按钮
    @private UITextField *typeTextField;        //类型
    @private UITextField *nameTextField;        //名称
    @private UITextField *dateTextField;        //日期
    @private UITextField *levelTextField;       //等级程度
   
    @private NSString *type;
    @private NSString *name;
    @private NSString *date;
    @private NSString *level;
}
@end

@implementation MineAddRewordAndSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
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
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-150)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(150, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"添加"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
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
    
    //保存按钮
    saveButton = [UIButton new];
    [contentView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(contentView).offset(-35);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.height.mas_equalTo(@46);
    }];
    saveButton.layer.cornerRadius = 23;
    saveButton.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.3].CGColor;
    saveButton.layer.shadowOffset = CGSizeMake(0,5);
    saveButton.layer.shadowOpacity = 1;
    saveButton.layer.shadowRadius = 15;
    
    //设置文字
    NSMutableAttributedString *clickableOperateButtonString = [[NSMutableAttributedString alloc] initWithString:@"保存" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    [saveButton setAttributedTitle:clickableOperateButtonString forState:UIControlStateNormal];
    
    [self.view layoutIfNeeded];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = saveButton.bounds;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 23;
    //添加到最底层，否则会覆盖文字
    [saveButton.layer insertSublayer:gl atIndex:0];
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //***** 类型 *****//
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 28, SCREEN_WIDTH - 20 - 30, 20)];
    [contentView addSubview:typeLabel];
    [self setTitleLabelStyle:typeLabel withName:@"类型"];

    UIImageView *typeNextStep = [UIImageView new];
    [contentView addSubview:typeNextStep];
    [typeNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeLabel.mas_bottom).offset(19);
        make.right.equalTo(typeLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [typeNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    typeTextField = [UITextField new];
    [contentView addSubview:typeTextField];
    [typeTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeLabel.mas_bottom).offset(1);
        make.left.equalTo(typeLabel);
        make.right.equalTo(typeNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:typeTextField withTag:1];

    UIView *typeSplitView = [UIView new];
    [contentView addSubview:typeSplitView];
    [typeSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeTextField.mas_bottom).offset(1);
        make.left.equalTo(typeLabel).offset(-5);
        make.right.equalTo(typeLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [typeSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];

    
    //***** 名称 *****//
    UILabel *nameLabel = [UILabel new];
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeSplitView.mas_bottom).offset(28);
        make.left.equalTo(typeSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
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
    [self setTextFieldStyle:nameTextField withTag:2];
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
    [self setTextFieldStyle:dateTextField withTag:3];

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
    [self setTextFieldStyle:levelTextField withTag:4];
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

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    if ([type isEqualToString:@"奖项"]) {
        [self saveMineAddRewordList];
    } else if ([type isEqualToString:@"技能"]) {
        [self saveMineAddSkillList];
    } else {
        [AvalonsoftToast showWithMessage:@"类型不能为空！"];
    }
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSInteger tfTag = textField.tag - TEXTFIELD_TAG;
    
    switch (tfTag) {
        case 1: {
            //类型
            [nameTextField resignFirstResponder];
            [levelTextField resignFirstResponder];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"奖项", @"技能"] DefaultSelValue:@"奖项" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
                __strong typeof(weakSelf) strongSelf = weakSelf;

                strongSelf->type = selectValue;
                strongSelf->typeTextField.text = selectValue;
            }];
        }
            break;
            
        case 2:
        case 4: {
            return YES;
        }
            break;
        
        case 3: {
            //日期
            [nameTextField resignFirstResponder];
            [levelTextField resignFirstResponder];

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
        case 2: {
            name = sender.text;
        }
            break;
            
        case 4: {
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
- (void)saveMineAddRewordList
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
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EDU_AWARD_ADD method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
                        [sendDic setValue:@"奖项" forKey:@"type"];
                        strongSelf.sendValueBlock(sendDic);
                        
                        //保存成功
                        [AvalonsoftToast showWithMessage:@"保存成功" image:@"login_success" duration:1];
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

- (void)saveMineAddSkillList
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
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EDU_SKILL_ADD method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
                        [sendDic setValue:@"技能" forKey:@"type"];
                        strongSelf.sendValueBlock(sendDic);
                        
                        //保存成功
                        [AvalonsoftToast showWithMessage:@"保存成功" image:@"login_success" duration:1];
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
