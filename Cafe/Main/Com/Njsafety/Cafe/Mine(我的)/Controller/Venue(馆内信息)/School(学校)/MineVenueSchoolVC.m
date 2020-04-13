//
//  MineVenueSchoolVC.m
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineVenueSchoolVC.h"

#import "MineVenueSchoolModel.h"
#import "MineVenueSchoolTableViewCell.h"

@interface MineVenueSchoolVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *schoolTableView;
@property (nonatomic,strong) NSArray *schoolArray;

@end

@implementation MineVenueSchoolVC

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
    _schoolArray = nil;
    NSMutableArray *tempArray = [NSMutableArray array];

    for(int i=0; i<6;i++){
        
        UIImage *icon = [UIImage imageNamed:@"home_foreign_school_icon"];
        NSInteger index = i+1;
        
        NSDictionary *dic = @{
            @"schoolIndex":@(index),
            @"schoolIcon":icon,
            @"schoolNameCh":[NSString stringWithFormat:@"%@ %ld",@"塔斯马尼亚大学",(long)index],
            @"schoolNameEn":[NSString stringWithFormat:@"%@ %ld",@"university of tasmania",(long)index]
        };
        MineVenueSchoolModel *model = [MineVenueSchoolModel modelWithDict:dic];
        [tempArray addObject:model];
    }
    
    _schoolArray = [tempArray copy];
    
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
    _schoolTableView = [UITableView new];
    [self.view addSubview:_schoolTableView];
    [_schoolTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [_schoolTableView setBackgroundColor:[UIColor clearColor]];
    _schoolTableView.bounces = YES;
    _schoolTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_schoolTableView registerClass:[MineVenueSchoolTableViewCell class] forCellReuseIdentifier:@"MineVenueSchoolTableViewCell"];
    _schoolTableView.delegate = self;
    _schoolTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _schoolTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _schoolTableView.showsVerticalScrollIndicator = NO;
    
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.schoolArray.count;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineVenueSchoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineVenueSchoolTableViewCell"];
    
    //更新cell，注意这里是根据section下标取值的
    [cell updateCellWithModel:self.schoolArray[indexPath.row]];

    //就在这里cell初始化成功后去给Block赋值调用它的setter方法
    cell.buttonAction = ^(UIButton *sender){
         [self cellButtonClick:sender];// 在Block内部去调用一个方法，当然你也可以直接在这里写，只要你不嫌代码臃肿
    };
    
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
    NSLog(@"%@",@"点击了cell");
}
//**********    tableView代理 end   **********//

// 将方法抽出来放在外边看起来不至于让tableView的代理方法太臃肿
- (void)cellButtonClick:(UIButton *)button
{
    //获取按钮所在行的门锁信息
    MineVenueSchoolTableViewCell *cell = (MineVenueSchoolTableViewCell *)[[[button superview] superview] superview];
    NSIndexPath *indexPath = [_schoolTableView indexPathForCell:cell];
    //注意这里通过section来获取
    MineVenueSchoolModel *model = _schoolArray[indexPath.row];

    NSInteger schoolIndex = model.schoolIndex;
    
    //已关注按钮点击
    AvalonsoftMsgAlertView *alertView = [AvalonsoftMsgAlertView showWithTitle:@"确定不再关注TA吗?" content:@"" buttonTitles:@[@"否",@"是"] buttonClickedBlock:^(NSInteger buttonIndex){
        
        if(buttonIndex == 1){
            NSMutableArray *tempCompanyArr = [NSMutableArray array];
            for(int i = 0;i < self.schoolArray.count; i++){
                MineVenueSchoolModel *model = self.schoolArray[i];
                
                if(model.schoolIndex != schoolIndex){
                    [tempCompanyArr addObject:self.schoolArray[i]];
                }
            }
            
            self.schoolArray = [tempCompanyArr copy];
            
            [self.schoolTableView reloadData];
            
            [AvalonsoftToast showWithMessage:@"已取消关注"];
        }
        
    }];
    
    [alertView setMainButtonIndex:1];
}

@end
