//
//  MyCollectionPostVC.m
//  Cafe
//
//  Created by leo on 2020/1/5.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MyCollectionPostVC.h"

#import "PostModel.h"
#import "PostTableViewCell.h"

@interface MyCollectionPostVC ()<UITableViewDelegate,UITableViewDataSource>

//文章
@property (nonatomic,strong) UITableView *articleTableView;
@property (nonatomic,strong) NSArray *articleArray;
@property (nonatomic,copy) NSIndexPath *editingIndexPath;   //当前左滑cell的index，在代理方法中设置

@end

@implementation MyCollectionPostVC

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
    _articleArray = nil;
    NSMutableArray *tempArray = [NSMutableArray array];

    UIImage *image = [UIImage imageNamed:@"home_foreign_school_icon"];
    for(int i = 0; i < 20; i++){
        NSInteger index = i+1;
        NSDictionary *dic = @{
            @"postIndex":@(index),
            @"title":[NSString stringWithFormat:@"%@+%ld",@"那些年我们一起追过的动漫",(long)index],
            @"image":image,
            @"name":@"花太香",
            @"school":@"清华大学",
            @"time":@"12分钟前",
            @"content":@"给大家做一个初级会计专属锦鲤,在出分前在转一遍💪💪💪一定要过啊!!!"
        };
        PostModel *model = [PostModel modelWithDict:dic];
        [tempArray addObject:model];
    }
    
    _articleArray = [tempArray copy];
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
    //文章列表
    _articleTableView = [[UITableView alloc] init];
    [self.view addSubview:_articleTableView];
    [_articleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
    [_articleTableView setBackgroundColor:[UIColor clearColor]];
    _articleTableView.bounces = YES;
    _articleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_articleTableView registerClass:[PostTableViewCell class] forCellReuseIdentifier:@"PostTableViewCell"];
    _articleTableView.delegate = self;
    _articleTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _articleTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _articleTableView.showsVerticalScrollIndicator = NO;
    _articleTableView.estimatedRowHeight = 0;
    _articleTableView.estimatedSectionHeaderHeight = 0;
    _articleTableView.estimatedSectionFooterHeight = 0;

}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.articleArray.count;
}

#pragma mark - 设置行数 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 初始化cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //搜索历史
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell"];
    
    //更新cell
    [cell updateCellWithModel:self.articleArray[indexPath.section]];

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

#pragma mark - 点击列表中的行 -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        PostModel *model = self->_articleArray[indexPath.section];

        NSInteger postIndex = model.postIndex;
        
        AvalonsoftMsgAlertView *alertView = [AvalonsoftMsgAlertView showWithTitle:@"确定删除帖子?" content:@"" buttonTitles:@[@"否",@"是"] buttonClickedBlock:^(NSInteger buttonIndex){
            
            if(buttonIndex == 1){
                NSMutableArray *tempArr = [NSMutableArray array];
                
                for(PostModel *model in self.articleArray){
                    if(model.postIndex != postIndex){
                        [tempArr addObject:model];
                    }
                }
                
                self.articleArray = [tempArr copy];
                
                [self.articleTableView reloadData];
                
                [AvalonsoftToast showWithMessage:@"帖子已删除"];
                
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
        for (UIView *subview in self.articleTableView.subviews){
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
        for (UIView *subview in self.articleTableView.subviews){
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

@end
