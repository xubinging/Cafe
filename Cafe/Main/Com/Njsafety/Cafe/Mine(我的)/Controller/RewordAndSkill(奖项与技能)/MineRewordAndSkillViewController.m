//
//  MineRewordAndSkillViewController.m
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineRewordAndSkillViewController.h"
#import "MineRewordModel.h"
#import "MineRewordTableViewCell.h" //奖项
#import "MineSkillModel.h"
#import "MineSkillTableViewCell.h"  //技能
#import "MineRewordDetailViewController.h"  //奖项详情
#import "MineSkillDetailViewController.h"   //技能详情
#import "MineAddRewordAndSkillViewController.h"
#import "UIScrollView+AvalonsoftMJRefresh.h"

#define K_RewordBtn_Tag         10000
#define K_SkillBtn_Tag          20000
#define K_RewordTableView_Tag   30000
#define K_SkillTableView_Tag    40000

@interface MineRewordAndSkillViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
    
    @private UIButton *addButton;           //添加
    
    @private BOOL isShowChinese;            //是否显示中文
}

//奖项
@property (nonatomic,strong) UIButton *rewordBtn;
@property (nonatomic,strong) UITableView *rewordTableView;
@property (nonatomic,strong) NSMutableArray *rewordArray;

//技能
@property (nonatomic,strong) UIButton *skillBtn;
@property (nonatomic,strong) UITableView *skillTableView;
@property (nonatomic,strong) NSMutableArray *skillArray;

@end

@implementation MineRewordAndSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self queryMineRewordList];
    [self addPullRefreshRewordList];
}

- (NSMutableArray *)rewordArray
{
    return _rewordArray?:(_rewordArray = [NSMutableArray array]);
}

- (NSMutableArray *)skillArray
{
    return _skillArray?:(_skillArray = [NSMutableArray array]);
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

#pragma mark - 下拉刷新
- (void)addPullRefreshRewordList
{
    __weak typeof(self) weakSelf = self;
    [self.rewordTableView addHeaderWithHeaderWithBeginRefresh:NO animation:YES refreshBlock:^(NSInteger pageIndex) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf queryMineRewordList];
    }];
}

- (void)addPullRefreshSkillList
{
    __weak typeof(self) weakSelf = self;
   [self.skillTableView addHeaderWithHeaderWithBeginRefresh:NO animation:YES refreshBlock:^(NSInteger pageIndex) {
       __strong typeof(weakSelf) strongSelf = weakSelf;

       [strongSelf queryMineSkillList];
   }];
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"奖项与技能" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //放按钮的视图
    UIView *buttonView = [UIView new];
    [self.view addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 218)/2);
        make.size.mas_equalTo(CGSizeMake(218, 36));
    }];
    buttonView.layer.backgroundColor = [UIColor colorWithRed:226/255.0 green:246/255.0 blue:255/255.0 alpha:1.0].CGColor;
    buttonView.layer.cornerRadius = 18;
    
    //奖项
    _rewordBtn = [UIButton new];
    [buttonView addSubview:_rewordBtn];
    [_rewordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView).offset(3);
        make.left.equalTo(buttonView).offset(3);
        make.size.mas_equalTo(CGSizeMake(106, 30));
    }];
    _rewordBtn.layer.cornerRadius = 15;
    [_rewordBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [_rewordBtn setTitle:@"所获奖项" forState:UIControlStateNormal];
    [_rewordBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.view layoutIfNeeded];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = _rewordBtn.bounds;
    gl.startPoint = CGPointMake(0.92, 0.13);
    gl.endPoint = CGPointMake(0, 0.96);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 15;
    //添加的渐变背景一定要设置在底层，否则会覆盖文字
    [_rewordBtn.layer insertSublayer:gl atIndex:0];
    
    _rewordBtn.selected = YES;
    _rewordBtn.tag = K_RewordBtn_Tag;
    [_rewordBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];


    //所获技能
    _skillBtn = [UIButton new];
    [buttonView addSubview:_skillBtn];
    [_skillBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView).offset(3);
        make.left.equalTo(_rewordBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(106, 30));
    }];
    _skillBtn.layer.cornerRadius = 15;
    [_skillBtn setBackgroundColor:[UIColor clearColor]];
    [_skillBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [_skillBtn setTitle:@"所获技能" forState:UIControlStateNormal];
    [_skillBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _skillBtn.selected = NO;
    _skillBtn.tag = K_SkillBtn_Tag;
    [_skillBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //奖项列表
    _rewordTableView = [UITableView new];
    [self.view addSubview:_rewordTableView];
    [_rewordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.mas_bottom).offset(15);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _rewordTableView.tag = K_RewordTableView_Tag;
    [_rewordTableView setBackgroundColor:[UIColor clearColor]];
    _rewordTableView.bounces = YES;
    _rewordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_rewordTableView registerClass:[MineRewordTableViewCell class] forCellReuseIdentifier:@"MineRewordTableViewCell"];
    _rewordTableView.delegate = self;
    _rewordTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _rewordTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _rewordTableView.showsVerticalScrollIndicator = NO;
    _rewordTableView.hidden = NO;
    
    
    //技能列表
    _skillTableView = [UITableView new];
    [self.view addSubview:_skillTableView];
    [_skillTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.mas_bottom).offset(15);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _skillTableView.tag = K_SkillTableView_Tag;
    [_skillTableView setBackgroundColor:[UIColor clearColor]];
    _skillTableView.bounces = YES;
    _skillTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_skillTableView registerClass:[MineSkillTableViewCell class] forCellReuseIdentifier:@"MineSkillTableViewCell"];
    _skillTableView.delegate = self;
    _skillTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _skillTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _skillTableView.showsVerticalScrollIndicator = NO;
    _skillTableView.hidden = YES;
    
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
    CAGradientLayer *addButtonGl = [CAGradientLayer layer];
    addButtonGl.frame = addButton.bounds;
    addButtonGl.startPoint = CGPointMake(0.92, 0.13);
    addButtonGl.endPoint = CGPointMake(0, 0.96);
    addButtonGl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
    addButtonGl.locations = @[@(0), @(1.0f)];
    addButtonGl.cornerRadius = 23;
    [addButton.layer addSublayer:addButtonGl];
    
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
    return 96;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag == K_RewordTableView_Tag){
        return self.rewordArray.count;
        
    }else if(tableView.tag == K_SkillTableView_Tag){
        return self.skillArray.count;
    }
    
    return 0;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == K_RewordTableView_Tag){
        MineRewordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineRewordTableViewCell"];
        
        //更新cell，注意这里是根据section下标取值的
        [cell updateCellWithModel:self.rewordArray[indexPath.section]];

        return cell;
        
    }else if(tableView.tag == K_SkillTableView_Tag){
        MineSkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSkillTableViewCell"];
        
        //更新cell，注意这里是根据section下标取值的
        [cell updateCellWithModel:self.skillArray[indexPath.section]];

        return cell;
    }
    
    return nil;
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView.tag == K_RewordTableView_Tag){
        MineRewordModel *slctModel = self.rewordArray[indexPath.section];

        NSDictionary *sendDic = @{
            @"slctModel":slctModel
        };

        MineRewordDetailViewController *detailVC = [MineRewordDetailViewController new];
        detailVC.dataDic = sendDic;

        //设置block回调
        __weak typeof(self) weakSelf = self;
        [detailVC setSendValueBlock:^(NSDictionary *valueDict){
            __strong typeof(weakSelf) strongSelf = weakSelf;

            [strongSelf queryMineRewordList];
        }];

        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if(tableView.tag == K_SkillTableView_Tag){
        MineSkillModel *slctModel = self.skillArray[indexPath.section];

        NSDictionary *sendDic = @{
            @"slctModel":slctModel
        };

        MineSkillDetailViewController *detailVC = [MineSkillDetailViewController new];
        detailVC.dataDic = sendDic;

        //设置block回调
        __weak typeof(self) weakSelf = self;
        [detailVC setSendValueBlock:^(NSDictionary *valueDict){
            __strong typeof(weakSelf) strongSelf = weakSelf;

            [strongSelf queryMineSkillList];
        }];

        [self.navigationController pushViewController:detailVC animated:YES];
        
    }
    
}
//**********    tableView代理 end   **********//
      
#pragma mark - 按钮点击事件 -
-(void)btnTouch:(UIButton*)sender
{
    if(sender.tag == K_RewordBtn_Tag){
        //奖项按钮点击
        if(sender.selected == NO){
            
            //显示奖项列表，隐藏技能列表
            self.rewordTableView.hidden = NO;
            self.skillTableView.hidden = YES;
            
            //未选中，那么就要选中
            _rewordBtn.selected = YES;
            [_rewordBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            [self.view layoutIfNeeded];
            
            // gradient
            CAGradientLayer *gl = [CAGradientLayer layer];
            gl.frame = _rewordBtn.bounds;
            gl.startPoint = CGPointMake(0.92, 0.13);
            gl.endPoint = CGPointMake(0, 0.96);
            gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
            gl.locations = @[@(0), @(1.0f)];
            gl.cornerRadius = 15;
            //添加的渐变背景一定要设置在底层，否则会覆盖文字
            [_rewordBtn.layer insertSublayer:gl atIndex:0];
            
            //技能按钮设为未选中
            _skillBtn.selected = NO;
            [_skillBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
            //移除所有添加的渐变背景
            NSArray *layerArr = _skillBtn.layer.sublayers;
            for(int i = 0; i < layerArr.count; i++){
                [layerArr[i] removeFromSuperlayer];
            }
            [_skillBtn setBackgroundColor:[UIColor clearColor]];
            
            [self queryMineRewordList];
            [self addPullRefreshRewordList];
        }else{
            return;
        }
        
    }else if(sender.tag == K_SkillBtn_Tag){
        //国内预科点击
        if(sender.selected == NO){
            
            //隐藏奖项列表，显示技能列表
            self.skillTableView.hidden = NO;
            self.rewordTableView.hidden = YES;
            
            //未选中，那么就要选中
            _skillBtn.selected = YES;
            [_skillBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            [self.view layoutIfNeeded];
            
            // gradient
            CAGradientLayer *gl = [CAGradientLayer layer];
            gl.frame = _skillBtn.bounds;
            gl.startPoint = CGPointMake(0.92, 0.13);
            gl.endPoint = CGPointMake(0, 0.96);
            gl.colors = @[(__bridge id)[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:154/255.0 blue:255/255.0 alpha:1.0].CGColor];
            gl.locations = @[@(0), @(1.0f)];
            gl.cornerRadius = 15;
            //添加的渐变背景一定要设置在底层，否则会覆盖文字
            [_skillBtn.layer insertSublayer:gl atIndex:0];
            
            //奖项按钮设为未选中
            _rewordBtn.selected = NO;
            [_rewordBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
            //移除所有添加的渐变背景
            NSArray *layerArr = _rewordBtn.layer.sublayers;
            for(int i = 0; i < layerArr.count; i++){
                [layerArr[i] removeFromSuperlayer];
            }
            [_rewordBtn setBackgroundColor:[UIColor clearColor]];
            
            [self queryMineSkillList];
            [self addPullRefreshSkillList];
        }else{
            return;
        }
    }
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加按钮 -
-(void)addButtonClick
{
    MineAddRewordAndSkillViewController *showVC = [MineAddRewordAndSkillViewController new];
    
    NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
    if (!self.rewordTableView.hidden) {
         [sendDic setValue:@"awardAdd" forKey:@"addType"];
     } else if (!self.skillTableView.hidden) {
         [sendDic setValue:@"skillAdd" forKey:@"addType"];
     }
    showVC.dataDic = [sendDic copy];
    [self.navigationController pushViewController:showVC animated:YES];

   //设置block回调
    __weak typeof(self) weakSelf = self;
   [showVC setSendValueBlock:^(NSDictionary *valueDict){
       __strong typeof(weakSelf) strongSelf = weakSelf;
       
       if ([valueDict[@"addType"] isEqualToString:@"awardAdd"]) {
           [strongSelf queryMineRewordList];
       } else if ([valueDict[@"addType"] isEqualToString:@"skillAdd"]) {
           [strongSelf queryMineSkillList];
       }
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
        for(MineRewordModel *model in self.rewordArray){
            model.showLanguage = @"EN";
        }
        [self.rewordTableView reloadData];
        
        for(MineSkillModel *model in self.skillArray){
            model.showLanguage = @"EN";
        }
        [self.skillTableView reloadData];
        
    }else{
        //切换成中文
        isShowChinese = YES;
        
        NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"EN" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
        [rightButton setAttributedTitle:rightButtonString forState:UIControlStateNormal];
        
        //更新数据源
        for(MineRewordModel *model in self.rewordArray){
            model.showLanguage = @"ZH";
        }
        [self.rewordTableView reloadData];
        
        for(MineSkillModel *model in self.skillArray){
            model.showLanguage = @"ZH";
        }
        [self.skillTableView reloadData];
        
    }
}


#pragma mark - 网络请求
- (void)queryMineRewordList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EDU_AWARD method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        NSArray *rspDataArray = rspData[@"dataList"];
                       [strongSelf.rewordArray removeAllObjects];
                       for(int i=0; i<rspDataArray.count; i++){
                           MineRewordModel *model = [MineRewordModel modelWithDict:rspDataArray[i]];
                           [strongSelf.rewordArray addObject:model];
                       }
                        
                        [strongSelf.rewordTableView reloadData];
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


- (void)queryMineSkillList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_EDU_SKILL method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        NSArray *rspDataArray = rspData[@"dataList"];
                       [strongSelf.skillArray removeAllObjects];
                       for(int i=0; i<rspDataArray.count; i++){
                           MineSkillModel *model = [MineSkillModel modelWithDict:rspDataArray[i]];
                           [strongSelf.skillArray addObject:model];
                       }
                        
                        [strongSelf.skillTableView reloadData];
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
