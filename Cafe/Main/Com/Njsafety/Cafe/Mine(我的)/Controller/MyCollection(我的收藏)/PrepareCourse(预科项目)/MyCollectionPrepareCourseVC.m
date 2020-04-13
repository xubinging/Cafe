//
//  MyCollectionPrepareCourseVC.m
//  Cafe
//
//  Created by leo on 2020/1/5.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MyCollectionPrepareCourseVC.h"

#import "PrepareCourseAbroadModel.h"            //国外预科
#import "PrepareCourseAbroadTableViewCell.h"

#import "PrepareCourseHomeModel.h"              //国内预科
#import "PrepareCourseHomeTableViewCell.h"

#define K_AbroadBtn_Tag         10
#define K_HomeBtn_Tag           20
#define K_AbroadTableView_Tag   100
#define K_HomeTableView_Tag     200

@interface MyCollectionPrepareCourseVC ()<UITableViewDelegate,UITableViewDataSource>

//国外预科
@property (nonatomic,strong) UIButton *abroadBtn;
@property (nonatomic,strong) UITableView *abroadTableView;
@property (nonatomic,strong) NSArray *abroadArray;

//国外预科
@property (nonatomic,strong) UIButton *homeBtn;
@property (nonatomic,strong) UITableView *homeTableView;
@property (nonatomic,strong) NSArray *homeArray;

@end

@implementation MyCollectionPrepareCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initView];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1.0);
    
    //造数据
    _abroadArray = nil;
    NSMutableArray *tempAbroadArray = [NSMutableArray array];

    for(int i=0; i<20;i++){
        NSDictionary *dic = @{
            @"icon":@"home_foreign_school_icon",
            @"title":@"国外预科机构名称",
            @"time":@"12分钟前",
            @"content":@"国外预科项目名称国外预科项目名称国外预科项目名称国外预科项目名称"
        };
        PrepareCourseAbroadModel *model = [PrepareCourseAbroadModel modelWithDict:dic];
        [tempAbroadArray addObject:model];
    }

    _abroadArray = [tempAbroadArray copy];
    
    _homeArray = nil;
    NSMutableArray *tempHomeArray = [NSMutableArray array];

    for(int i=0; i<20;i++){
        NSDictionary *dic = @{
            @"icon":@"home_foreign_school_icon",
            @"title":@"国内预科机构名称",
            @"time":@"12分钟前",
            @"content":@"国内预科项目名称国内预科项目名称国内预科项目名称国内预科项目名称"
        };
        PrepareCourseHomeModel *model = [PrepareCourseHomeModel modelWithDict:dic];
        [tempHomeArray addObject:model];
    }

    _homeArray = [tempHomeArray copy];
}

#pragma mark - 初始化数据 -
-(void)initSharedPreferences
{
    @try {
        
    } @catch (NSException *exception) {
        @throw exception;
        
    }
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //国外预科
    _abroadBtn = [UIButton new];
    [self.view addSubview:_abroadBtn];
    [_abroadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(5);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH - 180)/2);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    _abroadBtn.layer.cornerRadius = 15;
    _abroadBtn.layer.shadowColor = [UIColor colorWithRed:251/255.0 green:145/255.0 blue:53/255.0 alpha:0.2].CGColor;
    _abroadBtn.layer.shadowOffset = CGSizeMake(0,4);
    _abroadBtn.layer.shadowOpacity = 1;
    _abroadBtn.layer.shadowRadius = 10;
    
    [_abroadBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [_abroadBtn setTitle:@"国外预科" forState:UIControlStateNormal];
    [_abroadBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.view layoutIfNeeded];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = _abroadBtn.bounds;
    gl.startPoint = CGPointMake(1, -0.34);
    gl.endPoint = CGPointMake(0, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:154/255.0 blue:66/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 15;
    //添加的渐变背景一定要设置在底层，否则会覆盖文字
    [_abroadBtn.layer insertSublayer:gl atIndex:0];
    
    _abroadBtn.selected = YES;
    _abroadBtn.tag = K_AbroadBtn_Tag;
    [_abroadBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];


    //国内预科
    _homeBtn = [UIButton new];
    [self.view addSubview:_homeBtn];
    [_homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(5);
        make.left.equalTo(_abroadBtn.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    _homeBtn.layer.cornerRadius = 15;
    _homeBtn.layer.shadowColor = [UIColor colorWithRed:251/255.0 green:145/255.0 blue:53/255.0 alpha:0.2].CGColor;
    _homeBtn.layer.shadowOffset = CGSizeMake(0,4);
    _homeBtn.layer.shadowOpacity = 1;
    _homeBtn.layer.shadowRadius = 10;
    [_homeBtn setBackgroundColor:[UIColor clearColor]];

    [_homeBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [_homeBtn setTitle:@"国内预科" forState:UIControlStateNormal];
    [_homeBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _homeBtn.selected = NO;
    _homeBtn.tag = K_HomeBtn_Tag;
    [_homeBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //国外预科列表
    _abroadTableView = [UITableView new];
    [self.view addSubview:_abroadTableView];
    [_abroadTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_homeBtn.mas_bottom).offset(5);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _abroadTableView.tag = K_AbroadTableView_Tag;
    [_abroadTableView setBackgroundColor:[UIColor clearColor]];
    _abroadTableView.bounces = YES;
    _abroadTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_abroadTableView registerClass:[PrepareCourseAbroadTableViewCell class] forCellReuseIdentifier:@"PrepareCourseAbroadTableViewCell"];
    _abroadTableView.delegate = self;
    _abroadTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _abroadTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _abroadTableView.showsVerticalScrollIndicator = NO;
    _abroadTableView.hidden = NO;
    
    
    //国内预科列表
    _homeTableView = [UITableView new];
    [self.view addSubview:_homeTableView];
    [_homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_homeBtn.mas_bottom).offset(5);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _homeTableView.tag = K_HomeTableView_Tag;
    [_homeTableView setBackgroundColor:[UIColor clearColor]];
    _homeTableView.bounces = YES;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_homeTableView registerClass:[PrepareCourseHomeTableViewCell class] forCellReuseIdentifier:@"PrepareCourseHomeTableViewCell"];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _homeTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _homeTableView.showsVerticalScrollIndicator = NO;
    _homeTableView.hidden = YES;
    
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag == K_AbroadTableView_Tag){
        return self.abroadArray.count;
        
    }else if(tableView.tag == K_HomeTableView_Tag){
        return self.homeArray.count;
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
    
    if(tableView.tag == K_AbroadTableView_Tag){
        PrepareCourseAbroadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrepareCourseAbroadTableViewCell"];
        
        //更新cell，注意这里是根据section下标取值的
        [cell updateCellWithModel:self.abroadArray[indexPath.section]];

        return cell;
        
    }else if(tableView.tag == K_HomeTableView_Tag){
        PrepareCourseHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrepareCourseHomeTableViewCell"];
        
        //更新cell，注意这里是根据section下标取值的
        [cell updateCellWithModel:self.homeArray[indexPath.section]];

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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
//**********    tableView代理 end   **********//

#pragma mark - 按钮点击事件 -
-(void)btnTouch:(UIButton*)sender
{
    if(sender.tag == K_AbroadBtn_Tag){
        //国外预科点击
        if(sender.selected == NO){
            
            //显示国外预科列表，隐藏国内预科列表
            self.abroadTableView.hidden = NO;
            self.homeTableView.hidden = YES;
            
            //未选中，那么就要选中
            _abroadBtn.selected = YES;
            [_abroadBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            [self.view layoutIfNeeded];
            
            // gradient
            CAGradientLayer *gl = [CAGradientLayer layer];
            gl.frame = _abroadBtn.bounds;
            gl.startPoint = CGPointMake(1, -0.34);
            gl.endPoint = CGPointMake(0, 1);
            gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:154/255.0 blue:66/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0].CGColor];
            gl.locations = @[@(0), @(1.0f)];
            gl.cornerRadius = 15;
            //添加的渐变背景一定要设置在底层，否则会覆盖文字
            [_abroadBtn.layer insertSublayer:gl atIndex:0];
            
            //国内预科设为未选中
            _homeBtn.selected = NO;
            [_homeBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
            //移除所有添加的渐变背景
            NSArray *layerArr = _homeBtn.layer.sublayers;
            for(int i = 0; i < layerArr.count; i++){
                [layerArr[i] removeFromSuperlayer];
            }
            [_homeBtn setBackgroundColor:[UIColor clearColor]];
            
        }else{
            return;
        }
        
    }else if(sender.tag == K_HomeBtn_Tag){
        //国内预科点击
        if(sender.selected == NO){
            
            //显示国内预科列表，隐藏国外预科列表
            self.homeTableView.hidden = NO;
            self.abroadTableView.hidden = YES;
            
            //未选中，那么就要选中
            _homeBtn.selected = YES;
            [_homeBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            [self.view layoutIfNeeded];
            
            // gradient
            CAGradientLayer *gl = [CAGradientLayer layer];
            gl.frame = _homeBtn.bounds;
            gl.startPoint = CGPointMake(1, -0.34);
            gl.endPoint = CGPointMake(0, 1);
            gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:154/255.0 blue:66/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0].CGColor];
            gl.locations = @[@(0), @(1.0f)];
            gl.cornerRadius = 15;
            //添加的渐变背景一定要设置在底层，否则会覆盖文字
            [_homeBtn.layer insertSublayer:gl atIndex:0];
            
            //国内预科设为未选中
            _abroadBtn.selected = NO;
            [_abroadBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
            //移除所有添加的渐变背景
            NSArray *layerArr = _abroadBtn.layer.sublayers;
            for(int i = 0; i < layerArr.count; i++){
                [layerArr[i] removeFromSuperlayer];
            }
            [_abroadBtn setBackgroundColor:[UIColor clearColor]];
            
        }else{
            return;
        }
    }
}

@end
