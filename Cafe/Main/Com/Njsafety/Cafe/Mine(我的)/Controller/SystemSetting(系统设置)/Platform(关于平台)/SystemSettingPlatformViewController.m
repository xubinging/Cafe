//
//  SystemSettingPlatformViewController.m
//  Cafe
//
//  Created by leo on 2020/1/1.
//  Copyright © 2020 leo. All rights reserved.
//
//  关于平台

#import "SystemSettingPlatformViewController.h"

#import "PlatformMenuModel.h"
#import "PlatformMenuXIBCell.h"

@interface SystemSettingPlatformViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    @private UIButton *backButton;          //左上角返回按钮
    @private UILabel *versionLabel;         //版本标签
}

//获取tableview对象
@property (nonatomic, strong) UITableView *platformMenuTableView;
//存放菜单项的数组
@property (nonatomic, strong) NSArray *platformMenuArray;

@end

@implementation SystemSettingPlatformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initVars];
    [self initSharedPreferences];
    [self initView];
    [self setListener];
    [self setAppVersion];
    [self setPlatformMenuArray];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);
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
    //***** 顶部导航视图 *****//
    UIView *navigationView = [UIView new];
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
    
    //标题
    UILabel *titleLabel = [UILabel new];
    [navigationView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-120)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"关于平台"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
    //app图标
    UIImageView *appIconImageView = [UIImageView new];
    [self.view addSubview:appIconImageView];
    [appIconImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(24);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-70)/2);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [appIconImageView setImage:[UIImage imageNamed:@"common_appicon"]];
    
    //app名称
    UILabel *appNameLabel = [UILabel new];
    [self.view addSubview:appNameLabel];
    [appNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(appIconImageView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-100)/2);
        make.size.mas_equalTo(CGSizeMake(100, 24));
    }];
    appNameLabel.numberOfLines = 0;
    appNameLabel.textAlignment = NSTextAlignmentCenter;
    appNameLabel.alpha = 1.0;
    NSMutableAttributedString *appNameLabelString = [[NSMutableAttributedString alloc] initWithString:@"留学咖啡馆"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:46/255.0 blue:80/255.0 alpha:1.0]}];
    appNameLabel.attributedText = appNameLabelString;
    
    UILabel *sloganLabel = [UILabel new];
    [self.view addSubview:sloganLabel];
    [sloganLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(appNameLabel.mas_bottom).offset(4);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-100)/2);
        make.size.mas_equalTo(CGSizeMake(100, 13));
    }];
    sloganLabel.numberOfLines = 0;
    sloganLabel.textAlignment = NSTextAlignmentCenter;
    sloganLabel.alpha = 1.0;
    NSMutableAttributedString *sloganLabelString = [[NSMutableAttributedString alloc] initWithString:@"陪你探索留学路"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"QXyingbixing" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:46/255.0 blue:80/255.0 alpha:1.0]}];
    sloganLabel.attributedText = sloganLabelString;
    
    //app版本
    versionLabel = [UILabel new];
    [self.view addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(appNameLabel.mas_bottom).offset(21);
        make.left.equalTo(self.view).offset((SCREEN_WIDTH-100)/2);
        make.size.mas_equalTo(CGSizeMake(100, 17));
    }];
    versionLabel.numberOfLines = 0;
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.alpha = 1.0;
    
    //设置菜单列表
    _platformMenuTableView = [UITableView new];
    [self.view addSubview:_platformMenuTableView];
    [_platformMenuTableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(versionLabel.mas_bottom).offset(27);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48 * 4));
    }];
    //设置数据源为本身
    [_platformMenuTableView setDataSource:self];
    //设置控制器为本身
    [_platformMenuTableView setDelegate:self];
    //使用xib进行cell布局的创建，这里注册一个标志位，用于cell的复用
    [_platformMenuTableView registerNib:[UINib nibWithNibName:@"PlatformMenuXIBCell" bundle:nil] forCellReuseIdentifier:@"PlatformMenuXIBCell"];
    //这句话可以设置tableview没有数据时不显示横线
    _platformMenuTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    //禁止上下拉动弹性
    _platformMenuTableView.bounces = NO;
    _platformMenuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 设置版本 -
-(void)setAppVersion
{
    NSMutableAttributedString *versionLabelString = [[NSMutableAttributedString alloc] initWithString:@"版本 V1.0.1"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    versionLabel.attributedText = versionLabelString;
}

#pragma mark - 设置菜单参数 -
-(void)setPlatformMenuArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    if(!_platformMenuArray){
        
        NSDictionary *dic1 = @{@"menuTitleName":@"喜欢我们, 评论打分"};
        PlatformMenuModel *model1 = [PlatformMenuModel modelWithDict:dic1];
        [tempArray addObject:model1];
        
        NSDictionary *dic2 = @{@"menuTitleName":@"服务条款"};
        PlatformMenuModel *model2 = [PlatformMenuModel modelWithDict:dic2];
        [tempArray addObject:model2];
        
        NSDictionary *dic3 = @{@"menuTitleName":@"隐私权相关政策"};
        PlatformMenuModel *model3 = [PlatformMenuModel modelWithDict:dic3];
        [tempArray addObject:model3];
        
        NSDictionary *dic4 = @{@"menuTitleName":@"版本更新"};
        PlatformMenuModel *model4 = [PlatformMenuModel modelWithDict:dic4];
        [tempArray addObject:model4];
    
    }
    
    _platformMenuArray = [tempArray copy];
}

#pragma mark - table view delagete -
//设置cell的行高 --> heightForRowAtIndexPath
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

#pragma mark - table view datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //行数就是数组内元素数量
    return self.platformMenuArray.count;
}

#pragma mark - cellForRowAtIndexPath -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlatformMenuXIBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlatformMenuXIBCell"];
    //设置点击cell不变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //取本类中的studengArray中的元素来进行cell的更新
    [cell updateCellWithModel:self.platformMenuArray[indexPath.row]];
    return cell;
}

#pragma mark - cell点击事件 -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger rowNum = [indexPath row];
    PlatformMenuModel *selectCellModel = self.platformMenuArray[rowNum];
    NSString *cellName = selectCellModel.menuTitleName;
    
    [AvalonsoftToast showWithMessage:cellName];

}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
