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

static NSInteger pageNum = 0;

@interface MineVenueSchoolVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *schoolTableView;
@property (nonatomic,strong) NSMutableArray *schoolArray;

@end

@implementation MineVenueSchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initView];
}

- (NSMutableArray *)schoolArray
{
    return _schoolArray?:(_schoolArray = [NSMutableArray array]);
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1.0);
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


#pragma mark - 网络请求
- (void)getMyAboardSelectList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:[NSString stringWithFormat:@"%ld",(long)pageNum++] forKey:@"pageNum"];
            [root setValue:@"10" forKey:@"pageSize"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_ABOARD_SELECT_LIST method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *rspData = responseModel.data;
                        NSArray *rspDataArray = rspData[@"dataList"];
                        for(int i=0; i<rspDataArray.count; i++){
                            MineVenueSchoolModel *model = [MineVenueSchoolModel modelWithDict:rspDataArray[i]];
                            model.schoolIndex = i;
                            [strongSelf.schoolArray addObject:model];
                        }
                        [strongSelf.schoolTableView reloadData];
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

#pragma mark - 上拉加载更多
- (void)loadMoreAboardSelectList
{
    __weak typeof(self) weakSelf = self;
    [self.schoolTableView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        [strongSelf getMyAboardSelectList];
    }];
}

- (void)dealloc
{
    pageNum = 0;
}


@end
