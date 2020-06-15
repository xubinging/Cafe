//
//  MineRewordDetailViewController.m
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineRewordDetailViewController.h"

#import "MineRewordModel.h"

#import "MineDetailCommonModel.h"
#import "MineDetailRewordAndSkillTableViewCell.h"
#import "MineEditRewordAndSkillViewController.h"

@interface MineRewordDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
    
    @private UIView *contentView;           //内容
    
    @private MineRewordModel *slctModel;
}

@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) NSArray *detailArray;

@end

@implementation MineRewordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self getParentVars];
    [self initNavigationView];
    [self initView];
    [self queryMineRewordDetails];
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
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 450));
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
    [_detailTableView registerClass:[MineDetailRewordAndSkillTableViewCell class] forCellReuseIdentifier:@"MineDetailRewordAndSkillTableViewCell"];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _detailTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _detailTableView.showsVerticalScrollIndicator = NO;

}

#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 144;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MineDetailRewordAndSkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineDetailRewordAndSkillTableViewCell"];

    //更新cell
    [cell updateCellWithModel:slctModel];

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
    if (slctModel.awardName) {
        [sendDic setValue:slctModel.awardName forKey:@"name"];
    }
    if (slctModel.awardDate) {
        [sendDic setValue:slctModel.awardDate forKey:@"date"];
    }
    if (slctModel.rankOrLevel) {
        [sendDic setValue:slctModel.rankOrLevel forKey:@"level"];
    }
    if (slctModel.ID) {
        [sendDic setValue:slctModel.ID forKey:@"id"];
    }
    
    [sendDic setValue:@"awardEdit" forKey:@"type"];

    MineEditRewordAndSkillViewController *showVC = [MineEditRewordAndSkillViewController new];
    showVC.dataDic = [sendDic copy];
    [self.navigationController pushViewController:showVC animated:YES];

    //设置block回调
    __weak typeof(self) weakSelf = self;
    [showVC setSendValueBlock:^(NSDictionary *valueDict){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf queryMineRewordDetails];
    }];
}


#pragma mark - 网络请求
-(void)queryMineRewordDetails
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            NSString *url = [[NSString alloc] init];
            NSString *ID = strongSelf->slctModel.ID;
            url = [COMMON_SERVER_URL stringByAppendingFormat:@"/%@=%@",MINE_MY_EDU_AWARD_DETAILS, ID];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithActionUrlAndParam:url method:HttpRequestPost paramenters:root prepareExecute:^{
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        strongSelf->slctModel = [MineRewordModel modelWithDict:rspData];
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
