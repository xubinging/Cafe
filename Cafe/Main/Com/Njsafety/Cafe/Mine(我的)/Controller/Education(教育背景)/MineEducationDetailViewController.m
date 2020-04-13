//
//  MineEducationDetailViewController.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//
//  教育背景详情

#import "MineEducationDetailViewController.h"

#import "MineEducationModel.h"

#import "MineDetailCommonModel.h"
#import "MineDetailCommonTableViewCell.h"

@interface MineEducationDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
    
    @private UIView *contentView;           //内容
    
    @private UISwitch *showSwitch;          //显示开关
    
    @private MineEducationModel *slctModel;
}

@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) NSArray *detailArray;

@end

@implementation MineEducationDetailViewController

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
        slctModel = _dataDic[@"slctModel"];
    }
}

#pragma mark - 初始化导航视图 -
-(void)initNavigationView
{
    //1.顶部导航视图
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
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //右上角操作按钮
    rightButton = [UIButton new];
    [navigationView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(navigationView).offset(-10);
        make.top.equalTo(backButton).offset(1);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"编辑" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [rightButton setAttributedTitle:rightButtonString forState:UIControlStateNormal];
    //右上角按钮点击
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //内容视图
    contentView = [UIView new];
    [navigationView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 9*48+56));
    }];
    contentView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contentView.layer.cornerRadius = 10;
    contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,0);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 10;
    
    //列表
    _detailTableView = [UITableView new];
    [contentView addSubview:_detailTableView];
    [_detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.height.mas_equalTo(@(9*48));
    }];
    [_detailTableView setBackgroundColor:[UIColor clearColor]];
    _detailTableView.bounces = YES;
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_detailTableView registerClass:[MineDetailCommonTableViewCell class] forCellReuseIdentifier:@"MineDetailCommonTableViewCell"];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _detailTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _detailTableView.showsVerticalScrollIndicator = NO;
    
    //滑动开关
    UILabel *showSwitchLabel = [UILabel new];
    [contentView addSubview:showSwitchLabel];
    [showSwitchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailTableView.mas_bottom).offset(17);
        make.left.equalTo(contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(180, 22));
    }];
    showSwitchLabel.numberOfLines = 0;
    showSwitchLabel.textAlignment = NSTextAlignmentLeft;
    showSwitchLabel.alpha = 1.0;
    NSMutableAttributedString *showSwitchLabelString = [[NSMutableAttributedString alloc] initWithString:@"设为头像下方显示的院校" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    showSwitchLabel.attributedText = showSwitchLabelString;
    
    //设置开关；添加在self.view上，不然点击没反应
    showSwitch = [UISwitch new];
    [self.view addSubview:showSwitch];
    [showSwitch mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(contentView.mas_bottom).offset(-13);
        make.right.equalTo(contentView).offset(-15);;
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
//    // 设置控件开启状态填充色
//    promptToneSwitch.onTintColor = RGBA_GGCOLOR(52, 199, 92, 1);
//    // 设置控件关闭状态填充色
//    promptToneSwitch.tintColor = RGBA_GGCOLOR(0, 0, 0, 1);
//    // 设置控件开关按钮颜色
//    promptToneSwitch.thumbTintColor = [UIColor whiteColor];
    // 当控件值变化时触发changeColor方法
    [showSwitch addTarget:self action:@selector(showSwitchChange:) forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - 设置参数 -
-(void)setData
{
    //造数据
    _detailArray = nil;
    NSMutableArray *tempArray = [NSMutableArray array];

    NSString *country = slctModel.country;
    NSString *school = slctModel.school;
    NSString *stage = slctModel.stage;
    NSString *startTime = slctModel.startTime;
    NSString *endTime = slctModel.endTime;
    NSString *degreeType = slctModel.degreeType;
    NSString *major = slctModel.major;
    NSString *score = slctModel.score;
    NSString *state = slctModel.state;
    
    NSString *showLanguage = slctModel.showLanguage;
    
    for(int i=0; i<9; i++){
        if(i==0){
            NSString *title = @"国家:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Country:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":country
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==1){
            NSString *title = @"学校/机构名称:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"School:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":school
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==2){
            NSString *title = @"教育阶段:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Stage:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":stage
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==3){
            NSString *title = @"开始时间:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Start Time:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":startTime
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==4){
            NSString *title = @"结束时间:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"End Time:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":endTime
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==5){
            NSString *title = @"学位类型:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Degree Type:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":degreeType
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==6){
            NSString *title = @"专业:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Major:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":major
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==7){
            NSString *title = @"成绩:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Score:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":score
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==8){
            NSString *title = @"状态:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"State:";
            }
            
            NSString *showState = @"";
            if([state isEqualToString:@"0"]){
                showState = @"未毕业 Not Graduated";
            }else{
                showState = @"毕业 Graduated";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":showState
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }
    }
    
    _detailArray = [tempArray copy];
    
    //设置开关状态
    if([slctModel.showFlg isEqualToString:@"1"]){
        showSwitch.on = YES;

    }else if([slctModel.showFlg isEqualToString:@"0"]){
        showSwitch.on = NO;
    }
    
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailArray.count;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MineDetailCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineDetailCommonTableViewCell"];

    //更新cell
    [cell updateCellWithModel:self.detailArray[indexPath.row]];

    return cell;

}

#pragma mark - 设置header高度 -
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - 设置header样式 -
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
    
    return nil;
}

#pragma mark - 点击cell -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//**********    tableView代理 end   **********//

#pragma mark - 提示音开关 -
-(void)showSwitchChange:(UISwitch *)swi{
    if(swi.isOn){
        slctModel.showFlg = @"1";
        [AvalonsoftToast showWithMessage:@"设置成功"];
        
    }else{
        slctModel.showFlg = @"0";
        [AvalonsoftToast showWithMessage:@"已取消设置"];
    }
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    //设置回调    
    NSDictionary *sendDataDic = @{
        @"modelReturn":slctModel
    };
    
    //Block传值step 3:传值类将要传的值传入自己的block中
    self.sendValueBlock(sendDataDic);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 编辑按钮点击 -
-(void)rightButtonClick
{
//    NSDictionary *sendDic = @{
//        @"type":type,
//        @"date":date,
//        @"location":location,
//        @"org":org,
//        @"resultL":resultL,
//        @"resultS":resultS,
//        @"resultR":resultR,
//        @"resultW":resultW,
//        @"resultScore":resultScore
//    };
//
//    MineResultShowViewController *showVC = [MineResultShowViewController new];
//
//    //设置block回调
//    [showVC setSendValueBlock:^(NSDictionary *valueDict){
//
//        //回调函数
//        self->type = valueDict[@"type"];
//        self->date = valueDict[@"date"];
//        self->location = valueDict[@"location"];
//        self->org = valueDict[@"org"];
//        self->resultL = valueDict[@"resultL"];
//        self->resultS = valueDict[@"resultS"];
//        self->resultR = valueDict[@"resultR"];
//        self->resultW = valueDict[@"resultW"];
//        self->resultScore = valueDict[@"resultScore"];
//
//        [self setData];
//
//    }];
//
//    showVC.dataDic = sendDic;
//
//    [self.navigationController pushViewController:showVC animated:YES];
}

@end
