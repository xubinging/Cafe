//
//  MineEditActivityViewController.m
//  Cafe
//
//  Created by migu on 2020/5/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineEditActivityViewController.h"
#import "MineActivityModel.h"

#import "MineDetailCommonModel.h"
#import "MineDetailCommonTableViewCell.h"
#import "Header.h"

#define TEXTFIELD_TAG 10000

@interface MineEditActivityViewController () <UITextFieldDelegate, UITextViewDelegate>
{
    @private UIButton *backButton;
    @private UIView *navigationView;
   
    @private UIView *contentView;
    @private UIButton *saveButton;
    @private UITextField *nameTextField;
    @private UITextField *roleTextField;
    @private UITextField *startDateTextField;
    @private UITextField *endDateTextField;
    @private UITextView *contentTextView;
   
    @private NSString *name;
    @private NSString *role;
    @private NSString *startDate;
    @private NSString *endDate;
    @private NSString *description;
    @private NSString *ID;
    @private MineActivityModel *slctModel;
}

@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) NSArray *detailArray;
@property (nonatomic, assign) NSInteger keyBoardHeight;
@property (nonatomic, strong) UITextView *selectedTextView;

@end


@implementation MineEditActivityViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}


#pragma mark - 获取父页面参数 -
-(void)getParentVars
{
    if(_dataDic != nil){
        slctModel = _dataDic[@"slctModel"];
    }
}

#pragma mark - 设置参数 -
-(void)setData
{
    name = slctModel.eventName;
    nameTextField.text = name;
    
    role = slctModel.role;
    roleTextField.text = role;
    
    startDate = slctModel.eventStartDate;
    if ([startDate isKindOfClass:[NSString class]]) {
        startDateTextField.text = startDate;
    } else {
        startDateTextField.text = [NSString stringWithFormat:@"%@",startDate];;
    }

    endDate = slctModel.eventEndDate;
    if ([endDate isKindOfClass:[NSString class]]) {
        endDateTextField.text = endDate;
    } else {
        endDateTextField.text = [NSString stringWithFormat:@"%@",endDate];;
    }

    description = slctModel.eventDescription;
    contentTextView.text = description;
    
    ID = slctModel.ID;
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
        make.bottom.equalTo(self.view).offset(-30-TabbarSafeBottomMargin);
    }];
    contentView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contentView.layer.cornerRadius = 8;
    contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,0);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 10;
        
    //*****  社团/项目/活动名称  *****//
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 28, SCREEN_WIDTH - 20 - 30, 20)];
    [contentView addSubview:nameLabel];
    [self setTitleLabelStyle:nameLabel withName:@"社团/项目/活动名称"];

    UIImageView *nameNextStep = [UIImageView new];
    [contentView addSubview:nameNextStep];
    [nameNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.right.equalTo(nameLabel);
        make.size.mas_equalTo(CGSizeMake(7, 15));
    }];
    [nameNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    nameTextField = [UITextField new];
    [contentView addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(nameLabel.mas_bottom).offset(1);
        make.left.equalTo(nameLabel);
        make.right.equalTo(nameNextStep.mas_left).offset(-15);
        make.height.equalTo(@30);
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

    
    //***** 社团/项目/活动角色 *****//
    UILabel *roleLabel = [UILabel new];
    [contentView addSubview:roleLabel];
    [roleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(nameSplitView.mas_bottom).offset(15);
        make.left.equalTo(nameSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:roleLabel withName:@"社团/项目/活动角色"];

    UIImageView *roleNextStep = [UIImageView new];
    [contentView addSubview:roleNextStep];
    [roleNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(roleLabel.mas_bottom).offset(10);
        make.right.equalTo(roleLabel);
        make.size.mas_equalTo(CGSizeMake(7, 15));
    }];
    [roleNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    roleTextField = [UITextField new];
    [contentView addSubview:roleTextField];
    [roleTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(roleLabel.mas_bottom).offset(1);
        make.left.equalTo(roleLabel);
        make.right.equalTo(roleNextStep.mas_left).offset(-15);
        make.height.equalTo(@30);
    }];
    [self setTextFieldStyle:roleTextField withTag:2];
    [roleTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIView *roleSplitView = [UIView new];
    [contentView addSubview:roleSplitView];
    [roleSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(roleTextField.mas_bottom).offset(1);
        make.left.equalTo(roleLabel).offset(-5);
        make.right.equalTo(roleLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [roleSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 开始时间 *****//
    UILabel *stratDateLabel = [UILabel new];
    [contentView addSubview:stratDateLabel];
    [stratDateLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(roleSplitView.mas_bottom).offset(15);
        make.left.equalTo(roleSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:stratDateLabel withName:@"开始时间"];

    UIImageView *startDateNextStep = [UIImageView new];
    [contentView addSubview:startDateNextStep];
    [startDateNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(stratDateLabel.mas_bottom).offset(10);
        make.right.equalTo(stratDateLabel);
        make.size.mas_equalTo(CGSizeMake(7, 15));
    }];
    [startDateNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    startDateTextField = [UITextField new];
    [contentView addSubview:startDateTextField];
    [startDateTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(stratDateLabel.mas_bottom).offset(1);
        make.left.equalTo(stratDateLabel);
        make.right.equalTo(startDateNextStep.mas_left).offset(-15);
        make.height.equalTo(@30);
    }];
    [self setTextFieldStyle:startDateTextField withTag:3];

    UIView *startDateSplitView = [UIView new];
    [contentView addSubview:startDateSplitView];
    [startDateSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(startDateTextField.mas_bottom).offset(1);
        make.left.equalTo(stratDateLabel).offset(-5);
        make.right.equalTo(stratDateLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [startDateSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 结束时间 *****//
    UILabel *endDateLabel = [UILabel new];
    [contentView addSubview:endDateLabel];
    [endDateLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(startDateSplitView.mas_bottom).offset(15);
        make.left.equalTo(startDateSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:endDateLabel withName:@"结束时间"];

    UIImageView *endDateNextStep = [UIImageView new];
    [contentView addSubview:endDateNextStep];
    [endDateNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(endDateLabel.mas_bottom).offset(10);
        make.right.equalTo(endDateLabel);
        make.size.mas_equalTo(CGSizeMake(7, 15));
    }];
    [endDateNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    endDateTextField = [UITextField new];
    [contentView addSubview:endDateTextField];
    [endDateTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(endDateLabel.mas_bottom).offset(1);
        make.left.equalTo(endDateLabel);
        make.right.equalTo(endDateNextStep.mas_left).offset(-15);
        make.height.equalTo(@30);
    }];
    [self setTextFieldStyle:endDateTextField withTag:4];

    UIView *endDateSplitView = [UIView new];
    [contentView addSubview:endDateSplitView];
    [endDateSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(endDateTextField.mas_bottom).offset(1);
        make.left.equalTo(endDateLabel).offset(-5);
        make.right.equalTo(endDateLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [endDateSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    //内容
    UILabel *descripLabel = [UILabel new];
    [contentView addSubview:descripLabel];
    [descripLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(endDateSplitView.mas_bottom).offset(15);
        make.left.equalTo(endDateSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:descripLabel withName:@"描述"];
    
    contentTextView = [UITextView new];
    [contentView addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descripLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.height.mas_equalTo(@(150));
    }];
    contentTextView.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0].CGColor;
    contentTextView.layer.cornerRadius = 8;
    [contentTextView setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
    [contentTextView setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    contentTextView.delegate = self;
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    [self saveMineEditActivityList];
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSInteger tfTag = textField.tag - TEXTFIELD_TAG;
    
    switch (tfTag) {
        case 1:
        case 2: {
            return YES;
        }
            break;
        
        case 3:
        case 4: {
            [roleTextField resignFirstResponder];
            [nameTextField resignFirstResponder];

            NSDate *now = [NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *nowStr = [fmt stringFromDate:now];

            __weak typeof(self) weakSelf = self;
            [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
                __strong typeof(weakSelf) strongSelf = weakSelf;

                if (tfTag == 3) {
                    strongSelf->startDate = selectValue;
                    strongSelf->startDateTextField.text = selectValue;
                } else if (tfTag == 4) {
                    strongSelf->endDate = selectValue;
                    strongSelf->endDateTextField.text = selectValue;
                }
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

        case 2: {
            role = sender.text;
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
    [roleTextField resignFirstResponder];
    [contentTextView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    description = textView.text;
}

#pragma mark - 网络请求
- (void)saveMineEditActivityList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:strongSelf->name forKey:@"eventName"];
            [root setValue:strongSelf->role forKey:@"role"];
            [root setValue:strongSelf->startDate forKey:@"eventStartDate"];
            [root setValue:strongSelf->endDate forKey:@"eventEndDate"];
            [root setValue:strongSelf->description forKey:@"eventDescription"];
            [root setValue:strongSelf->ID forKey:@"id"];

            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_ACTIVITY_UPDATE method:HttpRequestPost paramenters:root prepareExecute:^{
                
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


#pragma mark  键盘出现时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyBoardHeight = keyboardRect.size.height;
    //注意下句代码，为了避免键盘第一次出现时，输入框的位置不发生改变
    [self textViewDidBeginEditing:self.selectedTextView];
}

#pragma mark 改变输入框的坐标
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.selectedTextView = textView;
       [UIView animateWithDuration:0.1 animations:^{
           CGFloat offset = kScreenHeight-(CGRectGetMaxY(textView.frame)+self.keyBoardHeight+200);
           if (offset<=0) {
               [UIView animateWithDuration:0.3 animations:^{
                   CGRect frame = self.view.frame;
                   frame.origin.y = offset;
                   self.view.frame = frame;
               }];
           }
    }];
}


#pragma mark 恢复输入框的位置
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
