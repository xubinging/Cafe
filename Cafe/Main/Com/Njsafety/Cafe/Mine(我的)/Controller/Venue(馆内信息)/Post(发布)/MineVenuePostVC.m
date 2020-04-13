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

@interface MineVenuePostVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *commentTableView;
@property (nonatomic,strong) NSArray *commentArray;

@end

@implementation MineVenuePostVC

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
    _commentArray = nil;
    NSMutableArray *tempArray = [NSMutableArray array];

    for(int i=0; i<10;i++){
        
        NSInteger index = i+1;
        
        NSDictionary *dic = @{
            @"index":@(index),
            @"title":@"标题标题标题标题标题标题",
            @"content":@"进入电脑后突然出现黑屏, 是什么原因?是电脑额问题吗?我需要找人修电脑吗?",
            @"likeNum":@"123",
            @"commentNum":@"765",
            @"seeNum":@"123",
            @"time":@"10月6日 13:38"
        };
        MineVenuePostModel *model = [MineVenuePostModel modelWithDict:dic];
        [tempArray addObject:model];
    }
    
    _commentArray = [tempArray copy];
    
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

@end
