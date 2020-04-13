//
//  MyLikeCooperateSchoolVC.m
//  Cafe
//
//  Created by gexy on 2020/3/22.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MyLikeCooperateSchoolVC.h"
#import "MyLikeCooperateSchoolModel.h"
#import "MyLikeCooperateSchoolViewCell.h"

@interface MyLikeCooperateSchoolVC ()<UITableViewDelegate,UITableViewDataSource> {
    @private NSDictionary *myLikeSchoolData;
}

@property (nonatomic,strong) UITableView *schoolTableView;
@property (nonatomic,strong) NSArray *schoolArray;

@end

@implementation MyLikeCooperateSchoolVC

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
    
    _schoolArray = nil;
    if (myLikeSchoolData != NULL) {
        NSMutableArray *tempschoolArray = [NSMutableArray array];
        NSArray *dataArray = [myLikeSchoolData objectForKey:@"dataList"];
        
        for(int i=0; i<dataArray.count;i++){
            MyLikeCooperateSchoolModel *model = [MyLikeCooperateSchoolModel modelWithDict:dataArray[i]];
            model.schoolIndex = i+1;
            [tempschoolArray addObject:model];
        }
        _schoolArray = [tempschoolArray copy];
    }
    
}

#pragma mark - 初始化数据 -
-(void)initSharedPreferences
{
    @try {
        [self getMyLikeCooperateSchool:0 pageSize:10 insType:4];
        
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
    [_schoolTableView registerClass:[MyLikeCooperateSchoolViewCell class] forCellReuseIdentifier:@"MyLikeCooperateSchoolViewCell"];
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
    return 70;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.schoolArray.count;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyLikeCooperateSchoolViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyLikeCooperateSchoolViewCell"];
    
    //更新cell，注意这里是根据section下标取值的
    [cell updateCellWithModel:self.schoolArray[indexPath.section]];
    
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
    MyLikeCooperateSchoolViewCell *cell = (MyLikeCooperateSchoolViewCell *)[[[button superview] superview] superview];
    NSIndexPath *indexPath = [_schoolTableView indexPathForCell:cell];
    //注意这里通过section来获取
    MyLikeCooperateSchoolModel *model = _schoolArray[indexPath.section];
    
    NSInteger schoolIndex = model.schoolIndex;
    
    //已关注按钮点击
    AvalonsoftMsgAlertView *alertView = [AvalonsoftMsgAlertView showWithTitle:@"确定不再关注TA吗?" content:@"" buttonTitles:@[@"否",@"是"] buttonClickedBlock:^(NSInteger buttonIndex){
        
        if(buttonIndex == 1){
            NSMutableArray *tempTrainArr = [NSMutableArray array];
            for(int i = 0;i < self.schoolArray.count; i++){
                MyLikeCooperateSchoolModel *model = self.schoolArray[i];
                
                if(model.schoolIndex != schoolIndex){
                    [tempTrainArr addObject:self.schoolArray[i]];
                }
            }
            
            self.schoolArray = [tempTrainArr copy];
            
            [self.schoolTableView reloadData];
            
            [AvalonsoftToast showWithMessage:@"已取消关注"];
        }
        
    }];
    
    [alertView setMainButtonIndex:1];
}

#pragma mark - 所有网络请求处理都在这里进行 -
-(void)getMyLikeCooperateSchool:(int) pageNum pageSize:(int) pageSize insType:(int) insType
{
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            [root setValue:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
            [root setValue:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
            [root setValue:[NSNumber numberWithInt:insType] forKey:@"insType"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_GET_MY_LIKE_HZBX_LIST method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_GET_MY_LIKE_HZBX_LIST];
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
        if([eventType isEqualToString:MINE_GET_MY_LIKE_HZBX_LIST]){
            if(responseModel.rescode == 200){
                myLikeSchoolData = responseModel.data;
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
