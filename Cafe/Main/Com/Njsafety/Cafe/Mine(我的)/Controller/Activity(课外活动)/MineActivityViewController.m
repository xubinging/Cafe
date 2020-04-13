//
//  MineActivityViewController.m
//  Cafe
//
//  Created by leo on 2020/1/9.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineActivityViewController.h"

#import "MineActivityModel.h"
#import "MineActivityTableViewCell.h"

#import "MineActivityDetailViewController.h"    //课外活动详情

@interface MineActivityViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
    
    @private UIButton *addButton;           //添加
    
    @private BOOL isShowChinese;            //是否显示中文
}

@property (nonatomic,strong) UITableView *activityTableView;
@property (nonatomic,strong) NSArray *activityArray;

@end

@implementation MineActivityViewController

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
    
    isShowChinese = YES;
    
    //造数据
    _activityArray = nil;
    NSMutableArray *tempArray = [NSMutableArray array];

    for(int i=0; i<20; i++){

        NSString *showLanguage = @"ZH";
        NSInteger index = i+1;
        
        NSDictionary *dic = @{
            @"index":@(index),
            @"name":[NSString stringWithFormat:@"大学生公益 %ld",index],
            @"role":[NSString stringWithFormat:@"领导者 %ld",index],
            @"startTime":@"2019-12-19",
            @"endTime":@"2019-12-19",
            @"content":@"大学生公益活动大学生公益活动大学生公益活动大学生公益活动大学生公益活动大学生公益活动大学生公益活动大学生公益活动",
            @"showLanguage":showLanguage
        };
        
        MineActivityModel *model = [MineActivityModel modelWithDict:dic];
        [tempArray addObject:model];

    }

    _activityArray = [tempArray copy];
    
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"课外活动" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    _activityTableView = [UITableView new];
    [self.view addSubview:_activityTableView];
    [_activityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
    }];
    [_activityTableView setBackgroundColor:[UIColor clearColor]];
    _activityTableView.bounces = YES;
    _activityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_activityTableView registerClass:[MineActivityTableViewCell class] forCellReuseIdentifier:@"MineActivityTableViewCell"];
    _activityTableView.delegate = self;
    _activityTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _activityTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _activityTableView.showsVerticalScrollIndicator = NO;
    
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
    return 144;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.activityArray.count;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MineActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineActivityTableViewCell"];

    //更新cell，注意这里是根据section下标取值的
    [cell updateCellWithModel:self.activityArray[indexPath.section]];

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
    
    MineActivityModel *slctModel = self.activityArray[indexPath.section];

    NSDictionary *sendDic = @{
        @"slctModel":slctModel
    };

    MineActivityDetailViewController *detailVC = [MineActivityDetailViewController new];

    //设置block回调
    [detailVC setSendValueBlock:^(NSDictionary *valueDict){
        //回调函数
        MineActivityModel *modelReturn = valueDict[@"modelReturn"];
        
        slctModel.name = modelReturn.name;
        slctModel.role = modelReturn.role;
        slctModel.startTime = modelReturn.startTime;
        slctModel.endTime = modelReturn.endTime;
        slctModel.content = modelReturn.content;

        [self.activityTableView reloadData];
    }];

    detailVC.dataDic = sendDic;

    [self.navigationController pushViewController:detailVC animated:YES];
    
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
//    MineResultShowViewController *showVC = [MineResultShowViewController new];
//
//    //设置block回调
//    [showVC setSendValueBlock:^(NSDictionary *valueDict){
//        //回调函数
//        NSString *type = valueDict[@"type"];
//        NSString *date = valueDict[@"date"];
//        NSString *location = valueDict[@"location"];
//        NSString *org = valueDict[@"org"];
//        NSString *resultL = valueDict[@"resultL"];
//        NSString *resultS = valueDict[@"resultS"];
//        NSString *resultR = valueDict[@"resultR"];
//        NSString *resultW = valueDict[@"resultW"];
//        NSString *resultScore = valueDict[@"resultScore"];
//        NSString *showLanguage = @"";
//
//        if(self->isShowChinese){
//            showLanguage = @"ZH";
//        }else{
//            showLanguage = @"EN";
//        }
//
//        NSMutableArray *tempArr = [NSMutableArray array];
//        for(MineResultModel *model in self.resultArray){
//            [tempArr addObject:model];
//        }
//
//        //把刚才新加的数据加入到数据列表中
//        NSDictionary *dic = @{
//            @"resultIndex":@(tempArr.count + 1),
//            @"resultType":type,
//            @"resultDate":date,
//            @"resultLocation":location,
//            @"resultOrg":org,
//            @"resultL":resultL,
//            @"resultS":resultS,
//            @"resultR":resultR,
//            @"resultW":resultW,
//            @"resultScore":resultScore,
//            @"showLanguage":showLanguage
//        };
//
//        MineResultModel *model = [MineResultModel modelWithDict:dic];
//        [tempArr addObject:model];
//
//        //按照 resultIndex 进行降序排序，这里用的是描述类排序，排序字段一定要和类中写的一致
//        NSSortDescriptor *resultIndexSortDesc = [[NSSortDescriptor alloc] initWithKey:@"resultIndex" ascending:NO];
//        [tempArr sortUsingDescriptors:@[resultIndexSortDesc]];
//
//        self.resultArray = [tempArr copy];
//
//        [self.resultTableView reloadData];
//
//    }];
//
//    showVC.dataDic = @{};
//
//    [self.navigationController pushViewController:showVC animated:YES];
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
        for(MineActivityModel *model in self.activityArray){
            model.showLanguage = @"EN";
        }
        [self.activityTableView reloadData];
        
    }else{
        //切换成中文
        isShowChinese = YES;
        
        NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"EN" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
        [rightButton setAttributedTitle:rightButtonString forState:UIControlStateNormal];
        
        //更新数据源
        for(MineActivityModel *model in self.activityArray){
            model.showLanguage = @"ZH";
        }
        [self.activityTableView reloadData];
        
    }
}

@end
