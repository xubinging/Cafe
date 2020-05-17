//
//  MineResultViewController.m
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//
//  考试成绩

#import "MineResultViewController.h"

#import "MineResultModel.h"
#import "MineResultTableViewCell.h"

#import "MineResultDetailViewController.h"  //成绩详情
#import "MineResultShowViewController.h"    //晒晒成绩

@interface MineResultViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
    
    @private UIButton *showResultButton;    //晒晒成绩
    
    @private BOOL isShowChinese;            //是否显示中文
}

@property (nonatomic,strong) UITableView *resultTableView;
@property (nonatomic,strong) NSMutableArray *resultArray;

@end

@implementation MineResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self queryMineExamScoreList];
}


- (NSMutableArray *)resultArray
{
    return _resultArray?:(_resultArray = [NSMutableArray array]);
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);
    isShowChinese = YES;
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
        make.size.mas_equalTo(CGSizeMake(22, 20));
    }];
    NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"EN" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [rightButton setAttributedTitle:rightButtonString forState:UIControlStateNormal];
    //左上角退出按钮
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"考试成绩" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    _resultTableView = [UITableView new];
    [self.view addSubview:_resultTableView];
    [_resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin - 80);
    }];
    [_resultTableView setBackgroundColor:[UIColor clearColor]];
    _resultTableView.bounces = YES;
    _resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_resultTableView registerClass:[MineResultTableViewCell class] forCellReuseIdentifier:@"MineResultTableViewCell"];
    _resultTableView.delegate = self;
    _resultTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _resultTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _resultTableView.showsVerticalScrollIndicator = NO;
    
    //晒晒成绩 按钮
    //注意这里不能用 Mansory布局然后用[self.view layoutIfNeeded];方法刷新布局，会报警告。
    showResultButton = [UIButton new];
    [self.view addSubview:showResultButton];
    showResultButton.frame = CGRectMake(10, SCREEN_HEIGHT - 46 - 20 - TabbarSafeBottomMargin , SCREEN_WIDTH - 20, 46);
    showResultButton.layer.cornerRadius = 23;
    showResultButton.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.3].CGColor;
    showResultButton.layer.shadowOffset = CGSizeMake(0,5);
    showResultButton.layer.shadowOpacity = 1;
    showResultButton.layer.shadowRadius = 15;

    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = showResultButton.bounds;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 23;
    [showResultButton.layer addSublayer:gl];
    
    //设置文字
    NSMutableAttributedString *showResultButtonString = [[NSMutableAttributedString alloc] initWithString:@"晒晒成绩"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    [showResultButton setAttributedTitle:showResultButtonString forState:UIControlStateNormal];
    
    //添加事件
    [showResultButton addTarget:self action:@selector(showResultButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resultArray.count;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MineResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineResultTableViewCell"];

    [cell updateCellWithModel:self.resultArray[indexPath.section]];

    return cell;

}

#pragma mark - 设置header高度 -
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - 设置header样式 -
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - 点击cell -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MineResultModel *slctModel = self.resultArray[indexPath.section];
    MineResultDetailViewController *detailVC = [MineResultDetailViewController new];
    detailVC.model = slctModel;
    [self.navigationController pushViewController:detailVC animated:YES];

    __weak typeof(self) weakSelf = self;
    [detailVC setSendValueBlock:^(MineResultModel *model){
        __strong typeof(weakSelf) strongSelf = weakSelf;

        [strongSelf queryMineExamScoreList];
    }];
    
}
                 
#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 晒晒成绩按钮 -
-(void)showResultButtonClick
{
    MineResultShowViewController *showVC = [MineResultShowViewController new];
    MineResultModel *model = [MineResultModel new];
    model.examType = @"TOEFL";
    showVC.model = model;
    [self.navigationController pushViewController:showVC animated:YES];


    __weak typeof(self) weakSelf = self;
    [showVC setSendValueBlock:^(MineResultModel *model){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf queryMineExamScoreList];
    }];        
}

#pragma mark - 右侧按钮点击 -
-(void)rightButtonClick
{
    if(isShowChinese){
        //切换成英文
        isShowChinese = NO;
        
        NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"ZH" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
        [rightButton setAttributedTitle:rightButtonString forState:UIControlStateNormal];
        
        //更新数据源
        for(MineResultModel *model in self.resultArray){
            model.showLanguage = @"EN";
        }
        [self.resultTableView reloadData];
        
    }else{
        //切换成中文
        isShowChinese = YES;
        
        NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"EN" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
        [rightButton setAttributedTitle:rightButtonString forState:UIControlStateNormal];
        
        //更新数据源
        for(MineResultModel *model in self.resultArray){
            model.showLanguage = @"ZH";
        }
        [self.resultTableView reloadData];
        
    }
}

#pragma mark - 网络请求
- (void)queryMineExamScoreList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:@"0" forKey:@"delSign"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EXAM_SCORE_LIST method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        NSArray *rspDataArray = rspData[@"dataList"];
                       [strongSelf.resultArray removeAllObjects];
                       for(int i=0; i<rspDataArray.count; i++){
                           MineResultModel *model = [MineResultModel modelWithDict:rspDataArray[i]];
                           [strongSelf.resultArray addObject:model];
                       }
                        
                        [strongSelf.resultTableView reloadData];
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
