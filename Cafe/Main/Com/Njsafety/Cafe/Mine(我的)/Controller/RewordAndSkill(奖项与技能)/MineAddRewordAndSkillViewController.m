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
        if(_dataDic[@"type"]){
            type = _dataDic[@"type"];
        }else{
            type = @"";
        }
        
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
    typeTextField.text = type;
    nameTextField.text = name;
    dateTextField.text = date;
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
    if (type.length > 0 && date.length > 0 && name.length > 0 && level.length > 0) {
        //模拟保存成功
        [AvalonsoftToast showWithMessage:@"保存成功" image:@"login_success" duration:1];
        //延迟推出
        [self performSelector:@selector(saveSuccess) withObject:nil afterDelay:1.5];
        
    } else {
        if (!type.length) {
            [AvalonsoftToast showWithMessage:@"类型不能为空！"];
        } else if (!date.length) {
            [AvalonsoftToast showWithMessage:@"名称不能为空！"];
        } else if (!name.length) {
            [AvalonsoftToast showWithMessage:@"日期不能为空！"];
        } else if (!level.length) {
            [AvalonsoftToast showWithMessage:@"等级程度不能为空！"];
        }
    }
}

-(void)saveSuccess{
    //设置回调
    NSDictionary *sendDataDic = @{@"type":type,
                                  @"location":name,
                                  @"date":date,
                                  @"org":level,
    };
    
    //Block传值step 3:传值类将要传的值传入自己的block中
    self.sendValueBlock(sendDataDic);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    NSInteger tfTag = textField.tag - TEXTFIELD_TAG;
    
    switch (tfTag) {
        case 1: {
            //类型
            [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"奖项", @"技能"] DefaultSelValue:@"" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
                self->type = selectValue;
                self->typeTextField.text = selectValue;
            }];
        }
            break;
            
        case 2: {
            //名称
            NSString *title = @"名称";
            NSString *content = name;
            
            //通过字典将值传到后台
            NSDictionary *sendDataDic = @{@"title":title,
                                          @"content":content
            };
            
            MineResultShowContentEditViewController *contentEditVC = [[MineResultShowContentEditViewController alloc] init];
            //设置block回调
            __weak typeof(self) weakSelf = self;
            [contentEditVC setSendValueBlock:^(NSDictionary *valueDict){
                __strong typeof(weakSelf) strongSelf = weakSelf;
                //回调函数
                NSString *returnContent = valueDict[@"content"];
                
                strongSelf->name = returnContent;
                strongSelf->nameTextField.text = returnContent;;
                
                
            }];
            
            contentEditVC.dataDic = sendDataDic;
            [self.navigationController pushViewController:contentEditVC animated:YES];
        }
            break;
        
        case 3: {
            //日期
            NSDate *now = [NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *nowStr = [fmt stringFromDate:now];

            [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
                self->date = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                self->dateTextField.text = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            }];
        }
            break;
        
        case 4: {
            NSString *title = @"等级程度";
            NSString *content = level;
            
            //通过字典将值传到后台
            NSDictionary *sendDataDic = @{@"title":title,
                                          @"content":content
            };
            
            MineResultShowContentEditViewController *contentEditVC = [[MineResultShowContentEditViewController alloc] init];
            //设置block回调
            __weak typeof(self) weakSelf = self;
            [contentEditVC setSendValueBlock:^(NSDictionary *valueDict){
                __strong typeof(weakSelf) strongSelf = weakSelf;
                //回调函数
                NSString *returnContent = valueDict[@"content"];
      
                strongSelf->level = returnContent;
                strongSelf->levelTextField.text = returnContent;;
                
            }];
            
            contentEditVC.dataDic = sendDataDic;
            [self.navigationController pushViewController:contentEditVC animated:YES];
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

@end
