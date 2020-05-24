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
    @private UIView *moreActionView;

    @private UIView *contentView;           //内容
    
    @private UISwitch *showSwitch;          //显示开关
    
}

@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) NSMutableArray *detailArray;

@end

@implementation MineEducationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self setData];
    [self queryMineEducationDetails];
}

- (NSMutableArray *)detailArray
{
    return _detailArray?:(_detailArray = [NSMutableArray array]);
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
    NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"更多" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
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
    NSString *country = self.model.country;
    NSString *school = self.model.institutionName;
    NSString *stage = self.model.level;
    NSString *startTime = self.model.startTime;
    NSString *endTime = self.model.graduationDate;
    NSString *degreeType = self.model.degreeType;
    NSString *major = self.model.major;
    NSString *score = self.model.grades;
    NSString *status = self.model.status;
    
    NSString *showLanguage = self.model.showLanguage;
    
    for(int i=0; i<9; i++){
        if(i==0){
            NSString *title = @"国家:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Country:";
            }
            
            MineDetailCommonModel *curModel = [MineDetailCommonModel new];
            curModel.title = title;
            if (country) {
                curModel.content = country;
            }
            [self.detailArray addObject:curModel];
            
        }else if(i==1){
            NSString *title = @"学校/机构名称:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"School:";
            }
            
            MineDetailCommonModel *curModel = [MineDetailCommonModel new];
            curModel.title = title;
            if (school) {
                curModel.content = school;
            }
            [self.detailArray addObject:curModel];
            
        }else if(i==2){
            NSString *title = @"教育阶段:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Stage:";
            }
            
            MineDetailCommonModel *curModel = [MineDetailCommonModel new];
            curModel.title = title;
            if (stage) {
                curModel.content = stage;
            }
            [self.detailArray addObject:curModel];
            
        }else if(i==3){
            NSString *title = @"开始时间:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Start Time:";
            }
            
            MineDetailCommonModel *curModel = [MineDetailCommonModel new];
            curModel.title = title;
            if (startTime) {
                curModel.content = startTime;
            }
            [self.detailArray addObject:curModel];
            
        }else if(i==4){
            NSString *title = @"结束时间:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"End Time:";
            }
            
            MineDetailCommonModel *curModel = [MineDetailCommonModel new];
            curModel.title = title;
            if (endTime) {
                curModel.content = endTime;
            }
            [self.detailArray addObject:curModel];
            
        }else if(i==5){
            NSString *title = @"学位类型:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Degree Type:";
            }
            
            MineDetailCommonModel *curModel = [MineDetailCommonModel new];
            curModel.title = title;
            if (degreeType) {
                curModel.content = degreeType;
            }
            [self.detailArray addObject:curModel];
            
        }else if(i==6){
            NSString *title = @"专业:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Major:";
            }
            
            MineDetailCommonModel *curModel = [MineDetailCommonModel new];
            curModel.title = title;
            if (major) {
                curModel.content = major;
            }
            [self.detailArray addObject:curModel];
            
        }else if(i==7){
            NSString *title = @"成绩:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Score:";
            }
            
            MineDetailCommonModel *curModel = [MineDetailCommonModel new];
            curModel.title = title;
            if (score) {
                curModel.content = score;
            }
            [self.detailArray addObject:curModel];
            
        }else if(i==8){
            NSString *title = @"状态:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"State:";
            }
            
            NSString *showStatus = @"";
            if([status isEqualToString:@"0"]){
                showStatus = @"未毕业 Not Graduated";
            }else{
                showStatus = @"毕业 Graduated";
            }
            
            
            MineDetailCommonModel *curModel = [MineDetailCommonModel new];
            curModel.title = title;
            if (status) {
                curModel.content = status;
            }
            [self.detailArray addObject:curModel];
        }
    }
    
    //设置开关状态
    if([self.model.showFlg isEqualToString:@"1"]){
        showSwitch.on = YES;

    }else if([self.model.showFlg isEqualToString:@"0"]){
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
        self.model.showFlg = @"1";
        [AvalonsoftToast showWithMessage:@"设置成功"];
        
    }else{
        self.model.showFlg = @"0";
        [AvalonsoftToast showWithMessage:@"已取消设置"];
    }
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    if (self.sendValueBlock) {
        self.sendValueBlock(self.model);
    }
    [self.navigationController popViewControllerAnimated:YES];    
}

#pragma mark - 编辑按钮点击 -
-(void)rightButtonClick
{
    moreActionView = [UIView new];
    [self.view addSubview:moreActionView];
    [moreActionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(rightButton.mas_bottom).offset(5);
        make.right.equalTo(rightButton);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    moreActionView.layer.cornerRadius = 10;
    moreActionView.layer.masksToBounds = YES;
    [moreActionView setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *editButton = [UIButton new];
    [moreActionView addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(moreActionView);
        make.left.equalTo(moreActionView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    editButton.adjustsImageWhenHighlighted = NO;
    NSMutableAttributedString *editButtonString = [[NSMutableAttributedString alloc] initWithString:@"编辑" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor blackColor]}];
    [editButton setAttributedTitle:editButtonString forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *splitView = [UIView new];
    [moreActionView addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(editButton.mas_bottom).offset(1);
        make.left.equalTo(moreActionView).offset(5);
        make.right.equalTo(moreActionView).offset(-5);
        make.height.mas_equalTo(@1);
    }];
    [splitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    [moreActionView layoutIfNeeded];

    
    UIButton *deleteButton = [UIButton new];
    [moreActionView addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(editButton.mas_bottom);
        make.left.equalTo(moreActionView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    deleteButton.adjustsImageWhenHighlighted = NO;
    NSMutableAttributedString *deleteButtonString = [[NSMutableAttributedString alloc] initWithString:@"删除" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor blackColor]}];
    [deleteButton setAttributedTitle:deleteButtonString forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)editButtonClick
{
//    moreActionView.hidden = YES;
//    [moreActionView removeFromSuperview];
//
//    MineAddLearningViewController *showVC = [MineAddLearningViewController new];
//    showVC.model = self.model;
//    [self.navigationController pushViewController:showVC animated:YES];
//
//    __weak typeof(self) weakSelf = self;
//    [showVC setSendValueBlock:^(MineLearningModel *model){
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//
//        [strongSelf queryMineLearningDetails];
//    }];
}

- (void)deleteButtonClick
{
    moreActionView.hidden = YES;
    [moreActionView removeFromSuperview];
    [self deleteMineEducation];
}

#pragma mark - 网络请求
-(void)queryMineEducationDetails
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            NSString *url = [[NSString alloc] init];
            NSString *ID = self.model.ID;
            url = [COMMON_SERVER_URL stringByAppendingFormat:@"/%@%@",MINE_MY_EDUCATION_DETAILS, ID];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithActionUrlAndParam:url method:HttpRequestPost paramenters:root prepareExecute:^{
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        strongSelf.model = [MineEducationModel modelWithDict:rspData];
                        [strongSelf.detailArray removeAllObjects];
                        [strongSelf setData];
                        [strongSelf.detailTableView reloadData];
                    }
                } @catch (NSException *exception) {
                    @throw exception;
                    //给出提示信息
                    [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
                }
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
            }];
            
        } else {
            //没网
            //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}


-(void)deleteMineEducation
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            NSString *url = [[NSString alloc] init];
            NSString *ID = self.model.ID;
            url = [COMMON_SERVER_URL stringByAppendingFormat:@"/%@?id=%@",MINE_MY_EDUCATION_DELETE, ID];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithActionUrlAndParam:url method:HttpRequestPost paramenters:root prepareExecute:^{
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        MineEducationModel *model = [MineEducationModel modelWithDict:rspData];

                        if (self.sendValueBlock) {
                            self.sendValueBlock(model);
                        }

                        [strongSelf.navigationController popViewControllerAnimated:YES];
                    }
                } @catch (NSException *exception) {
                    @throw exception;
                    //给出提示信息
                    [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
                }
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                //请求失败
                NSLog(@"%@",error);
            }];
            
        } else {
            //没网
            //            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"请检查网络" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}

@end
