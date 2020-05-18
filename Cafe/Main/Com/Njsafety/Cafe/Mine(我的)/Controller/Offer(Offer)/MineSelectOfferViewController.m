//
//  MineSelectOfferViewController.m
//  Cafe
//
//  Created by migu on 2020/5/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineSelectOfferViewController.h"
#import "MineResultModel.h"
#import "MineSelectOfferScoreTableViewCell.h"


#define TEXTFIELD_TAG 10000

@interface MineSelectOfferViewController ()<UITableViewDelegate, UITableViewDataSource>

{
    @private UIButton *backButton;
    @private UIButton *sureButton;
    @private UIView *splitView;
    @private UIView *navigationView;
    
    @private UIView *contentView;
    @private MineResultModel *selectModel;
}

@property (nonatomic,strong) NSMutableArray *detailArray;
@property (nonatomic,strong) UITableView *detailTableView;

@end

@implementation MineSelectOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self queryMineExamScoreList];
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
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton setBackgroundImage:[UIImage imageNamed:@"login_del_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //右上角确定按钮
    sureButton = [UIButton new];
    [navigationView addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(navigationView).offset(-10);
        make.bottom.equalTo(navigationView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    sureButton.adjustsImageWhenHighlighted = NO;
    NSMutableAttributedString *saveButtonString = [[NSMutableAttributedString alloc] initWithString:@"确定"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [sureButton setAttributedTitle:saveButtonString forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //分割线
    UIView *splitView = [UIView new];
    [navigationView addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(navigationView).offset(-1);
        make.left.equalTo(navigationView).offset(10);
        make.right.equalTo(navigationView).offset(-10);
        make.height.equalTo(@1);
    }];
    splitView.layer.backgroundColor = [UIColor colorWithRed:229/255.0 green:237/255.0 blue:240/255.0 alpha:1.0].CGColor;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //内容视图
    contentView = [UIView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
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
        make.height.mas_equalTo(@(3*48));
    }];
    [_detailTableView setBackgroundColor:[UIColor clearColor]];
    _detailTableView.bounces = YES;
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_detailTableView registerClass:[MineSelectOfferScoreTableViewCell class] forCellReuseIdentifier:@"MineSelectOfferScoreTableViewCell"];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _detailTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _detailTableView.showsVerticalScrollIndicator = NO;
    _detailTableView.contentInset = UIEdgeInsetsMake(0, 0, 44 * 3, 0);
}

#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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

    MineSelectOfferScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSelectOfferScoreTableViewCell"];

    [cell updateCellWithModel:self.detailArray[indexPath.row]];

    return cell;
}

#pragma mark - 设置header高度 -
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark - 设置header样式 -
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self setupSubViewsWithType:self.model.examType view:view];
    return view;
}

#pragma mark - 点击cell -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSInteger i=0; i<self.detailArray.count; i++) {
        MineResultModel *model = self.detailArray[i];
        if (i == indexPath.row) {
            model.isSelected = YES;
            model.examType = [self bridgeExamType:model.examType];
            selectModel = model;
        } else {
            model.isSelected = NO;
        }
        
        [self.detailArray replaceObjectAtIndex:i withObject:model];
    }
    
    [self.detailTableView reloadData];
}

- (void)setupSubViewsWithType:(NSString *)type view:(UIView *)view
{
    UILabel *totalScoreLabel = [UILabel new];
    [view addSubview:totalScoreLabel];
    [totalScoreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(view);
        make.left.equalTo(view);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
    }];
    totalScoreLabel.numberOfLines = 0;
    totalScoreLabel.textAlignment = NSTextAlignmentCenter;
    totalScoreLabel.alpha = 1.0;
    [totalScoreLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];


    UILabel *scoreOneLabel = [UILabel new];
    [view addSubview:scoreOneLabel];
    [scoreOneLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(view);
        make.left.equalTo(totalScoreLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
    }];
    scoreOneLabel.numberOfLines = 0;
    scoreOneLabel.textAlignment = NSTextAlignmentCenter;
    scoreOneLabel.alpha = 1.0;
    [scoreOneLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];

            
    UILabel *scoreTwoLabel = [UILabel new];
    [view addSubview:scoreTwoLabel];
    [scoreTwoLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(view);
        make.left.equalTo(scoreOneLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
    }];
    scoreTwoLabel.numberOfLines = 0;
    scoreTwoLabel.textAlignment = NSTextAlignmentCenter;
    scoreTwoLabel.alpha = 1.0;
    [scoreTwoLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];


    UILabel *scoreThreeLabel = [UILabel new];
    [view addSubview:scoreThreeLabel];
    [scoreThreeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(view);
        make.left.equalTo(scoreTwoLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
    }];
    scoreThreeLabel.numberOfLines = 0;
    scoreThreeLabel.textAlignment = NSTextAlignmentCenter;
    scoreThreeLabel.alpha = 1.0;
    [scoreThreeLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];


    UILabel *scoreFourLabel = [UILabel new];
    [view addSubview:scoreFourLabel];
    [scoreFourLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(view);
        make.left.equalTo(scoreThreeLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/7, 44));
    }];
    scoreFourLabel.numberOfLines = 0;
    scoreFourLabel.textAlignment = NSTextAlignmentCenter;
    scoreFourLabel.alpha = 1.0;
    [scoreFourLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];


    UILabel *scoreFiveLabel = [UILabel new];
    [view addSubview:scoreFiveLabel];
    [scoreFiveLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(view);
        make.left.equalTo(scoreFourLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 20)/6, 44));
    }];
    scoreFiveLabel.numberOfLines = 0;
    scoreFiveLabel.textAlignment = NSTextAlignmentCenter;
    scoreFiveLabel.alpha = 1.0;
    [scoreFiveLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
    
    
    if ([type isEqualToString:@"TOEFL"] || [type isEqualToString:@"IELTS"]) {
        totalScoreLabel.text = @"总分";
        scoreOneLabel.text = @"L";
        scoreTwoLabel.text = @"S";
        scoreThreeLabel.text = @"R";
        scoreFourLabel.text = @"W";
    }

    
    if ([type isEqualToString:@"GRE"]) {
        totalScoreLabel.text = @"总分";
        scoreOneLabel.text = @"V";
        scoreTwoLabel.text = @"Q";
        scoreThreeLabel.text = @"AW";
    }
    
    if ([type isEqualToString:@"GMAT"]) {
        totalScoreLabel.text = @"总分";
        scoreOneLabel.text = @"V";
        scoreTwoLabel.text = @"Q";
        scoreThreeLabel.text = @"AW";
        scoreFourLabel.text = @"IR";
    }
        
    if ([type isEqualToString:@"SAT"]) {
        totalScoreLabel.text = @"总分";
        scoreOneLabel.text = @"EBRW";
        scoreTwoLabel.text = @"M";
        scoreThreeLabel.text = @"ER";
        scoreFourLabel.text = @"EA";
        scoreFiveLabel.text = @"EW";
    }
    
    if ([type isEqualToString:@"SSAT"]) {
        totalScoreLabel.text = @"总分";
        scoreOneLabel.text = @"Q";
        scoreTwoLabel.text = @"V";
        scoreThreeLabel.text = @"R";
    }
    
    if ([type isEqualToString:@"ACT"]) {
        totalScoreLabel.text = @"总分";
        scoreOneLabel.text = @"R";
        scoreTwoLabel.text = @"E";
        scoreThreeLabel.text = @"M";
        scoreFourLabel.text = @"S";
        scoreFiveLabel.text = @"W";
    }
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存按钮点击 -
-(void)sureButtonClick
{
    if (self.sendValueBlock) {
        self.sendValueBlock(selectModel);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
                       [strongSelf.detailArray removeAllObjects];
                       for(int i=0; i<rspDataArray.count; i++){
                           MineResultModel *model = [MineResultModel modelWithDict:rspDataArray[i]];
                           NSString *curExamType = [strongSelf bridgeExamType:model.examType];
                           if ([self.model.examType isEqualToString:curExamType]) {
                               [strongSelf.detailArray addObject:model];
                           }
                       }
                        
                        [strongSelf resetSize];
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

- (NSString *)bridgeExamType:(NSString *)examType
{
    NSString *curExamType = examType;
    //考试类型:类型1->TOEFL，类型2->IELTS，类型3->GRE，类型4->GMAT，类型5->SAT，类型6->SSAT，类型7->ACT
    if ([curExamType isKindOfClass:[NSString class]]) {
        switch (curExamType.integerValue) {
            case 1:
                curExamType = @"TOEFL";
                break;
            case 2:
                curExamType = @"IELTS";
                break;
            case 3:
                curExamType = @"GRE";
                break;
            case 4:
                curExamType = @"GMAT";
                break;
            case 5:
                curExamType = @"SAT";
                break;
            case 6:
                curExamType = @"SSAT";
                break;
            case 7:
                curExamType = @"ACT";
                break;
                
            default:
                break;
        }
    }
    
    return curExamType;
}

-(void)resetSize
{
    CGFloat detailTableViewHeight = 0;
    if(self.detailArray.count != 0){
        detailTableViewHeight = 44*self.detailArray.count;
    }
    
    [_detailTableView mas_updateConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(@(detailTableViewHeight));
    }];
}

@end

