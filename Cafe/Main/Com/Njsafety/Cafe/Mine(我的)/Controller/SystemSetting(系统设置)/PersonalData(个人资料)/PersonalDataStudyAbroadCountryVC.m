//
//  PersonalDataStudyAbroadCountryVC.m
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//
//  留学国家

#import "PersonalDataStudyAbroadCountryVC.h"

@interface PersonalDataStudyAbroadCountryVC ()<UITextFieldDelegate>

{
    @private UIButton *backButton;              //左上角返回按钮
    
    @private UIView *navigationView;
    @private UIView *contentView;
    @private UIView *registView;                //注册视图
    @private UIView *clickableRegistView;       //可点击的注册视图
    
    @private UITextField *countryTextField;
    @private UITextField *categoryTextField;
    @private UITextField *timeTextField;
    @private UITextField *classTextField;
    @private UIButton *isReadingButton;         //留学在读/校友
    
    @private NSString *country;                 //留学国家
    @private NSString *category;                //留学类别
    @private NSString *time;                    //计划入学时间
    @private NSString *class;                   //春秋季班
    @private Boolean reading;                 //是否留学在读/校友
    
    @private BOOL isReadingButtonSlct;          //在读按钮是否选中
    
    @private NSMutableDictionary *sendMultiDic; //保存数据
}

@end

@implementation PersonalDataStudyAbroadCountryVC

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
    if(_dataDic[@"country"]){
        country = _dataDic[@"country"];
    }else{
        country = @"";
    }
    
    if(_dataDic[@"category"]){
        category = _dataDic[@"category"];
    }else{
        category = @"";
    }
    
    if(_dataDic[@"admissiondate"]){
        time = _dataDic[@"admissiondate"];
    }else{
        time = @"";
    }
    
    if(_dataDic[@"classes"]){
        class = _dataDic[@"classes"];
    }else{
        class = @"";
    }
    
    if(_dataDic[@"studyflag"]){
        reading = [_dataDic[@"studyflag"] boolValue];
    }else{
        reading = false;
    }
    
//    if([reading isEqualToString:@"1"]){
    if(reading){
        isReadingButtonSlct = YES;
    }else /*if([reading isEqualToString:@"0"])*/{
        isReadingButtonSlct = NO;
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
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20,530));
    }];
    contentView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contentView.layer.cornerRadius = 8;
    contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,0);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 10;
    
    //留学国家
    UILabel *countryLabel = [UILabel new];
    [contentView addSubview:countryLabel];
    [countryLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView).offset(20);
        make.left.equalTo(contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100,20));
    }];
    countryLabel.numberOfLines = 0;
    countryLabel.textAlignment = NSTextAlignmentLeft;
    countryLabel.alpha = 1.0;
    NSMutableAttributedString *countryLabelString = [[NSMutableAttributedString alloc] initWithString:@"留学国家"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    countryLabel.attributedText = countryLabelString;
    
    UIImageView *countryNextStep = [UIImageView new];
    [contentView addSubview:countryNextStep];
    [countryNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryLabel.mas_bottom).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [countryNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    countryTextField = [UITextField new];
    [contentView addSubview:countryTextField];
    [countryTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(countryNextStep.mas_left).offset(-15);
        make.height.equalTo(@22);
    }];
    countryTextField.tag = 1;
    countryTextField.delegate = self;
    [countryTextField setTextAlignment:NSTextAlignmentLeft];
    countryTextField.clearButtonMode = UITextFieldViewModeNever;
    countryTextField.borderStyle = UITextBorderStyleNone;
    //设置输入后文字样式
    [countryTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [countryTextField setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
     
    UIView *countrySplitView = [UIView new];
    [contentView addSubview:countrySplitView];
    [countrySplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countryTextField.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    [countrySplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    

    //留学类别
    UILabel *categoryLabel = [UILabel new];
    [contentView addSubview:categoryLabel];
    [categoryLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countrySplitView.mas_bottom).offset(28);
        make.left.equalTo(contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100,20));
    }];
    categoryLabel.numberOfLines = 0;
    categoryLabel.textAlignment = NSTextAlignmentLeft;
    categoryLabel.alpha = 1.0;
    NSMutableAttributedString *categoryLabelString = [[NSMutableAttributedString alloc] initWithString:@"留学类别"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    categoryLabel.attributedText = categoryLabelString;
    
    UIImageView *categoryNextStep = [UIImageView new];
    [contentView addSubview:categoryNextStep];
    [categoryNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(categoryLabel.mas_bottom).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [categoryNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    categoryTextField = [UITextField new];
    [contentView addSubview:categoryTextField];
    [categoryTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(categoryLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(categoryNextStep.mas_left).offset(-15);
        make.height.equalTo(@22);
    }];
    categoryTextField.tag = 2;
    categoryTextField.delegate = self;
    [categoryTextField setTextAlignment:NSTextAlignmentLeft];
    categoryTextField.clearButtonMode = UITextFieldViewModeNever;
    categoryTextField.borderStyle = UITextBorderStyleNone;
    //设置输入后文字样式
    [categoryTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [categoryTextField setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
     
    UIView *categorySplitView = [UIView new];
    [contentView addSubview:categorySplitView];
    [categorySplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(categoryTextField.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    [categorySplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //计划入学时间
    UILabel *timeLabel = [UILabel new];
    [contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(categorySplitView.mas_bottom).offset(28);
        make.left.equalTo(contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100,20));
    }];
    timeLabel.numberOfLines = 0;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.alpha = 1.0;
    NSMutableAttributedString *timeLabelString = [[NSMutableAttributedString alloc] initWithString:@"计划入学时间"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    timeLabel.attributedText = timeLabelString;
    
    UIImageView *timeNextStep = [UIImageView new];
    [contentView addSubview:timeNextStep];
    [timeNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(timeLabel.mas_bottom).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [timeNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    timeTextField = [UITextField new];
    [contentView addSubview:timeTextField];
    [timeTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(timeLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(timeNextStep.mas_left).offset(-15);
        make.height.equalTo(@22);
    }];
    timeTextField.tag = 3;
    timeTextField.delegate = self;
    [timeTextField setTextAlignment:NSTextAlignmentLeft];
    timeTextField.clearButtonMode = UITextFieldViewModeNever;
    timeTextField.borderStyle = UITextBorderStyleNone;
    //设置输入后文字样式
    [timeTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [timeTextField setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
     
    UIView *timeSplitView = [UIView new];
    [contentView addSubview:timeSplitView];
    [timeSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(timeTextField.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    [timeSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //春/秋季班
    UILabel *classLabel = [UILabel new];
    [contentView addSubview:classLabel];
    [classLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(timeSplitView.mas_bottom).offset(28);
        make.left.equalTo(contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100,20));
    }];
    classLabel.numberOfLines = 0;
    classLabel.textAlignment = NSTextAlignmentLeft;
    classLabel.alpha = 1.0;
    NSMutableAttributedString *classLabelString = [[NSMutableAttributedString alloc] initWithString:@"春/秋季班"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    classLabel.attributedText = classLabelString;
    
    UIImageView *classNextStep = [UIImageView new];
    [contentView addSubview:classNextStep];
    [classNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(classLabel.mas_bottom).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    [classNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
    
    classTextField = [UITextField new];
    [contentView addSubview:classTextField];
    [classTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(classLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(classNextStep.mas_left).offset(-15);
        make.height.equalTo(@22);
    }];
    classTextField.tag = 4;
    classTextField.delegate = self;
    [classTextField setTextAlignment:NSTextAlignmentLeft];
    classTextField.clearButtonMode = UITextFieldViewModeNever;
    classTextField.borderStyle = UITextBorderStyleNone;
    //设置输入后文字样式
    [classTextField setTextColor:RGBA_GGCOLOR(51, 51, 51, 1)];
    [classTextField setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
     
    UIView *classSplitView = [UIView new];
    [contentView addSubview:classSplitView];
    [classSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(classTextField.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    [classSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //留学在读/校友按钮
    isReadingButton = [UIButton new];
    [contentView addSubview:isReadingButton];
    [isReadingButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(classSplitView.mas_bottom).offset(11);
        make.left.equalTo(contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    //设置点击不变色
    isReadingButton.adjustsImageWhenHighlighted = NO;
    isReadingButton.layer.cornerRadius = 7;
    isReadingButton.layer.borderWidth = 0.5;
    isReadingButton.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0].CGColor;
    
    //留学在读/校友文字
    UILabel *isReadingLabel = [UILabel new];
    [contentView addSubview:isReadingLabel];
    [isReadingLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(classSplitView.mas_bottom).offset(9);
        make.left.equalTo(isReadingButton.mas_right).offset(6);
        make.size.mas_equalTo(CGSizeMake(100, 18));
    }];
    isReadingLabel.numberOfLines = 0;
    isReadingLabel.textAlignment = NSTextAlignmentLeft;
    isReadingLabel.alpha = 1.0;
    NSMutableAttributedString *isReadingLabelString = [[NSMutableAttributedString alloc] initWithString:@"留学在读/校友"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]}];
    isReadingLabel.attributedText = isReadingLabelString;
    
    //10.注册视图
    registView = [UIView new];
    [contentView addSubview:registView];
    [registView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(isReadingLabel.mas_bottom).offset(28);
        make.left.equalTo(contentView).offset((SCREEN_WIDTH-325)/2);
        make.size.mas_equalTo(CGSizeMake(325, 46));
    }];
    registView.layer.backgroundColor = [UIColor colorWithRed:158/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
    registView.layer.cornerRadius = 23;
    
    //10-1.注册 文字标签
    UILabel *registLabel = [UILabel new];
    [registView addSubview:registLabel];
    [registLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(registView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-32)/2);
        make.size.mas_equalTo(CGSizeMake(32, 22));
    }];
    registLabel.numberOfLines = 0;
    registLabel.textAlignment = NSTextAlignmentCenter;
    registLabel.alpha = 1.0;
    NSMutableAttributedString *registLabelString = [[NSMutableAttributedString alloc] initWithString:@"保存"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    registLabel.attributedText = registLabelString;
    
    //11.可点击的登录按钮，与上面那个位置重叠，但是只有在用户信息和密码都不为空时才出现，替代上面登录视图的位置
    clickableRegistView = [UIView new];
    [self.view addSubview:clickableRegistView];
    [clickableRegistView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(isReadingLabel.mas_bottom).offset(28);
        make.left.equalTo(contentView).offset((SCREEN_WIDTH-325)/2);
        make.size.mas_equalTo(CGSizeMake(325, 46));
    }];
    clickableRegistView.layer.cornerRadius = 23;
    clickableRegistView.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.4].CGColor;
    clickableRegistView.layer.shadowOffset = CGSizeMake(0,4);
    clickableRegistView.layer.shadowOpacity = 1;
    clickableRegistView.layer.shadowRadius = 10;
    
    [self.view layoutIfNeeded];
    //CAGradientLayer实现颜色渐变
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = clickableRegistView.bounds;
    gl.cornerRadius = 23;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [clickableRegistView.layer addSublayer:gl];
    
    //11-1.注册 文字标签
    UILabel *clickableRegistLabel = [UILabel new];
    [clickableRegistView addSubview:clickableRegistLabel];
    [clickableRegistLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(clickableRegistView).offset(12);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-32)/2);
        make.size.mas_equalTo(CGSizeMake(32, 22));
    }];
    clickableRegistLabel.numberOfLines = 0;
    clickableRegistLabel.textAlignment = NSTextAlignmentCenter;
    clickableRegistLabel.alpha = 1.0;
    NSMutableAttributedString *clickableRegistLabelString = [[NSMutableAttributedString alloc] initWithString:@"保存"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    clickableRegistLabel.attributedText = clickableRegistLabelString;
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //文本框监听
//    [countryTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
//
//    [categoryTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
//
//    [timeTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
//
//    [classTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];

    //是否在读按钮按钮
    [isReadingButton addTarget:self action:@selector(isReadingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //2个注册视图
    registView.hidden = YES;
    registView.userInteractionEnabled = NO;
    
    clickableRegistView.hidden = NO;
    clickableRegistView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *registViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveButtonClick)];
    //设置需要连续点击几次才响应，默认点击1次
    [registViewTapGesture setNumberOfTapsRequired:1];
    [clickableRegistView addGestureRecognizer:registViewTapGesture];
    
}

#pragma mark - 设置参数 -
-(void)setData
{
    countryTextField.text = country;

    categoryTextField.text = category;
    
    timeTextField.text = time;
    
    classTextField.text = class;
    
    if(isReadingButtonSlct){
        //选中状态
        isReadingButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [isReadingButton setBackgroundImage:[UIImage imageNamed:@"regist_slct"] forState:UIControlStateNormal];
        
    }else{
        //未选中
        isReadingButton.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0].CGColor;
        [isReadingButton setBackgroundImage:[_F imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(14, 14)] forState:UIControlStateNormal];
    }
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    if([countryTextField.text isEqualToString:@""]){
        [AvalonsoftToast showWithMessage:@"请选择留学国家"];
        return;
    }
    
    if([categoryTextField.text isEqualToString:@""]){
        [AvalonsoftToast showWithMessage:@"请选择留学类别"];
        return;
    }
    
    if([timeTextField.text isEqualToString:@""]){
        [AvalonsoftToast showWithMessage:@"请选择计划入学时间"];
        return;
    }
    
    if([classTextField.text isEqualToString:@""]){
        [AvalonsoftToast showWithMessage:@"请选择班级类型"];
        return;
    }
        
    //模拟保存成功
//    [AvalonsoftToast showWithMessage:@"保存成功" image:@"login_success" duration:1];
    //延迟推出
//    [self performSelector:@selector(saveSuccess) withObject:nil afterDelay:1.5];

    [self saveSuccess];
}

-(void)saveSuccess{
    //设置回调
    NSDictionary *sendDataDic = @{@"country":country,
                                  @"category":category,
                                  @"admissiondate":time,
                                  @"classes":class
    };
    sendMultiDic = [NSMutableDictionary dictionary];
    [sendMultiDic setDictionary:sendDataDic];
    //@"studyflag":reading
//    if (reading) {
//        [sendDataDic setValue:true forKey:@"studyflag"];
//    } else {
//        [sendDataDic setValue:false forKey:@"studyflag"];
//    }
    [sendMultiDic setValue:[NSNumber numberWithBool:reading] forKey:@"studyflag"];
    
    [self updateUserInfo:sendMultiDic];

}

#pragma mark - 输入框监听 -
-(void)textFieldDidChange
{
    //判断注册按钮是否可点击
    if(![countryTextField.text isEqualToString:@""] && ![categoryTextField.text isEqualToString:@""]
       && ![timeTextField.text isEqualToString:@""] && ![classTextField.text isEqualToString:@""]){
        
        //注册视图可点击
        registView.hidden = YES;
        
        clickableRegistView.hidden = NO;
        
    }else{
        //有一个为空，不可点击
        registView.hidden = NO;
        
        clickableRegistView.hidden = YES;
    }
}

#pragma mark - 点击是否在读按钮 -
-(void)isReadingButtonClick
{
    if(isReadingButtonSlct){
        //选中状态，点击取消选中
        isReadingButtonSlct = NO;
        reading = false;
        
        isReadingButton.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0].CGColor;
        [isReadingButton setBackgroundImage:[_F imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(14, 14)] forState:UIControlStateNormal];
        
    }else{
        //未选中，点击选中
        isReadingButtonSlct = YES;
        reading = true;
        
        isReadingButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [isReadingButton setBackgroundImage:[UIImage imageNamed:@"regist_slct"] forState:UIControlStateNormal];
        
    }
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 1){
        //留学国家
        [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"加拿大 Canada", @"美国 United States", @"澳洲 Australia", @"新西兰 New Zealand", @"英国 United Kingdom"] DefaultSelValue:@"美国 United States" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
            //回调
            self->country = selectValue;
            self->countryTextField.text = selectValue;
            
        }];
        
    }else if(textField.tag == 2){
        //留学类别
        [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"研究生（艺术)", @"研究生（普通)", @"语言/预科（本科)", @"语言/预科（研究生)", @"文凭/本科（普通)"] DefaultSelValue:@"语言/预科（本科)" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
            //回调
            self->category = selectValue;
            self->categoryTextField.text = selectValue;
            
        }];
        
    }else if(textField.tag == 3){
        //计划入学时间
        NSDate *now = [NSDate date];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *nowStr = [fmt stringFromDate:now];
        
        [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
            //回调
            self->time = selectValue;
            self->timeTextField.text = selectValue;
            
        }];
        
    }else if(textField.tag == 4){
        //春/秋季班
        AvalonsoftActionSheet *actionSheet = [[AvalonsoftActionSheet alloc] initSheetWithTitle:@"" style:AvalonsoftSheetStyleDefault itemTitles:@[@"春季班",@"秋季班"]];
        actionSheet.itemTextColor = RGBA_GGCOLOR(102, 102, 102, 1);
        
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
            self->class = title;
            self->classTextField.text = title;
        }];
    }
    
    return NO;
}

#pragma mark - 所有网络请求处理都在这里进行 -
-(void)updateUserInfo:(NSMutableDictionary *) root {
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
            if (has) {
                [root setValue:[_UserInfo accountId] forKey:@"accountId"];

                [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO method:HttpRequestPost paramenters:root prepareExecute:^{
                                        
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO];
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    //请求失败
                    NSLog(@"%@",error);
                    
                    [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
                }];
                
            } else {
                //没网
                //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            }
        }];
}

-(void)handleNetworkRequestWithResponseObject:(id)responseObject eventType:(NSString *)eventType
{
    NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
    //使用responseObject对_M进行MVC赋值
    _M *responseModel = [_M createResponseJsonObj:responseObject];
    
    NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
    
    @try {
        if ([eventType isEqualToString:MINE_SYSTEMSETTING_UPDATE_USER_EXTINFO]) {
            if(responseModel.rescode == 200){
                [AvalonsoftToast showWithMessage:@"更新成功"];
                
                //Block传值step 3:传值类将要传的值传入自己的block中
                self.sendValueBlock(sendMultiDic);
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [AvalonsoftToast showWithMessage:@"更新失败"];
            }
        }
    } @catch (NSException *exception) {
        @throw exception;
        //给出提示信息
        [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
    }
}
@end
