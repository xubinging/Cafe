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
@property (nonatomic,strong) NSArray *resultArray;
@property (nonatomic,copy) NSIndexPath *editingIndexPath;   //当前左滑cell的index，在代理方法中设置

@end

@implementation MineResultViewController

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
    _resultArray = nil;
    NSMutableArray *tempArray = [NSMutableArray array];

    for(int i=0; i<20; i++){

        NSString *showLanguage = @"ZH";
        NSInteger index = i+1;
        
        NSDictionary *dic = @{
            @"resultIndex":@(index),
            @"resultType":@"TOEFL",
            @"resultDate":@"2019/10/20",
            @"resultLocation":@"南京",
            @"resultOrg":@"**机构",
            @"resultL":@"10",
            @"resultS":@"20",
            @"resultR":@"30",
            @"resultW":@"40",
            @"resultScore":[NSString stringWithFormat:@"%d",345 + i],
            @"showLanguage":showLanguage
        };
        
        MineResultModel *model = [MineResultModel modelWithDict:dic];
        [tempArray addObject:model];

    }

    _resultArray = [tempArray copy];
    
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
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
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

    //更新cell，注意这里是根据section下标取值的
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
    
    NSString *type = slctModel.resultType;
    NSString *date = slctModel.resultDate;
    NSString *location = slctModel.resultLocation;
    NSString *org = slctModel.resultOrg;
    NSString *resultL = slctModel.resultL;
    NSString *resultS = slctModel.resultS;
    NSString *resultR = slctModel.resultR;
    NSString *resultW = slctModel.resultW;
    NSString *resultScore = slctModel.resultScore;
    
    NSDictionary *sendDic = @{
        @"type":type,
        @"date":date,
        @"location":location,
        @"org":org,
        @"resultL":resultL,
        @"resultS":resultS,
        @"resultR":resultR,
        @"resultW":resultW,
        @"resultScore":resultScore
    };
    
    MineResultDetailViewController *detailVC = [MineResultDetailViewController new];

    //设置block回调
    [detailVC setSendValueBlock:^(NSDictionary *valueDict){
        //回调函数
        NSString *type = valueDict[@"type"];
        NSString *date = valueDict[@"date"];
        NSString *location = valueDict[@"location"];
        NSString *org = valueDict[@"org"];
        NSString *resultL = valueDict[@"resultL"];
        NSString *resultS = valueDict[@"resultS"];
        NSString *resultR = valueDict[@"resultR"];
        NSString *resultW = valueDict[@"resultW"];
        NSString *resultScore = valueDict[@"resultScore"];

        slctModel.resultType = type;
        slctModel.resultDate = date;
        slctModel.resultLocation = location;
        slctModel.resultOrg = org;
        slctModel.resultL = resultL;
        slctModel.resultS = resultS;
        slctModel.resultR = resultR;
        slctModel.resultW = resultW;
        slctModel.resultScore = resultScore;
        

        [self.resultTableView reloadData];

    }];

    detailVC.dataDic = sendDic;

    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark - 设置Cell可编辑 -
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - 添加左滑按钮点击事件 -
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        //注意这里通过section来获取
        MineResultModel *model = self->_resultArray[indexPath.section];

        NSInteger resultIndex = model.resultIndex;
        
        AvalonsoftMsgAlertView *alertView = [AvalonsoftMsgAlertView showWithTitle:@"确定删除本次记录?" content:@"" buttonTitles:@[@"否",@"是"] buttonClickedBlock:^(NSInteger buttonIndex){
            
            if(buttonIndex == 1){
                NSMutableArray *tempArr = [NSMutableArray array];
                
                for(MineResultModel *model in self.resultArray){
                    if(model.resultIndex != resultIndex){
                        [tempArr addObject:model];
                    }
                }
                
                self.resultArray = [tempArr copy];
                
                [self.resultTableView reloadData];
                
                [AvalonsoftToast showWithMessage:@"记录已删除"];
                
                self.editingIndexPath = nil;
            }
            
        }];
        
        [alertView setMainButtonIndex:1];
        
    }];
    
    deleteRowAction.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction];
}

#pragma mark - 开始编辑时 -
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = indexPath;
    
    // 触发viewDidLayoutSubviews
    [self.view setNeedsLayout];
}

#pragma mark - 结束编辑时 -
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = nil;
}

//**********    tableView代理 end   **********//

#pragma mark - 强制刷新view，执行条件：[self.view setNeedsLayout]; -
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.editingIndexPath){
        [self configSwipeButtons];
    }
}

#pragma mark - 配置按钮 -
- (void)configSwipeButtons
{
    // 获取选项按钮的reference
//    if(IOS_VERSION.doubleValue < 11){
//        // iOS 8-10层级:UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
//        MineResultTableViewCell *tableCell = [self.resultTableView cellForRowAtIndexPath:self.editingIndexPath];
//        for (UIView *subview in tableCell.subviews){
//            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]){
//                //添加一个自定义的视图
//                UIView *backView = [UIView new];
//                [subview.subviews[0] addSubview:backView];
//                [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(subview.subviews[0]);
//                    make.left.equalTo(subview.subviews[0]);
//                    make.size.mas_equalTo(CGSizeMake(65, subview.subviews[0].frame.size.height));
//                }];
//                [backView setBackgroundColor:RGBA_GGCOLOR(255, 80, 63, 1)];
//                backView.layer.cornerRadius = 8;
//
//                UIImageView *imgView = [UIImageView new];
//                [backView addSubview:imgView];
//                [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(backView).offset((subview.subviews[0].frame.size.height - 23)/2);
//                    make.left.equalTo(backView).offset((65 - 22)/2);
//                    make.size.mas_equalTo(CGSizeMake(22, 23));
//                }];
//                [imgView setImage:[UIImage imageNamed:@"mine_delete_cell"]];
//            }
//        }
//
//    }else
    
    //最低适配 iOS11
    if(IOS_VERSION.doubleValue>=11 && IOS_VERSION.doubleValue<13){
        // iOS 11~12层级:UITableView -> UISwipeActionPullView
        for (UIView *subview in self.resultTableView.subviews){
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]){
                if ([NSStringFromClass([subview.subviews[0] class]) isEqualToString:@"UISwipeActionStandardButton"]) {
                    //添加一个自定义的视图
                    UIView *backView = [UIView new];
                    [subview.subviews[0] addSubview:backView];
                    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(subview.subviews[0]);
                        make.left.equalTo(subview.subviews[0]);
                        make.size.mas_equalTo(CGSizeMake(65, subview.subviews[0].frame.size.height));
                    }];
                    [backView setBackgroundColor:RGBA_GGCOLOR(255, 80, 63, 1)];
                    backView.layer.cornerRadius = 8;
                    
                    UIImageView *imgView = [UIImageView new];
                    [backView addSubview:imgView];
                    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(backView).offset((subview.subviews[0].frame.size.height - 23)/2);
                        make.left.equalTo(backView).offset((65 - 22)/2);
                        make.size.mas_equalTo(CGSizeMake(22, 23));
                    }];
                    [imgView setImage:[UIImage imageNamed:@"mine_delete_cell"]];
                }
            }
        }
        
    }else if(IOS_VERSION.doubleValue >= 13){
        // iOS13
        for (UIView *subview in self.resultTableView.subviews){
            if([subview isKindOfClass:NSClassFromString(@"_UITableViewCellSwipeContainerView")]) {
                for (UIView *subViews in subview.subviews) {
                    if([subViews isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                        if ([NSStringFromClass([subViews.subviews[0] class]) isEqualToString:@"UISwipeActionStandardButton"]) {
                            //添加一个自定义的视图
                            UIView *backView = [UIView new];
                            [subViews.subviews[0] addSubview:backView];
                            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.top.equalTo(subViews.subviews[0]);
                                make.left.equalTo(subViews.subviews[0]);
                                make.size.mas_equalTo(CGSizeMake(65, subViews.subviews[0].frame.size.height));
                            }];
                            [backView setBackgroundColor:RGBA_GGCOLOR(255, 80, 63, 1)];
                            backView.layer.cornerRadius = 8;
                            
                            UIImageView *imgView = [UIImageView new];
                            [backView addSubview:imgView];
                            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.top.equalTo(backView).offset((subViews.subviews[0].frame.size.height - 23)/2);
                                make.left.equalTo(backView).offset((65 - 22)/2);
                                make.size.mas_equalTo(CGSizeMake(22, 23));
                            }];
                            [imgView setImage:[UIImage imageNamed:@"mine_delete_cell"]];
                        }
                    }
                }
            }
        }
    }
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

    //设置block回调
    [showVC setSendValueBlock:^(NSDictionary *valueDict){
        //回调函数
        NSString *type = valueDict[@"type"];
        NSString *date = valueDict[@"date"];
        NSString *location = valueDict[@"location"];
        NSString *org = valueDict[@"org"];
        NSString *resultL = valueDict[@"resultL"];
        NSString *resultS = valueDict[@"resultS"];
        NSString *resultR = valueDict[@"resultR"];
        NSString *resultW = valueDict[@"resultW"];
        NSString *resultScore = valueDict[@"resultScore"];
        NSString *showLanguage = @"";
        
        if(self->isShowChinese){
            showLanguage = @"ZH";
        }else{
            showLanguage = @"EN";
        }
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for(MineResultModel *model in self.resultArray){
            [tempArr addObject:model];
        }
        
        //把刚才新加的数据加入到数据列表中
        NSDictionary *dic = @{
            @"resultIndex":@(tempArr.count + 1),
            @"resultType":type,
            @"resultDate":date,
            @"resultLocation":location,
            @"resultOrg":org,
            @"resultL":resultL,
            @"resultS":resultS,
            @"resultR":resultR,
            @"resultW":resultW,
            @"resultScore":resultScore,
            @"showLanguage":showLanguage
        };
        
        MineResultModel *model = [MineResultModel modelWithDict:dic];
        [tempArr addObject:model];
        
        //按照 resultIndex 进行降序排序，这里用的是描述类排序，排序字段一定要和类中写的一致
        NSSortDescriptor *resultIndexSortDesc = [[NSSortDescriptor alloc] initWithKey:@"resultIndex" ascending:NO];
        [tempArr sortUsingDescriptors:@[resultIndexSortDesc]];
        
        self.resultArray = [tempArr copy];
        
        [self.resultTableView reloadData];
        
    }];
    
    showVC.dataDic = @{};
    
    [self.navigationController pushViewController:showVC animated:YES];
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

@end
