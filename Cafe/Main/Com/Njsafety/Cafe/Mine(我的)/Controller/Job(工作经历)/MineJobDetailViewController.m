//
//  MineJobDetailViewController.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineJobDetailViewController.h"

#import "MineJobModel.h"
#import "MineEditWorkViewController.h"
#import "MineDetailCommonModel.h"
#import "MineDetailCommonTableViewCell.h"

@interface MineJobDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
    
    @private UIView *contentView;           //内容
    
    @private UITextView *contentTextView;
    
    @private MineJobModel *slctModel;
}

@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) NSArray *detailArray;

@end

@implementation MineJobDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initVars];
    [self initSharedPreferences];
    [self getParentVars];
    [self initNavigationView];
    [self initView];
    [self setData];
    [self queryMineWorkDetails];
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
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 5*48 + 200));
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
        make.height.mas_equalTo(@(5*48));
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

    //内容
    contentTextView = [UITextView new];
    [contentView addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailTableView.mas_bottom).offset(15);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.height.mas_equalTo(@(170));
    }];
    contentTextView.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0].CGColor;
    contentTextView.layer.cornerRadius = 8;
    [contentTextView setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
    [contentTextView setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
}

#pragma mark - 设置参数 -
-(void)setData
{
    _detailArray = nil;
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSString *name = slctModel.companyName;
    NSString *location = slctModel.location;
    NSString *position = slctModel.position;
    NSString *startTime = slctModel.workStartDate;
    NSString *endTime = slctModel.workEndDate;
    NSString *content = slctModel.Description;

    NSString *showLanguage = slctModel.showLanguage;

    for(int i=0; i<5; i++){
        if(i==0){
            NSString *title = @"公司/机构名称:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Company:";
            }

            NSDictionary *dic = @{
                @"title":title,
                @"content":name
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];

        }else if(i==1){
            NSString *title = @"公司所在地:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Location:";
            }

            NSDictionary *dic = @{
                @"title":title,
                @"content":location
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];

        }else if(i==2){
            NSString *title = @"职位:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Position:";
            }

            NSDictionary *dic = @{
                @"title":title,
                @"content":position
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
        }
    }

    _detailArray = [tempArray copy];

    //设置内容
    if(![content isEqualToString:@""]){
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:content attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        [contentTextView setAttributedText:string];

    }else{
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"您可以在这里输入内容…"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
        [contentTextView setAttributedText:string];
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
    NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
    if (slctModel) {
       [sendDic setValue:slctModel forKey:@"slctModel"];
    }

    MineEditWorkViewController *showVC = [MineEditWorkViewController new];
    showVC.dataDic = [sendDic copy];
    [self.navigationController pushViewController:showVC animated:YES];

    //设置block回调
    __weak typeof(self) weakSelf = self;
    [showVC setSendValueBlock:^(NSDictionary *valueDict){
       __strong typeof(weakSelf) strongSelf = weakSelf;
       
       [strongSelf queryMineWorkDetails];
    }];
}

#pragma mark - 网络请求
-(void)queryMineWorkDetails
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            NSString *url = [[NSString alloc] init];
            NSString *ID = strongSelf->slctModel.ID;
            url = [COMMON_SERVER_URL stringByAppendingFormat:@"/%@=%@",MINE_MY_WORK_DETAILS, ID];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithActionUrlAndParam:url method:HttpRequestPost paramenters:root prepareExecute:^{
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        strongSelf->slctModel = [MineJobModel modelWithDict:rspData];
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

@end
