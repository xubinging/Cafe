//
//  MineVenuePostVC.m
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineVenuePostVC.h"

#import "MineVenuePostModel.h"
#import "MineVenuePostTableViewCell.h"

static NSInteger pageNum = 0;

@interface MineVenuePostVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *commentTableView;
@property (nonatomic,strong) NSMutableArray *commentArray;

@end

@implementation MineVenuePostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initView];
}

- (NSMutableArray *)commentArray
{
    return _commentArray?:(_commentArray = [NSMutableArray array]);
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1.0);
    
//    //造数据
//    _commentArray = nil;
//    NSMutableArray *tempArray = [NSMutableArray array];
//
//    for(int i=0; i<10;i++){
//
//        NSInteger index = i+1;
//
//        NSDictionary *dic = @{
//            @"index":@(index),
//            @"title":@"标题标题标题标题标题标题",
//            @"content":@"进入电脑后突然出现黑屏, 是什么原因?是电脑额问题吗?我需要找人修电脑吗?",
//            @"likeNum":@"123",
//            @"commentNum":@"765",
//            @"seeNum":@"123",
//            @"time":@"10月6日 13:38"
//        };
//        MineVenuePostModel *model = [MineVenuePostModel modelWithDict:dic];
//        [tempArray addObject:model];
//    }
//
//    _commentArray = [tempArray copy];
    
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
    _commentTableView = [UITableView new];
    [self.view addSubview:_commentTableView];
    [_commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [_commentTableView setBackgroundColor:[UIColor clearColor]];
    _commentTableView.bounces = YES;
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_commentTableView registerClass:[MineVenuePostTableViewCell class] forCellReuseIdentifier:@"MineVenuePostTableViewCell"];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _commentTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _commentTableView.showsVerticalScrollIndicator = NO;
    
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArray.count;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineVenuePostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineVenuePostTableViewCell"];
    
    //更新cell
    [cell updateCellWithModel:self.commentArray[indexPath.row]];

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
    [AvalonsoftToast showWithMessage:@"阅读全文"];
}
//**********    tableView代理 end   **********//


#pragma mark - 网络请求
- (void)getMyPostList
{
    __weak typeof(self) weakSelf = self;
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountid"];
            [root setValue:[NSString stringWithFormat:@"%ld",(long)pageNum++] forKey:@"pageNum"];
            [root setValue:@"10" forKey:@"pageSize"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_POST_LIST method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
                _M *responseModel = [_M createResponseJsonObj:responseObject];
                NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
                
                @try {
                    if(responseModel.rescode == 200){
                        NSDictionary *data = responseModel.data;
                        int count = [[NSString stringWithFormat:@"%@", data[@"count"]] intValue];

//                        [userMessageNum setText:[NSString stringWithFormat:@"%d",count]];
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
- (void)loadMorePostList
{
    __weak typeof(self) weakSelf = self;
    [self.commentTableView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        [strongSelf getMyPostList];
    }];
}

- (void)dealloc
{
    pageNum = 0;
}

@end
