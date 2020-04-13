//
//  MyLikeStudyAbroadTrainVC.m
//  Cafe
//
//  Created by gexy on 2020/3/16.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MyLikeStudyAbroadTrainVC.h"

#import "MyLikeStudyAbroadTrainModel.h"
#import "MyLikeStudyAbroadTrainTableViewCell.h"

@interface MyLikeStudyAbroadTrainVC ()<UITableViewDelegate,UITableViewDataSource> {
    @private NSDictionary *myLikeTrainData;
}

@property (nonatomic,strong) UITableView *trainTableView;
@property (nonatomic,strong) NSArray *trainArray;

@end

@implementation MyLikeStudyAbroadTrainVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initSharedPreferences];
    //    [self initVars];
    //    [self initView];
}


#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1.0);
    
    //造数据
    _trainArray = nil;
    if (myLikeTrainData != NULL) {
        NSMutableArray *temptrainArray = [NSMutableArray array];
        NSArray *dataArray = [myLikeTrainData objectForKey:@"dataList"];
        
        for(int i=0; i<dataArray.count;i++){
            MyLikeStudyAbroadTrainModel *model = [MyLikeStudyAbroadTrainModel modelWithDict:dataArray[i]];
            model.trainIndex = i+1;
            [temptrainArray addObject:model];
        }
        _trainArray = [temptrainArray copy];
    }
    
}

#pragma mark - 初始化数据 -
-(void)initSharedPreferences
{
    @try {
        [self getMyLikeTrain:0 pageSize:10 insType:3];
        
    } @catch (NSException *exception) {
        @throw exception;
        
    }
}

#pragma mark - 初始化视图 -
-(void)initView
{
    _trainTableView = [UITableView new];
    [self.view addSubview:_trainTableView];
    [_trainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [_trainTableView setBackgroundColor:[UIColor clearColor]];
    _trainTableView.bounces = YES;
    _trainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_trainTableView registerClass:[MyLikeStudyAbroadTrainTableViewCell class] forCellReuseIdentifier:@"MyLikeStudyAbroadTrainTableViewCell"];
    _trainTableView.delegate = self;
    _trainTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _trainTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _trainTableView.showsVerticalScrollIndicator = NO;
    
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.trainArray.count;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyLikeStudyAbroadTrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyLikeStudyAbroadTrainTableViewCell"];
    
    //更新cell，注意这里是根据section下标取值的
    [cell updateCellWithModel:self.trainArray[indexPath.section]];
    
    //就在这里cell初始化成功后去给Block赋值调用它的setter方法
    cell.buttonAction = ^(UIButton *sender){
        [self cellButtonClick:sender];// 在Block内部去调用一个方法，当然你也可以直接在这里写，只要你不嫌代码臃肿
    };
    
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
    NSLog(@"%@",@"点击了cell");
}
//**********    tableView代理 end   **********//

// 将方法抽出来放在外边看起来不至于让tableView的代理方法太臃肿
- (void)cellButtonClick:(UIButton *)button
{
    //获取按钮所在行的门锁信息
    MyLikeStudyAbroadTrainTableViewCell *cell = (MyLikeStudyAbroadTrainTableViewCell *)[[[button superview] superview] superview];
    NSIndexPath *indexPath = [_trainTableView indexPathForCell:cell];
    //注意这里通过section来获取
    MyLikeStudyAbroadTrainModel *model = _trainArray[indexPath.section];
    
    NSInteger trainIndex = model.trainIndex;
    
    //已关注按钮点击
    AvalonsoftMsgAlertView *alertView = [AvalonsoftMsgAlertView showWithTitle:@"确定不再关注TA吗?" content:@"" buttonTitles:@[@"否",@"是"] buttonClickedBlock:^(NSInteger buttonIndex){
        
        if(buttonIndex == 1){
            NSMutableArray *tempTrainArr = [NSMutableArray array];
            for(int i = 0;i < self.trainArray.count; i++){
                MyLikeStudyAbroadTrainModel *model = self.trainArray[i];
                
                if(model.trainIndex != trainIndex){
                    [tempTrainArr addObject:self.trainArray[i]];
                }
            }
            
            self.trainArray = [tempTrainArr copy];
            
            [self.trainTableView reloadData];
            
            [AvalonsoftToast showWithMessage:@"已取消关注"];
        }
        
    }];
    
    [alertView setMainButtonIndex:1];
}

#pragma mark - 所有网络请求处理都在这里进行 -
-(void)getMyLikeTrain:(int) pageNum pageSize:(int) pageSize insType:(int) insType
{
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
            [root setValue:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
            [root setValue:[NSNumber numberWithInt:insType] forKey:@"insType"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_GET_MY_LIKE_INST_LIST method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_GET_MY_LIKE_INST_LIST];
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

-(void)handleNetworkRequestWithResponseObject:(id)responseObject eventType:(NSString *)eventType
{
    NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@",responseObject);
    //使用responseObject对_M进行MVC赋值
    _M *responseModel = [_M createResponseJsonObj:responseObject];
    
    NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
    
    @try {
        if([eventType isEqualToString:MINE_GET_MY_LIKE_INST_LIST]){
            if(responseModel.rescode == 200){
                myLikeTrainData = responseModel.data;
                [self initVars];
                [self initView];
            }else{
                
            }
        }
    } @catch (NSException *exception) {
        @throw exception;
        //给出提示信息
        [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
    }
}

@end
