//
//  MineEducationViewController.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineEducationViewController.h"

#import "MineEducationModel.h"
#import "MineEducationTableViewCell.h"

#import "MineEducationDetailViewController.h"   //教育背景详情

@interface MineEducationViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
    
    @private UIButton *addButton;           //添加
    
    @private BOOL isShowChinese;            //是否显示中文
}

@property (nonatomic,strong) UITableView *educationTableView;
@property (nonatomic,strong) NSMutableArray *educationArray;

@end

@implementation MineEducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self queryMineEducationList];
}

- (NSMutableArray *)educationArray
{
    return _educationArray?:(_educationArray = [NSMutableArray array]);
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"教育背景" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    _educationTableView = [UITableView new];
    [self.view addSubview:_educationTableView];
    [_educationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
    }];
    [_educationTableView setBackgroundColor:[UIColor clearColor]];
    _educationTableView.bounces = YES;
    _educationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_educationTableView registerClass:[MineEducationTableViewCell class] forCellReuseIdentifier:@"MineEducationTableViewCell"];
    _educationTableView.delegate = self;
    _educationTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _educationTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _educationTableView.showsVerticalScrollIndicator = NO;
    
    //添加 按钮
    //注意这里不能用 Mansory布局然后用[self.view layoutIfNeeded];方法刷新布局，会报警告。
    addButton = [UIButton new];
    [self.view addSubview:addButton];
    addButton.frame = CGRectMake(10, SCREEN_HEIGHT - 46 - 20 - TabbarSafeBottomMargin , SCREEN_WIDTH - 20, 46);
    addButton.layer.cornerRadius = 23;
    addButton.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:0.3].CGColor;
    addButton.layer.shadowOffset = CGSizeMake(0,5);
    addButton.layer.shadowOpacity = 1;
    addButton.layer.shadowRadius = 15;

    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = addButton.bounds;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 23;
    [addButton.layer addSublayer:gl];
    
    //设置文字
    NSMutableAttributedString *addButtonString = [[NSMutableAttributedString alloc] initWithString:@"添加"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    [addButton setAttributedTitle:addButtonString forState:UIControlStateNormal];
    
    //添加事件
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 192;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.educationArray.count;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MineEducationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineEducationTableViewCell"];

    //更新cell，注意这里是根据section下标取值的
    [cell updateCellWithModel:self.educationArray[indexPath.section]];

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
    MineEducationModel *model = self.educationArray[indexPath.section];
    MineEducationDetailViewController *detailVC = [MineEducationDetailViewController new];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];

    //设置block回调
    __weak typeof(self) weakSelf = self;
    [detailVC setSendValueBlock:^(MineEducationModel *model){
        __strong typeof(weakSelf) strongSelf = weakSelf;
             
        [strongSelf queryMineEducationList];
    }];
}

//**********    tableView代理 end   **********//
                 
#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加按钮 -
-(void)addButtonClick
{
//    MineAddLearningViewController*showVC = [MineAddLearningViewController new];
//    MineLearningModel *model = [MineLearningModel new];
//    showVC.model = model;
//    [self.navigationController pushViewController:showVC animated:YES];
//
//    //设置block回调
//    __weak typeof(self) weakSelf = self;
//    [showVC setSendValueBlock:^(MineLearningModel *model){
//       __strong typeof(weakSelf) strongSelf = weakSelf;
//
//       [strongSelf queryMineLearningList];
//    }];    
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
        for(MineEducationModel *model in self.educationArray){
            model.showLanguage = @"EN";
        }
        [self.educationTableView reloadData];
        
    }else{
        //切换成中文
        isShowChinese = YES;
        
        NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"EN" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
        [rightButton setAttributedTitle:rightButtonString forState:UIControlStateNormal];
        
        //更新数据源
        for(MineEducationModel *model in self.educationArray){
            model.showLanguage = @"ZH";
        }
        [self.educationTableView reloadData];
        
    }
}

#pragma mark - 网络请求
- (void)queryMineEducationList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EDUCATION_LIST method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        NSArray *rspDataArray = rspData[@"dataList"];
                        [strongSelf.educationArray removeAllObjects];
                        for(int i=0; i<rspDataArray.count; i++){
                           MineEducationModel *model = [MineEducationModel modelWithDict:rspDataArray[i]];
                           [strongSelf.educationArray addObject:model];
                        }

                        [strongSelf.educationTableView reloadData];
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
