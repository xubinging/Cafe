//
//  MineResultShowViewController.m
//  Cafe
//
//  Created by leo on 2020/1/7.
//  Copyright © 2020 leo. All rights reserved.
//
//  晒晒成绩

#import "MineResultShowViewController.h"

#import "MineResultShowContentEditViewController.h"

#define TEXTFIELD_TAG 10000

@interface MineResultShowViewController ()<UITextFieldDelegate>

{
    @private UIButton *backButton;              //左上角返回按钮
    @private UIView *navigationView;
    
    @private UIView *contentView;
    @private UIScrollView *contentScrollView;   //滑动视图
    @private UIButton *operateButton;           //本页操作按钮
    @private UIButton *clickableOperateButton;  //可点击的操作按钮
    
    @private UITextField *typeTextField;        //考试类型
    @private UITextField *dateTextField;        //考试日期
    @private UITextField *locationTextField;    //考试地点
    @private UITextField *orgTextField;         //机构
    @private UITextField *resultLTextField;     //L
    @private UITextField *resultSTextField;     //S
    @private UITextField *resultRTextField;     //R
    @private UITextField *resultWTextField;     //W
    @private UITextField *resultScoreTextField; //总分
    @private UIButton *uploadFileButton;        //上传附件按钮
    
    @private NSString *type;
    @private NSString *date;
    @private NSString *location;
    @private NSString *org;
    @private NSString *resultL;
    @private NSString *resultS;
    @private NSString *resultR;
    @private NSString *resultW;
    @private NSString *resultScore;
    
}

@end

@implementation MineResultShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self getParentVars];
    [self initNavigationView];
    [self initView];
    [self initScrollView];
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
    if(_dataDic != nil){
        if(_dataDic[@"type"]){
            type = _dataDic[@"type"];
        }else{
            type = @"";
        }
        
        if(_dataDic[@"date"]){
            date = _dataDic[@"date"];
        }else{
            date = @"";
        }
        
        if(_dataDic[@"location"]){
            location = _dataDic[@"location"];
        }else{
            location = @"";
        }
        
        if(_dataDic[@"org"]){
            org = _dataDic[@"org"];
        }else{
            org = @"";
        }
        
        if(_dataDic[@"resultL"]){
            resultL = _dataDic[@"resultL"];
        }else{
            resultL = @"";
        }
        
        if(_dataDic[@"resultS"]){
            resultS = _dataDic[@"resultS"];
        }else{
            resultS = @"";
        }
        
        if(_dataDic[@"resultR"]){
            resultR = _dataDic[@"resultR"];
        }else{
            resultR = @"";
        }
        
        if(_dataDic[@"resultW"]){
            resultW = _dataDic[@"resultW"];
        }else{
            resultW = @"";
        }
        
        if(_dataDic[@"resultScore"]){
            resultScore = _dataDic[@"resultScore"];
        }else{
            resultScore = @"";
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"晒晒成绩"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
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
    
    //先加2个按钮
    //不可点击的
    operateButton = [UIButton new];
    [contentView addSubview:operateButton];
    [operateButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(contentView).offset(-35);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.height.mas_equalTo(@46);
    }];
    operateButton.layer.backgroundColor = [UIColor colorWithRed:158/255.0 green:226/255.0 blue:255/255.0 alpha:1.0].CGColor;
    operateButton.layer.cornerRadius = 23;
    
    NSMutableAttributedString *operateButtonString = [[NSMutableAttributedString alloc] initWithString:@"保存" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    [operateButton setAttributedTitle:operateButtonString forState:UIControlStateNormal];
    
    //可点击的
    clickableOperateButton = [UIButton new];
    [contentView addSubview:clickableOperateButton];
    [clickableOperateButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(contentView).offset(-35);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.height.mas_equalTo(@46);
    }];
    clickableOperateButton.layer.cornerRadius = 23;
    clickableOperateButton.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.3].CGColor;
    clickableOperateButton.layer.shadowOffset = CGSizeMake(0,5);
    clickableOperateButton.layer.shadowOpacity = 1;
    clickableOperateButton.layer.shadowRadius = 15;
    
    //设置文字
    NSMutableAttributedString *clickableOperateButtonString = [[NSMutableAttributedString alloc] initWithString:@"保存" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    [clickableOperateButton setAttributedTitle:clickableOperateButtonString forState:UIControlStateNormal];
    
    [self.view layoutIfNeeded];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = clickableOperateButton.bounds;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 23;
    //添加到最底层，否则会覆盖文字
    [clickableOperateButton.layer insertSublayer:gl atIndex:0];
}

#pragma mark - 初始化滑动视图 -
-(void)initScrollView
{
    //可滑动部分
    contentScrollView = [UIScrollView new];
    [contentView addSubview:contentScrollView];
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(contentView);
        make.bottom.equalTo(operateButton.mas_top).offset(-30);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
    }];
    [contentScrollView setBackgroundColor:[UIColor clearColor]];
    contentScrollView.showsVerticalScrollIndicator = NO;
    //内容尺寸是固定的
    [contentScrollView setContentSize:CGSizeMake(SCREEN_WIDTH-20, 1050)];
        
    //***** 考试类型 *****//
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 28, SCREEN_WIDTH - 20 - 30, 20)];
    [contentScrollView addSubview:typeLabel];
    [self setTitleLabelStyle:typeLabel withName:@"考试类型"];

    UIImageView *typeNextStep = [UIImageView new];
    [contentScrollView addSubview:typeNextStep];
    [typeNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeLabel.mas_bottom).offset(19);
        make.right.equalTo(typeLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [typeNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    typeTextField = [UITextField new];
    [contentScrollView addSubview:typeTextField];
    [typeTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeLabel.mas_bottom).offset(1);
        make.left.equalTo(typeLabel);
        make.right.equalTo(typeNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:typeTextField withTag:1];

    UIView *countrySplitView = [UIView new];
    [contentScrollView addSubview:countrySplitView];
    [countrySplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeTextField.mas_bottom).offset(1);
        make.left.equalTo(typeLabel).offset(-5);
        make.right.equalTo(typeLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [countrySplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 考试日期 *****//
    UILabel *dateLabel = [UILabel new];
    [contentScrollView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(countrySplitView.mas_bottom).offset(28);
        make.left.equalTo(countrySplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:dateLabel withName:@"考试日期"];

    UIImageView *dateNextStep = [UIImageView new];
    [contentScrollView addSubview:dateNextStep];
    [dateNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateLabel.mas_bottom).offset(19);
        make.right.equalTo(dateLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [dateNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    dateTextField = [UITextField new];
    [contentScrollView addSubview:dateTextField];
    [dateTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateLabel.mas_bottom).offset(1);
        make.left.equalTo(dateLabel);
        make.right.equalTo(dateNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:dateTextField withTag:2];

    UIView *dateSplitView = [UIView new];
    [contentScrollView addSubview:dateSplitView];
    [dateSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateTextField.mas_bottom).offset(1);
        make.left.equalTo(dateLabel).offset(-5);
        make.right.equalTo(dateLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [dateSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 考试地点 *****//
    UILabel *locationLabel = [UILabel new];
    [contentScrollView addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(dateSplitView.mas_bottom).offset(28);
        make.left.equalTo(dateSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:locationLabel withName:@"考试地点"];

    UIImageView *locationNextStep = [UIImageView new];
    [contentScrollView addSubview:locationNextStep];
    [locationNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(locationLabel.mas_bottom).offset(19);
        make.right.equalTo(locationLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [locationNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    locationTextField = [UITextField new];
    [contentScrollView addSubview:locationTextField];
    [locationTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(locationLabel.mas_bottom).offset(1);
        make.left.equalTo(locationLabel);
        make.right.equalTo(locationNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:locationTextField withTag:3];

    UIView *locationSplitView = [UIView new];
    [contentScrollView addSubview:locationSplitView];
    [locationSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(locationTextField.mas_bottom).offset(1);
        make.left.equalTo(locationLabel).offset(-5);
        make.right.equalTo(locationLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [locationSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 参加的培训机构 *****//
    UILabel *orgLabel = [UILabel new];
    [contentScrollView addSubview:orgLabel];
    [orgLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(locationSplitView.mas_bottom).offset(28);
        make.left.equalTo(locationSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:orgLabel withName:@"参加的培训机构"];

    UIImageView *orgNextStep = [UIImageView new];
    [contentScrollView addSubview:orgNextStep];
    [orgNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(orgLabel.mas_bottom).offset(19);
        make.right.equalTo(orgLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [orgNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    orgTextField = [UITextField new];
    [contentScrollView addSubview:orgTextField];
    [orgTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(orgLabel.mas_bottom).offset(1);
        make.left.equalTo(orgLabel);
        make.right.equalTo(orgNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:orgTextField withTag:4];

    UIView *orgSplitView = [UIView new];
    [contentScrollView addSubview:orgSplitView];
    [orgSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(orgTextField.mas_bottom).offset(1);
        make.left.equalTo(orgLabel).offset(-5);
        make.right.equalTo(orgLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [orgSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];


    //***** L *****//
    UILabel *resultLLabel = [UILabel new];
    [contentScrollView addSubview:resultLLabel];
    [resultLLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(orgSplitView.mas_bottom).offset(28);
        make.left.equalTo(orgSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:resultLLabel withName:@"L"];

    UIImageView *resultLNextStep = [UIImageView new];
    [contentScrollView addSubview:resultLNextStep];
    [resultLNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultLLabel.mas_bottom).offset(19);
        make.right.equalTo(resultLLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [resultLNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    resultLTextField = [UITextField new];
    [contentScrollView addSubview:resultLTextField];
    [resultLTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultLLabel.mas_bottom).offset(1);
        make.left.equalTo(resultLLabel);
        make.right.equalTo(resultLNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:resultLTextField withTag:5];

    UIView *resultLSplitView = [UIView new];
    [contentScrollView addSubview:resultLSplitView];
    [resultLSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultLTextField.mas_bottom).offset(1);
        make.left.equalTo(resultLLabel).offset(-5);
        make.right.equalTo(resultLLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [resultLSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];


    //***** S *****//
    UILabel *resultSLabel = [UILabel new];
    [contentScrollView addSubview:resultSLabel];
    [resultSLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultLSplitView.mas_bottom).offset(28);
        make.left.equalTo(resultLSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:resultSLabel withName:@"S"];

    UIImageView *resultSNextStep = [UIImageView new];
    [contentScrollView addSubview:resultSNextStep];
    [resultSNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultSLabel.mas_bottom).offset(19);
        make.right.equalTo(resultSLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [resultSNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    resultSTextField = [UITextField new];
    [contentScrollView addSubview:resultSTextField];
    [resultSTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultSLabel.mas_bottom).offset(1);
        make.left.equalTo(resultSLabel);
        make.right.equalTo(resultSNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:resultSTextField withTag:6];

    UIView *resultSSplitView = [UIView new];
    [contentScrollView addSubview:resultSSplitView];
    [resultSSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultSTextField.mas_bottom).offset(1);
        make.left.equalTo(resultSLabel).offset(-5);
        make.right.equalTo(resultSLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [resultSSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** R *****//
    UILabel *resultRLabel = [UILabel new];
    [contentScrollView addSubview:resultRLabel];
    [resultRLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultSSplitView.mas_bottom).offset(28);
        make.left.equalTo(resultSSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:resultRLabel withName:@"R"];

    UIImageView *resultRNextStep = [UIImageView new];
    [contentScrollView addSubview:resultRNextStep];
    [resultRNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultRLabel.mas_bottom).offset(19);
        make.right.equalTo(resultRLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [resultRNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    resultRTextField = [UITextField new];
    [contentScrollView addSubview:resultRTextField];
    [resultRTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultRLabel.mas_bottom).offset(1);
        make.left.equalTo(resultRLabel);
        make.right.equalTo(resultSNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:resultRTextField withTag:7];

    UIView *resultRSplitView = [UIView new];
    [contentScrollView addSubview:resultRSplitView];
    [resultRSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultRTextField.mas_bottom).offset(1);
        make.left.equalTo(resultRLabel).offset(-5);
        make.right.equalTo(resultRLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [resultRSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** W *****//
    UILabel *resultWLabel = [UILabel new];
    [contentScrollView addSubview:resultWLabel];
    [resultWLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultRSplitView.mas_bottom).offset(28);
        make.left.equalTo(resultRSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:resultWLabel withName:@"W"];

    UIImageView *resultWNextStep = [UIImageView new];
    [contentScrollView addSubview:resultWNextStep];
    [resultWNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultWLabel.mas_bottom).offset(19);
        make.right.equalTo(resultWLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [resultWNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    resultWTextField = [UITextField new];
    [contentScrollView addSubview:resultWTextField];
    [resultWTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultWLabel.mas_bottom).offset(1);
        make.left.equalTo(resultWLabel);
        make.right.equalTo(resultWNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:resultWTextField withTag:8];

    UIView *resultWSplitView = [UIView new];
    [contentScrollView addSubview:resultWSplitView];
    [resultWSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultWTextField.mas_bottom).offset(1);
        make.left.equalTo(resultWLabel).offset(-5);
        make.right.equalTo(resultWLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [resultWSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //***** 总分 *****//
    UILabel *resultScoreLabel = [UILabel new];
    [contentScrollView addSubview:resultScoreLabel];
    [resultScoreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultWSplitView.mas_bottom).offset(28);
        make.left.equalTo(resultWSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:resultScoreLabel withName:@"总分"];

    UIImageView *resultScoreNextStep = [UIImageView new];
    [contentScrollView addSubview:resultScoreNextStep];
    [resultScoreNextStep mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreLabel.mas_bottom).offset(19);
        make.right.equalTo(resultScoreLabel);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [resultScoreNextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];

    resultScoreTextField = [UITextField new];
    [contentScrollView addSubview:resultScoreTextField];
    [resultScoreTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreLabel.mas_bottom).offset(1);
        make.left.equalTo(resultScoreLabel);
        make.right.equalTo(resultScoreNextStep.mas_left).offset(-15);
        make.height.equalTo(@50);
    }];
    [self setTextFieldStyle:resultScoreTextField withTag:9];

    UIView *resultScoreSplitView = [UIView new];
    [contentScrollView addSubview:resultScoreSplitView];
    [resultScoreSplitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreTextField.mas_bottom).offset(1);
        make.left.equalTo(resultScoreLabel).offset(-5);
        make.right.equalTo(resultScoreLabel).offset(5);
        make.height.mas_equalTo(@1);
    }];
    [resultScoreSplitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    
    //上传照片
    UILabel *uploadPicLabel = [UILabel new];
    [contentScrollView addSubview:uploadPicLabel];
    [uploadPicLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(resultScoreSplitView.mas_bottom).offset(15);
        make.left.equalTo(resultWSplitView).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20 - 30, 20));
    }];
    [self setTitleLabelStyle:uploadPicLabel withName:@"上传成绩"];
    
    //上传附件按钮
    uploadFileButton = [UIButton new];
    [contentScrollView addSubview:uploadFileButton];
    [uploadFileButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(uploadPicLabel.mas_bottom).offset(15);
        make.left.equalTo(uploadPicLabel);
        make.size.mas_equalTo(CGSizeMake(78, 78));
    }];
    [uploadFileButton setImage:[UIImage imageNamed:@"mine_upload_file"] forState:UIControlStateNormal];
    [uploadFileButton setAdjustsImageWhenHighlighted:NO];
    
    //说明文字
    UILabel *detailLabel = [UILabel new];
    [contentScrollView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(uploadFileButton).offset(30);
        make.left.equalTo(uploadFileButton.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(220, 18));
    }];
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.alpha = 1.0;

    NSMutableAttributedString *detailLabelString = [[NSMutableAttributedString alloc] initWithString:@"支持png,jpg,jpeg等格式,大小不超过5M" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]}];
    detailLabel.attributedText = detailLabelString;
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //2个操作按钮
    operateButton.hidden = NO;
    operateButton.userInteractionEnabled = NO;
    
    clickableOperateButton.hidden = YES;
    //添加事件
    [clickableOperateButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 设置参数 -
-(void)setData
{
    typeTextField.text = type;
    dateTextField.text = date;
    locationTextField.text = location;
    orgTextField.text = org;
    resultLTextField.text = resultL;
    resultSTextField.text = resultS;
    resultRTextField.text = resultR;
    resultWTextField.text = resultW;
    resultScoreTextField.text = resultScore;
    
    //判断保存按钮是否可点击
    [self isShowSavaButton];
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)saveButtonClick
{
    //模拟保存成功
    [AvalonsoftToast showWithMessage:@"保存成功" image:@"login_success" duration:1];
    
    //延迟推出
    [self performSelector:@selector(saveSuccess) withObject:nil afterDelay:1.5];
}

-(void)saveSuccess{
    //设置回调
    NSDictionary *sendDataDic = @{@"type":type,
                                  @"date":date,
                                  @"location":location,
                                  @"org":org,
                                  @"resultL":resultL,
                                  @"resultS":resultS,
                                  @"resultR":resultR,
                                  @"resultW":resultW,
                                  @"resultScore":resultScore
    };
    
    //Block传值step 3:传值类将要传的值传入自己的block中
    self.sendValueBlock(sendDataDic);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    NSInteger tfTag = textField.tag - TEXTFIELD_TAG;
    
    if(tfTag == 1){
        //考试类型
        [AvalonsoftPickerView showStringPickerWithTitle:@"" DataSource:@[@"ACT", @"SSAT", @"TOEFL", @"SAT", @"GMAT"] DefaultSelValue:@"TOEFL" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow){
            //回调
            
            self->type = selectValue;
            self->typeTextField.text = selectValue;
            
            //判断保存按钮是否可点击
            [self isShowSavaButton];

        }];

    }else if(tfTag == 2){
        //考试日期
        NSDate *now = [NSDate date];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *nowStr = [fmt stringFromDate:now];

        [AvalonsoftPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:@"" MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue){
            //回调
            self->date = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            self->dateTextField.text = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            
            //判断保存按钮是否可点击
            [self isShowSavaButton];

        }];

    }else {
    
        NSString *title = @"";
        NSString *content = @"";
        if(tfTag == 3){
            title = @"考试地点";
            content = location;
            
        }else if(tfTag == 4){
            title = @"参加的培训机构";
            content = org;
            
        }else if(tfTag == 5){
            title = @"L";
            content = resultL;
        
        }else if(tfTag == 6){
            title = @"S";
            content = resultS;
        
        }else if(tfTag == 7){
            title = @"R";
            content = resultR;
        
        }else if(tfTag == 8){
            title = @"W";
            content = resultW;
        
        }else if(tfTag == 9){
            title = @"总分";
            content = resultScore;
        }
        
        //通过字典将值传到后台
        NSDictionary *sendDataDic = @{@"title":title,
                                      @"content":content
        };
        
        MineResultShowContentEditViewController *contentEditVC = [[MineResultShowContentEditViewController alloc] init];
        //设置block回调
        [contentEditVC setSendValueBlock:^(NSDictionary *valueDict){
            //回调函数
            NSString *returnContent = valueDict[@"content"];
            
            if(tfTag == 3){
                self->location = returnContent;
                self->locationTextField.text = returnContent;;
                
            }else if(tfTag == 4){
                self->org = returnContent;
                self->orgTextField.text = returnContent;;
                
            }else if(tfTag == 5){
                self->resultL = returnContent;
                self->resultLTextField.text = returnContent;;
            
            }else if(tfTag == 6){
                self->resultS = returnContent;
                self->resultSTextField.text = returnContent;;
            
            }else if(tfTag == 7){
                self->resultR = returnContent;
                self->resultRTextField.text = returnContent;;
            
            }else if(tfTag == 8){
                self->resultW = returnContent;
                self->resultWTextField.text = returnContent;;
            
            }else if(tfTag == 9){
                self->resultScore = returnContent;
                self->resultScoreTextField.text = returnContent;;
            }
            
            //判断保存按钮是否可点击
            [self isShowSavaButton];
            
        }];
        
        contentEditVC.dataDic = sendDataDic;
        [self.navigationController pushViewController:contentEditVC animated:YES];
    
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

#pragma mark - 判断是否显示保存按钮 -
-(void)isShowSavaButton
{
    if(![type isEqualToString:@""] && ![date isEqualToString:@""] && ![location isEqualToString:@""]
       && ![org isEqualToString:@""] && ![resultL isEqualToString:@""] && ![resultS isEqualToString:@""]
       && ![resultR isEqualToString:@""] && ![resultW isEqualToString:@""] && ![resultScore isEqualToString:@""]){
        
        operateButton.hidden = YES;
        clickableOperateButton.hidden = NO;
        
    }else{
        
        operateButton.hidden = NO;
        clickableOperateButton.hidden = YES;
    }
}

@end
