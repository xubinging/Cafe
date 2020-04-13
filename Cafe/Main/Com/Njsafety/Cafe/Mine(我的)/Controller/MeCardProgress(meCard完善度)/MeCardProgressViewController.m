//
//  MeCardProgressViewController.m
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MeCardProgressViewController.h"

#import "MeCardProgressModel.h"
#import "MeCardProgressTableViewCell.h"

@interface MeCardProgressViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
}

@property (nonatomic,strong) UITableView *meCardInfoTableView;
@property (nonatomic,strong) NSArray *meCardInfoArray;

@end

@implementation MeCardProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);

    //造数据
    NSArray *titleArr = @[@"基本信息1", @"基本信息2", @"基本信息3", @"考试成绩", @"OFFER", @"馆内信息1", @"馆内信息2", @"教育背景", @"学术经历", @"所获奖项与技能", @"工作经历", @"课外活动", @"历史时刻"];
    
    _meCardInfoArray = nil;
    NSMutableArray *tempArray = [NSMutableArray array];

    for(int i=0; i<titleArr.count; i++){
        
        NSString *isCompleteFlg = @"0";
        if(i==0 || i==1 || i==2){
            isCompleteFlg = @"1";
        }
        
        NSDictionary *dic = @{
            @"title":titleArr[i],
            @"isCompleteFlg":isCompleteFlg
        };
        MeCardProgressModel *model = [MeCardProgressModel modelWithDict:dic];
        [tempArray addObject:model];
        
    }

    _meCardInfoArray = [tempArray copy];
    
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"meCard完善度"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    CGFloat bottomDistance = 0;
    if(!IS_iPhoneX){
        bottomDistance = 15;
    }
    
    _meCardInfoTableView = [UITableView new];
    [self.view addSubview:_meCardInfoTableView];
    [_meCardInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin-bottomDistance);
    }];
    [_meCardInfoTableView setBackgroundColor:[UIColor whiteColor]];
    _meCardInfoTableView.bounces = YES;
    _meCardInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_meCardInfoTableView registerClass:[MeCardProgressTableViewCell class] forCellReuseIdentifier:@"MeCardProgressTableViewCell"];
    _meCardInfoTableView.delegate = self;
    _meCardInfoTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _meCardInfoTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _meCardInfoTableView.showsVerticalScrollIndicator = NO;
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
    return self.meCardInfoArray.count;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MeCardProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeCardProgressTableViewCell"];
    
    //更新cell，注意这里是根据section下标取值的
    [cell updateCellWithModel:self.meCardInfoArray[indexPath.row]];

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

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
