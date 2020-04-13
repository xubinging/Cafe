//
//  MineMainViewController.m
//  Cafe
//
//  Created by leo on 2019/12/16.
//  Copyright © 2019 leo. All rights reserved.
//

#import "MineMainViewController.h"

#import "AvalonsoftMenuButton.h"
#import "AvalonsoftMenuScrollView.h"
#import "MineDetailCommonModel.h"
#import "SDImageCache.h"

#import "SystemSettingViewController.h"         //系统设置
#import "MyCollectionViewController.h"          //我的收藏
#import "MyLikeViewController.h"                //我的关注
#import "MeCardProgressViewController.h"        //meCard完善度
#import "MyQRCodeViewController.h"              //我的二维码

#import "SystemSettingPersonalDataViewController.h" //基本资料
#import "MineResultViewController.h"            //考试成绩
#import "MineVenueViewController.h"             //馆内信息
#import "MineEducationViewController.h"         //教育背景
#import "MineLearningViewController.h"          //学术经历
#import "MineOfferViewController.h"             //Offer
#import "MineJobViewController.h"               //工作经历
#import "MineActivityViewController.h"          //课外活动
#import "MineRewordAndSkillViewController.h"    //奖项与技能

#define KMyServiceViewHeight 220

@interface MineMainViewController ()<AvalonsoftMenuScrollViewDelegate>

{
@private UIScrollView *contentScrollView;       // 滑动视图
    
@private UIView *navigationView;                // 导航视图
@private UIButton *settingButton;               // 设置按钮
@private UIButton *messageButton;               // 信息按钮
    
@private UIView *userInfoView;                  // 用户信息视图
@private UIImageView *userIconImageView;        // 头像
@private UILabel *userNickname;                 // 昵称
@private UIImageView *userSex;                  // 性别
@private UILabel *userMotto;                    // 格言
@private UILabel *userMessageNum;               // 文章数量
@private UILabel *userSeeNum;                   // 浏览量
@private UILabel *userLikeNum;                  // 点赞量
    
@private UIView *likeAndCollectionview;         // 我的关注、我的收藏
@private UIButton *likeButton;
@private UIButton *collectionButton;
@private UIButton *meCardProgressButton;        //meCard完善度按钮
@private AvalonsoftProgressBar *progressBar;    //进度条
@private UILabel *progressBarLabel;             //进度条文字
    
@private UIView *meCardView;                    // meCard
@private UIButton *codeButton;                  // 二维码
    
@private UIButton *activityEntryButton;         // 图片按钮
    
@private UIView *serviceView;                   // 我的服务
    
@private MineDetailCommonModel *detailInfo; // 个人详细信息
    
@private AvalonsoftUserDefaultsModel *userDefaultsModel;
    
}

@property (nonatomic,strong)AvalonsoftMenuScrollView *serviceMenuScrollView;

@end

@implementation MineMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initParentView];
    [self initNavigationView];
    [self initUserInfoView];
    [self initLikeAndCollectionview];
    [self initMeCardViewview];
    [self initServiceView];
    
    [self setProgressBar];
    [self setListener];
}


-(void)viewDidAppear:(BOOL)animated {
    //    [self initSharedPreferences];
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
        userDefaultsModel = [AvalonsoftUserDefaultsModel userDefaultsModel];
        
        [self getUserExtInfo];
    } @catch (NSException *exception) {
        @throw exception;
        
    }
}

#pragma mark - 初始化所有父类视图 -
-(void)initParentView
{
    //添加UIScrollView
    contentScrollView = [UIScrollView new];
    [self.view addSubview:contentScrollView];
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabBarHeight);
    }];
    [contentScrollView setBackgroundColor:[UIColor clearColor]];
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.bounces = YES;         //禁止上下弹动
    
    //背景
    UIImageView *contentBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -StatusBarHeight, SCREEN_WIDTH, 258)];
    [contentScrollView addSubview:contentBgImageView];
    contentBgImageView.image = [UIImage imageNamed:@"mine_background"];
    
    //我的关注、我的收藏；高度距离减去状态栏高度
    likeAndCollectionview = [[UIView alloc] initWithFrame:CGRectMake(10, 194 - 20, SCREEN_WIDTH-20, 90)];
    [contentScrollView addSubview:likeAndCollectionview];
    likeAndCollectionview.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    likeAndCollectionview.layer.cornerRadius = 10;
    likeAndCollectionview.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    likeAndCollectionview.layer.shadowOffset = CGSizeMake(0,0);
    likeAndCollectionview.layer.shadowOpacity = 1;
    likeAndCollectionview.layer.shadowRadius = 10;
    
    //meCard
    meCardView = [UIView new];
    [contentScrollView addSubview:meCardView];
    [meCardView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(likeAndCollectionview.mas_bottom).offset(10);
        make.left.equalTo(likeAndCollectionview);
        make.right.equalTo(likeAndCollectionview);
        make.height.equalTo(@190);
    }];
    meCardView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    meCardView.layer.cornerRadius = 10;
    meCardView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    meCardView.layer.shadowOffset = CGSizeMake(0,0);
    meCardView.layer.shadowOpacity = 1;
    meCardView.layer.shadowRadius = 10;
    
    //图片按钮
    activityEntryButton = [UIButton new];
    [contentScrollView addSubview:activityEntryButton];
    [activityEntryButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(meCardView.mas_bottom).offset(15);
        make.left.equalTo(meCardView);
        make.right.equalTo(meCardView);
        make.height.equalTo(@66);
    }];
    [activityEntryButton setImage:[UIImage imageNamed:@"mine_activity_entry"] forState:UIControlStateNormal];
    [activityEntryButton setAdjustsImageWhenHighlighted:NO];
    
    //service
    serviceView = [UIView new];
    [contentScrollView addSubview:serviceView];
    [serviceView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(activityEntryButton.mas_bottom).offset(15);
        make.left.equalTo(activityEntryButton);
        make.right.equalTo(activityEntryButton);
        make.height.equalTo(@(KMyServiceViewHeight));
    }];
    serviceView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    serviceView.layer.cornerRadius = 10;
    serviceView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    serviceView.layer.shadowOffset = CGSizeMake(0,0);
    serviceView.layer.shadowOpacity = 1;
    serviceView.layer.shadowRadius = 10;
    
    [self.view layoutIfNeeded];
    
    [contentScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(serviceView.frame) + 10)];
}

#pragma mark - 导航视图 -
-(void)initNavigationView
{
    //顶部导航视图
    navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 30)];
    [contentScrollView addSubview:navigationView];
    [navigationView setBackgroundColor:[UIColor clearColor]];
    
    //我的标签
    UILabel *pageNameLabel = [UILabel new];
    [navigationView addSubview:pageNameLabel];
    [pageNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView);
        make.left.equalTo(navigationView).offset(10);
        make.size.mas_equalTo(CGSizeMake(44, 30));
    }];
    pageNameLabel.numberOfLines = 0;
    pageNameLabel.textAlignment = NSTextAlignmentLeft;
    pageNameLabel.alpha = 1.0;
    NSMutableAttributedString *pageNameLabelString = [[NSMutableAttributedString alloc] initWithString:@"我的"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 22],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
    pageNameLabel.attributedText = pageNameLabelString;
    
    //设置按钮
    settingButton = [UIButton new];
    [navigationView addSubview:settingButton];
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(pageNameLabel).offset(4);
        make.right.equalTo(navigationView).offset(-62);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    [settingButton setImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    [settingButton setAdjustsImageWhenHighlighted:NO];
    
    //信息按钮
    messageButton = [UIButton new];
    [navigationView addSubview:messageButton];
    [messageButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(pageNameLabel).offset(4);
        make.right.equalTo(navigationView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    [messageButton setImage:[UIImage imageNamed:@"mine_message"] forState:UIControlStateNormal];
    [messageButton setAdjustsImageWhenHighlighted:NO];
    
}

#pragma mark - 用户信息 -
-(void)initUserInfoView
{
    
    userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 7 + 30 + 13, SCREEN_WIDTH, 104)];
    [contentScrollView addSubview:userInfoView];
    [userInfoView setBackgroundColor:[UIColor clearColor]];
    
    // 头像
    userIconImageView = [UIImageView new];
    [userInfoView addSubview:userIconImageView];
    [userIconImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userInfoView);
        make.left.equalTo(userInfoView).offset(10);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
    
    // 昵称；标签长度变化的
    userNickname = [UILabel new];
    [userInfoView addSubview:userNickname];
    [userNickname mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userInfoView);
        make.left.equalTo(userIconImageView.mas_right).offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 22));
    }];
    userNickname.numberOfLines = 0;
    userNickname.textAlignment = NSTextAlignmentLeft;
    userNickname.alpha = 1.0;
    [userNickname setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
    [userNickname setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    
    // 性别
    userSex = [UIImageView new];
    [userInfoView addSubview:userSex];
    [userSex mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userInfoView).offset(3);
        make.left.equalTo(userNickname.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    // 格言
    userMotto = [UILabel new];
    [userInfoView addSubview:userMotto];
    [userMotto mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userNickname.mas_bottom).offset(6);
        make.left.equalTo(userIconImageView.mas_right).offset(15);
        make.right.equalTo(userInfoView).offset(-10);
        make.height.mas_equalTo(@17);
    }];
    userMotto.numberOfLines = 0;
    userMotto.textAlignment = NSTextAlignmentLeft;
    userMotto.alpha = 1.0;
    [userMotto setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
    [userMotto setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    
    // 文章数量
    userMessageNum = [UILabel new];
    [userInfoView addSubview:userMessageNum];
    [userMessageNum mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(userInfoView).offset(10);
        make.top.equalTo(userIconImageView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
    userMessageNum.numberOfLines = 0;
    userMessageNum.textAlignment = NSTextAlignmentCenter;
    userMessageNum.alpha = 1.0;
    [userMessageNum setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
    [userMessageNum setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    
    UILabel *userMessageNumLabel = [UILabel new];
    [userInfoView addSubview:userMessageNumLabel];
    [userMessageNumLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(userMessageNum);
        make.top.equalTo(userMessageNum.mas_bottom).offset(4);
        make.size.mas_equalTo(CGSizeMake(60, 17));
    }];
    userMessageNumLabel.numberOfLines = 0;
    userMessageNumLabel.textAlignment = NSTextAlignmentCenter;
    userMessageNumLabel.alpha = 1.0;
    [userMessageNumLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
    [userMessageNumLabel setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    [userMessageNumLabel setText:@"文章"];
    
    // 浏览量
    userSeeNum = [UILabel new];
    [userInfoView addSubview:userSeeNum];
    [userSeeNum mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(userMessageNum.mas_right).offset(15);
        make.top.equalTo(userMessageNum);
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
    userSeeNum.numberOfLines = 0;
    userSeeNum.textAlignment = NSTextAlignmentCenter;
    userSeeNum.alpha = 1.0;
    [userSeeNum setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
    [userSeeNum setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    
    UILabel *userSeeNumLabel = [UILabel new];
    [userInfoView addSubview:userSeeNumLabel];
    [userSeeNumLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(userSeeNum);
        make.top.equalTo(userSeeNum.mas_bottom).offset(4);
        make.size.mas_equalTo(CGSizeMake(60, 17));
    }];
    userSeeNumLabel.numberOfLines = 0;
    userSeeNumLabel.textAlignment = NSTextAlignmentCenter;
    userSeeNumLabel.alpha = 1.0;
    [userSeeNumLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
    [userSeeNumLabel setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    [userSeeNumLabel setText:@"浏览量"];
    
    // 点赞量
    userLikeNum = [UILabel new];
    [userInfoView addSubview:userLikeNum];
    [userLikeNum mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(userSeeNum.mas_right).offset(15);
        make.top.equalTo(userSeeNum);
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
    userLikeNum.numberOfLines = 0;
    userLikeNum.textAlignment = NSTextAlignmentCenter;
    userLikeNum.alpha = 1.0;
    [userLikeNum setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
    [userLikeNum setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    
    UILabel *userLikeNumLabel = [UILabel new];
    [userInfoView addSubview:userLikeNumLabel];
    [userLikeNumLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(userLikeNum);
        make.top.equalTo(userLikeNum.mas_bottom).offset(4);
        make.size.mas_equalTo(CGSizeMake(60, 17));
    }];
    userLikeNumLabel.numberOfLines = 0;
    userLikeNumLabel.textAlignment = NSTextAlignmentCenter;
    userLikeNumLabel.alpha = 1.0;
    [userLikeNumLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
    [userLikeNumLabel setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    [userLikeNumLabel setText:@"被点赞"];
    
}

#pragma mark - 关注和收藏 -
-(void)initLikeAndCollectionview
{
    //我的关注
    likeButton = [UIButton new];
    [likeAndCollectionview addSubview:likeButton];
    [likeButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(likeAndCollectionview).offset(((SCREEN_WIDTH - 20)/2 - 91)/2);
        make.top.equalTo(likeAndCollectionview).offset(13);
        make.size.mas_equalTo(CGSizeMake(91, 30));
    }];
    //图片
    [likeButton setImage:[UIImage imageNamed:@"mine_mylike"] forState:UIControlStateNormal];
    //文字
    NSMutableAttributedString *myLikeString = [[NSMutableAttributedString alloc] initWithString:@"我的关注"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [likeButton setAttributedTitle:myLikeString forState:UIControlStateNormal];
    //文字偏移量
    [likeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [likeButton setAdjustsImageWhenHighlighted:NO];
    
    //分割线
    UIView *splitView = [UIView new];
    [likeAndCollectionview addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(likeAndCollectionview).offset((SCREEN_WIDTH - 20)/2);
        make.top.equalTo(likeAndCollectionview).offset(16);
        make.size.mas_equalTo(CGSizeMake(1, 20));
    }];
    [splitView setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    //我的收藏
    collectionButton = [UIButton new];
    [likeAndCollectionview addSubview:collectionButton];
    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(likeAndCollectionview).offset(-((SCREEN_WIDTH - 20)/2 - 91)/2);
        make.top.equalTo(likeAndCollectionview).offset(13);
        make.size.mas_equalTo(CGSizeMake(91, 30));
    }];
    //图片
    [collectionButton setImage:[UIImage imageNamed:@"mine_mycollection"] forState:UIControlStateNormal];
    //文字
    NSMutableAttributedString *myCollectionString = [[NSMutableAttributedString alloc] initWithString:@"我的收藏"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [collectionButton setAttributedTitle:myCollectionString forState:UIControlStateNormal];
    //文字偏移量
    [collectionButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [collectionButton setAdjustsImageWhenHighlighted:NO];
    
    //分割线
    UIView *splitView2 = [UIView new];
    [likeAndCollectionview addSubview:splitView2];
    [splitView2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(likeAndCollectionview).offset(15);
        make.top.equalTo(likeAndCollectionview).offset(52);
        make.right.equalTo(likeAndCollectionview).offset(-15);
        make.height.mas_equalTo(@1);
    }];
    [splitView2 setBackgroundColor:RGBA_GGCOLOR(238, 238, 238, 1)];
    
    //信息完成度按钮
    meCardProgressButton = [UIButton new];
    [likeAndCollectionview addSubview:meCardProgressButton];
    [meCardProgressButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(likeAndCollectionview).offset(15);
        make.bottom.equalTo(likeAndCollectionview.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [meCardProgressButton setImage:[UIImage imageNamed:@"mine_infoprogress"] forState:UIControlStateNormal];
    [meCardProgressButton setAdjustsImageWhenHighlighted:NO];
    
    //进度条
    progressBar = [[AvalonsoftProgressBar alloc] initWithFrame:CGRectMake(15+18+10, 67, SCREEN_WIDTH-20-15-18-10-15-30-3, 8) progressViewStyle:AvalonsoftProgressBarStyleTrackFillet];
    [progressBar setProgressTintColor:RGBA_GGCOLOR(32, 188, 255, 1)];
    [progressBar setTrackTintColor:RGBA_GGCOLOR(246, 246, 246, 1)];
    [likeAndCollectionview addSubview:progressBar];
    
    //进度条文字
    progressBarLabel = [UILabel new];
    [likeAndCollectionview addSubview:progressBarLabel];
    [progressBarLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(likeAndCollectionview.mas_right).offset(-15);
        make.bottom.equalTo(likeAndCollectionview.mas_bottom).offset(-12);
        make.size.mas_equalTo(CGSizeMake(30, 14));
    }];
    progressBarLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:10];
    [progressBarLabel setTextColor:RGBA_GGCOLOR(203, 207, 217, 1)];
    [progressBarLabel setText:@"0%"];
    progressBarLabel.textAlignment = NSTextAlignmentLeft;
    
}

#pragma mark - meCard -
-(void)initMeCardViewview
{
    //标题
    UILabel *titleLabel = [UILabel new];
    [meCardView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(meCardView).offset(10);
        make.top.equalTo(meCardView).offset(15);
        make.size.mas_equalTo(CGSizeMake(62, 22));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"meCard"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
    //二维码按钮
    codeButton = [UIButton new];
    [meCardView addSubview:codeButton];
    [codeButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(meCardView).offset(-15);
        make.top.equalTo(meCardView).offset(16);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [codeButton setImage:[UIImage imageNamed:@"mine_code"] forState:UIControlStateNormal];
    [codeButton setAdjustsImageWhenHighlighted:NO];
    
    //meCard功能按钮；直接使用 uibutton 进行创建
    CGFloat iconWidth = (SCREEN_WIDTH-20) / 5;
    //第一行
    NSArray *titleArrayOne = @[@"基本资料", @"考试成绩", @"馆内信息", @"教育背景", @"学术经历"];
    NSArray *iconArrayOne = @[@"mine_mecard_data", @"mine_mecard_result", @"mine_mecard_venue", @"mine_mecard_education", @"mine_mecard_learning"];
    
    for (int i = 0; i < titleArrayOne.count; i++) {
        UIButton *mecardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [meCardView addSubview:mecardBtn];
        mecardBtn.frame = CGRectMake(i * iconWidth, 15 + 22 + 15, iconWidth, 50);
        
        [mecardBtn setImage:[UIImage imageNamed:iconArrayOne[i]] forState:UIControlStateNormal];
        NSMutableAttributedString *mecardBtnString = [[NSMutableAttributedString alloc] initWithString:titleArrayOne[i] attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        [mecardBtn setAttributedTitle:mecardBtnString forState:UIControlStateNormal];
        mecardBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [mecardBtn setAdjustsImageWhenHighlighted:NO];
        mecardBtn.tag = i;
        [mecardBtn addTarget:self action:@selector(mecardBtnOneClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //关键步骤
        mecardBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //调用方法
        [self initButton:mecardBtn];
    }
    
    //第二行
    NSArray *titleArrayTwo = @[@"Offer", @"工作经历", @"课外活动", @"历史时刻", @"奖项与技能"];
    NSArray *iconArrayTwo = @[@"mine_mecard_offer", @"mine_mecard_job", @"mine_mecard_activity", @"mine_mecard_history", @"mine_mecard_reword"];
    
    for (int i = 0; i < titleArrayTwo.count; i++) {
        UIButton *mecardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [meCardView addSubview:mecardBtn];
        mecardBtn.frame = CGRectMake(i * iconWidth, 15 + 22 + 15 + 50 + 20, iconWidth, 50);
        
        [mecardBtn setImage:[UIImage imageNamed:iconArrayTwo[i]] forState:UIControlStateNormal];
        NSMutableAttributedString *mecardBtnString = [[NSMutableAttributedString alloc] initWithString:titleArrayTwo[i] attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        [mecardBtn setAttributedTitle:mecardBtnString forState:UIControlStateNormal];
        mecardBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [mecardBtn setAdjustsImageWhenHighlighted:NO];
        mecardBtn.tag = i;
        [mecardBtn addTarget:self action:@selector(mecardBtnTwoClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //关键步骤
        mecardBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //调用方法
        [self initButton:mecardBtn];
    }
}

//方法直接调用
-(void)initButton:(UIButton *)btn
{
    //获取文字宽度
    CGSize maxSize = CGSizeMake(1000, btn.titleLabel.bounds.size.height);
    CGSize fitSize = [btn.titleLabel sizeThatFits:maxSize];
    CGFloat titleLabelWidth = fitSize.width;
    
    //图片宽度
    CGFloat imageWidth = btn.imageView.bounds.size.width;
    CGFloat imageHeight = btn.imageView.bounds.size.height;
    
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(32 ,-imageWidth, 0, 0)];
    
    //图片距离右边框距离减少图片的宽度，其它不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-imageHeight, 0, 0, -titleLabelWidth)];
}

#pragma mark - 我的服务 -
-(void)initServiceView
{
    //标题
    UILabel *titleLabel = [UILabel new];
    [serviceView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(serviceView).offset(10);
        make.top.equalTo(serviceView).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 22));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"我的服务"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
    
    //设置参数
    NSMutableArray *serviceBtnArr = [NSMutableArray array];
    NSArray *titles = @[@"邀请好友", @"我的咖啡豆", @"留学预算", @"抢位课程", @"学学留学管理", @"我的留学日程", @"权限设定", @"本地留学资讯", @"我的时间轴"];
    NSArray *icons = @[@"mine_service_friend", @"mine_service_bean", @"mine_service_money", @"mine_service_class", @"mine_service_manage", @"mine_service_class", @"mine_service_setting", @"mine_service_news", @"mine_service_time"];
    
    for (int i = 0; i < titles.count; i++) {
        AvalonsoftMenuButton *btn = [[AvalonsoftMenuButton alloc] initWithFrame:CGRectZero withTitle:titles[i] withImageString:icons[i]];
        [serviceBtnArr addObject:btn];
    }
    
    _serviceMenuScrollView = [[AvalonsoftMenuScrollView alloc] initWithFrame:CGRectMake(0, 15 + 22 + 10, SCREEN_WIDTH - 20, KMyServiceViewHeight - 15 - 22 - 10 - 10) viewsArray:serviceBtnArr];
    _serviceMenuScrollView.delegate = self;
    [serviceView addSubview:_serviceMenuScrollView];
}

#pragma mark - AvalonsoftMenuScrollViewDelegate -
- (void)buttonUpInsideWithView:(UIButton *)btn withIndex:(NSInteger)index withView:(AvalonsoftMenuScrollView *)view
{
    NSLog(@"%ld",index);
}

#pragma mark - 设置用户信息 -
-(void)setUserInfo
{
    NSString *userNicknameStr = [_UserInfo userName];
    CGFloat strWidth = [UILabel getWidthWithText:userNicknameStr font:[UIFont fontWithName:@"PingFangSC-Medium" size:16]];
    if(strWidth > (SCREEN_WIDTH - 10 - 46 - 15 - 10 - 16 - 20)){
        strWidth = SCREEN_WIDTH - 10 - 46 - 15 - 10 - 16 - 20;
    }
    [userNickname setText:userNicknameStr];
    [userNickname mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(strWidth, 22));
    }];
    
    if ([[detailInfo sex] isEqualToString:@"男"]) {
        [userSex setImage:[UIImage imageNamed:@"mine_boy"]];
    } else {
        [userSex setImage:[UIImage imageNamed:@"mine_girl"]];
    }
    
    if ([detailInfo aboutme] == NULL || [@"" isEqualToString:[detailInfo aboutme]]) {
        [userMotto setText:@"暂无数据"];
    } else {
        [userMotto setText:[detailInfo aboutme]];
    }
    
//    NSString *url = [[NSString alloc] init];
//    url = [FILE_SERVER_URL stringByAppendingFormat:@"/%@",[detailInfo headportrait]];
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    
//    NSLog(@"headurl=%@",url);
//    [manager loadImageWithURL:url options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//        
//    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//        [self->userIconImageView setImage:image];
//    }];
    [self->userIconImageView sd_setImageWithURL:[NSURL URLWithString:[_F createFileLoadUrl:[detailInfo headportrait]]]];

    
    [userMessageNum setText:@"0"];
    [userSeeNum setText:@"0"];
    [userLikeNum setText:@"0"];
}

#pragma mark - 设置进度条 -
-(void)setProgressBar
{
    [progressBar setProgress:0.7f];
    
    progressBarLabel.text = @"70%";
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    
    //系统设置
    [settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //消息
    [messageButton addTarget:self action:@selector(messageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //我的关注
    [likeButton addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //我的收藏
    [collectionButton addTarget:self action:@selector(collectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //meCard完善度
    [meCardProgressButton addTarget:self action:@selector(meCardProgressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //我的二维码
    [codeButton addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 第一行mecard按钮点击 -
-(void)mecardBtnOneClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            // 基本资料
            //            [AvalonsoftToast showWithMessage:@"点击了:基本资料"];
            [self pushToViewController:[SystemSettingPersonalDataViewController new]];
            break;
            
        case 1:
            // 考试成绩
            [self pushToViewController:[MineResultViewController new]];
            
            break;
            
        case 2:
            // 馆内信息
            [self pushToViewController:[MineVenueViewController new]];
            
            break;
            
        case 3:
            // 教育背景
            [self pushToViewController:[MineEducationViewController new]];
            
            break;
            
        case 4:
            // 学术经历
            [self pushToViewController:[MineLearningViewController new]];
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 第二行mecard按钮点击 -
-(void)mecardBtnTwoClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            // Offer
            [self pushToViewController:[MineOfferViewController new]];
            
            break;
            
        case 1:
            // 工作经历
            [self pushToViewController:[MineJobViewController new]];
            
            break;
            
        case 2:
            // 课外活动
            [self pushToViewController:[MineActivityViewController new]];
            
            break;
            
        case 3:
            // 历史时刻
            [AvalonsoftToast showWithMessage:@"点击了:历史时刻"];
            break;
            
        case 4:
            // 奖项与技能
            [self pushToViewController:[MineRewordAndSkillViewController new]];
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 设置按钮点击 -
-(void)settingButtonClick
{
    
    [self pushToViewController:[SystemSettingViewController new]];
    
}

#pragma mark - 信息按钮点击 -
-(void)messageButtonClick
{
    
}

#pragma mark - 我的关注按钮点击 -
-(void)likeButtonClick
{
    
    [self pushToViewController:[MyLikeViewController new]];
    
}

#pragma mark - 我的收藏按钮点击 -
-(void)collectionButtonClick
{
    
    [self pushToViewController:[MyCollectionViewController new]];
    
}

#pragma mark - meCard完善度按钮点击 -
-(void)meCardProgressButtonClick
{
    
    [self pushToViewController:[MeCardProgressViewController new]];
    
}

#pragma mark - 我的二维码按钮点击 -
-(void)codeButtonClick
{
    
    [self pushToViewController:[MyQRCodeViewController new]];
    
}

#pragma mark - 统一的跳转处理 -
-(void)pushToViewController:(UIViewController *)control
{
    //将操作放在主线程中
    dispatch_async(dispatch_get_main_queue(), ^{
        // 隐藏底部tabbar
        control.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:control animated:YES];
    });
}

#pragma mark - 设置状态栏字体颜色为白色 -
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if(!IS_iPhoneX){
        return UIStatusBarStyleDefault;
    }
    
    return UIStatusBarStyleLightContent;
}
#pragma mark - 顺序请求接口 -
-(void)dispatchAllRequest
{
    __weak typeof (self)weakSelf = self;
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        // 获取用户信息
        [weakSelf getUserExtInfo];
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        // 获取被点赞数
        [weakSelf getMyLikedCount];
    }];
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        // 获取文章数
        [weakSelf getMyPostList];
    }];
    
    [operation2 addDependency:operation1];
    [operation3 addDependency:operation2];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation1,operation2,operation3] waitUntilFinished:NO];
}

#pragma mark - 所有网络请求处理都在这里进行 -
-(void)getUserExtInfo
{
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            NSString *url = [[NSString alloc] init];
            url = [COMMON_SERVER_URL stringByAppendingFormat:@"/%@\%@",MINE_MAIN_GET_USER_EXTINFO, [_UserInfo accountId]];
            //            url = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            NSLog(@"getUserExtInfo url=%@",url);//requestWithActionUrlAndParam
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithActionUrlAndParam:url method:HttpRequestPost paramenters:root prepareExecute:^{
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_MAIN_GET_USER_EXTINFO];
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

-(void)getMyLikedCount
{
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_LIKED_COUNT method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_MY_LIKED_COUNT];
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

-(void)getMyPostList
{
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool has) {
        if (has) {
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            [root setValue:[_UserInfo accountId] forKey:@"accountId"];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:MINE_MY_POST_LIST method:HttpRequestPost paramenters:root prepareExecute:^{
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //处理网络请求结果
                [self handleNetworkRequestWithResponseObject:responseObject eventType:MINE_MY_POST_LIST];
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
    __weak typeof (self)weakSelf = self;
    NSLog(@"handleNetworkRequestWithResponseObject responseObject=%@ %@",responseObject,eventType);
    //使用responseObject对_M进行MVC赋值
    _M *responseModel = [_M createResponseJsonObj:responseObject];
    
    NSLog(@"handleNetworkRequestWithResponseObject %ld %@",responseModel.rescode,responseModel.msg);
    
    @try {
        if([eventType isEqualToString:MINE_MAIN_GET_USER_EXTINFO]){
            if(responseModel.rescode == 200){
                detailInfo = [MineDetailCommonModel modelWithDict:responseModel.data];
                
                userDefaultsModel.phoneNumber = detailInfo.phonenumber;
                userDefaultsModel.email = detailInfo.email;
                // 切换到主线程
//                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setUserInfo];
//                });
                [weakSelf getMyLikedCount];
            }else{
                
            }
        } else if([eventType isEqualToString:MINE_MY_LIKED_COUNT]){
            if(responseModel.rescode == 200){
                NSDictionary *data = (NSDictionary *) responseObject;
                int count = [[NSString stringWithFormat:@"%@", data[@"data"]] intValue];
               
                [userLikeNum setText:[NSString stringWithFormat:@"%d",count]];
                [weakSelf getMyPostList];
            }else{
                
            }
        } else if([eventType isEqualToString:MINE_MY_POST_LIST]){
            if(responseModel.rescode == 200){
                NSDictionary *data = responseModel.data;
                int count = [[NSString stringWithFormat:@"%@", data[@"count"]] intValue];

                [userMessageNum setText:[NSString stringWithFormat:@"%d",count]];
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
