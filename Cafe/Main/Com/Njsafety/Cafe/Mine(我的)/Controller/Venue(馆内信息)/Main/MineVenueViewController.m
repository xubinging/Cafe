//
//  MineVenueViewController.m
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//
//  馆内信息

#import "MineVenueViewController.h"

#import "MineVenueCommentReceiveVC.h"   //收到评论
#import "MineVenueCommentPostVC.h"      //发布评论
#import "MineVenuePostVC.h"             //发布
#import "MineVenueGroupVC.h"            //已加入群
#import "MineVenueSchoolVC.h"           //关注学校
#import "MineVenueOrgVC.h"              //关注机构

#define HEADBTN_TAG 10000

@interface MineVenueViewController ()<UIScrollViewDelegate>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
 
    @private BOOL isShowChinese;            //是否显示中文
}

//按钮宽度
@property (nonatomic, strong) NSMutableArray *buttonWidthArray;
@property (nonatomic, assign) CGFloat buttonMinWidth;   //按钮最小宽度

//分段选择器参数
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIScrollView *headerView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) NSInteger selectIndex;

//标签栏标题数组
@property (nonatomic, strong) NSArray *titleArray;
//每个标签对应ViewController数组
@property (nonatomic, strong) NSArray *subViewControllers;
//非选中状态下标签字体颜色
@property (nonatomic, strong) UIColor *titleColor;
//选中标签字体颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;
//非选中状态下标签字体
@property (nonatomic, strong) UIFont *titleFont;
//选中标签字体
@property (nonatomic, strong) UIFont  *titleSelectedFont;
//标签栏每个按钮高度
@property (nonatomic, assign) CGFloat buttonHeight;

@property (nonatomic, strong) MineVenueCommentReceiveVC *venueCommentReceiveVC;
@property (nonatomic, strong) MineVenueCommentPostVC *venueCommentPostVC;
@property (nonatomic, strong) MineVenuePostVC *venuePostVC;
@property (nonatomic, strong) MineVenueSchoolVC *venueSchoolVC;
@property (nonatomic, strong) MineVenueOrgVC *venueOrgVC;
    
@end

@implementation MineVenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initSegment];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);
    
    isShowChinese = YES;
    
    [self buildSegmentData];    //分段选择器数据
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
    NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"馆内信息" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

-(void)initSegment
{
    //segment视图
    _segmentView = [UIView new];
    [self.view addSubview:_segmentView];
    [_segmentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    //添加按钮
    [self addButtonInScrollHeader:_titleArray];
    
    //添加控制器
    [self addContentViewScrollView:_subViewControllers];
}

//根据传入的title数组新建button显示在顶部scrollView上
- (void)addButtonInScrollHeader:(NSArray *)titleArray
{
    //头部视图尺寸
    self.headerView = [UIScrollView new];
    [_segmentView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_segmentView);
        make.left.equalTo(_segmentView);
        make.right.equalTo(_segmentView);
        make.bottom.equalTo(_segmentView);
    }];
    [self.headerView setBackgroundColor:[UIColor clearColor]];
    [self.headerView setShowsVerticalScrollIndicator:NO];
    [self.headerView setShowsHorizontalScrollIndicator:NO];
    
    //头部视图可滚动
    CGFloat buttonWidth = 0;
    for(int i = 0; i < _buttonWidthArray.count; i++){
        buttonWidth += [_buttonWidthArray[i] doubleValue];
    }
    self.headerView.contentSize = CGSizeMake(buttonWidth, 40);

    CGFloat titleButtonWidth = 0;
    for (NSInteger index = 0; index < _titleArray.count; index++) {
        
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        segmentBtn.frame = CGRectMake(titleButtonWidth, 0, [_buttonWidthArray[index] doubleValue], self.buttonHeight);
        segmentBtn.tag = index + HEADBTN_TAG;
  
        //设置非选中状态的字体
        NSMutableAttributedString *normalString = [[NSMutableAttributedString alloc] initWithString:_titleArray[index] attributes: @{NSFontAttributeName: self.titleFont,NSForegroundColorAttributeName:self.titleColor}];
        [segmentBtn setAttributedTitle:normalString forState:UIControlStateNormal];
        
        //选中状态的字体
         NSMutableAttributedString *selectedString = [[NSMutableAttributedString alloc] initWithString:_titleArray[index] attributes: @{NSFontAttributeName: self.titleSelectedFont,NSForegroundColorAttributeName:self.titleSelectedColor}];
        [segmentBtn setAttributedTitle:selectedString forState:UIControlStateSelected];
    
        [segmentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:segmentBtn];
        
        if (index == 0) {
            segmentBtn.selected = YES;
            self.selectIndex = segmentBtn.tag;
            [self btnClick:segmentBtn];
        }
        
        titleButtonWidth += [_buttonWidthArray[index] doubleValue];
    }
    
    //选择时的指示视图
    //才进页面时选中第一个
    CGFloat lineFrameWidth = [_buttonWidthArray[0] doubleValue];
    _lineView = [[UIView alloc] initWithFrame:CGRectMake((lineFrameWidth - 25)/2, 22 + 10, 25, 4)];
    [self.headerView addSubview:_lineView];
    _lineView.layer.cornerRadius = 2;
    _lineView.layer.shadowColor = [UIColor colorWithRed:251/255.0 green:142/255.0 blue:48/255.0 alpha:0.19].CGColor;
    _lineView.layer.shadowOffset = CGSizeMake(0,2);
    _lineView.layer.shadowOpacity = 1;
    _lineView.layer.shadowRadius = 4;
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = _lineView.bounds;
    gl.startPoint = CGPointMake(1, -0.34);
    gl.endPoint = CGPointMake(0, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:154/255.0 blue:66/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 2;
    [_lineView.layer addSublayer:gl];
    
}

//根据传入的viewController数组，将viewController的view添加到显示内容的scrollView
- (void)addContentViewScrollView:(NSArray *)subViewControllers
{
    _mainScrollView = [UIScrollView new];
    [self.view addSubview:_mainScrollView];
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_segmentView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
    }];
    [_mainScrollView setBackgroundColor:[UIColor clearColor]];
    
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, SCREEN_HEIGHT-StatusBarSafeTopMargin-64-40-10-TabbarSafeBottomMargin-10);
    [_mainScrollView setPagingEnabled:YES];

    //不可滑动
    _mainScrollView.scrollEnabled = YES;
    
    [_mainScrollView setShowsVerticalScrollIndicator:NO];
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    
    [self.view layoutIfNeeded];
    
    [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
        viewController.view.frame = CGRectMake(idx * SCREEN_WIDTH, 0, SCREEN_WIDTH, _mainScrollView.frame.size.height);
        [_mainScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}

- (void)btnClick:(UIButton *)button
{
    [_mainScrollView scrollRectToVisible:CGRectMake((button.tag - HEADBTN_TAG) *SCREEN_WIDTH, 0, SCREEN_WIDTH, _mainScrollView.frame.size.height) animated:YES];
    [self didSelectSegmentIndex:button.tag];
    
    if ((button.tag - HEADBTN_TAG) == 0) {
        [self.venueCommentReceiveVC getMyReceiveReplyList];
    } else if ((button.tag - HEADBTN_TAG) == 1) {
        [self.venueCommentPostVC getMyPostReplyList];
    } else if ((button.tag - HEADBTN_TAG) == 2) {
        [self.venuePostVC getMyPostList];
    } else if ((button.tag - HEADBTN_TAG) == 3) {
        [self.venueSchoolVC getMyAboardSelectList];
    } else if ((button.tag - HEADBTN_TAG) == 4) {
        [self.venueOrgVC getMyInternalSelectList];
    }
}

//设置顶部选中button下方线条位置
- (void)didSelectSegmentIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:self.selectIndex];
    btn.selected = NO;
    self.selectIndex = index;
    
    UIButton *currentSelectBtn = (UIButton *)[self.view viewWithTag:index];
    currentSelectBtn.selected = YES;
    CGRect rect = self.lineView.frame;
    
    CGFloat slctLineX = 0;
    for(int i = 0; i < _selectIndex - HEADBTN_TAG; i++){
        slctLineX += [_buttonWidthArray[i] doubleValue];
    }
    rect.origin.x = slctLineX + ([_buttonWidthArray[_selectIndex - HEADBTN_TAG] doubleValue] - 25)/2;
    [UIView animateWithDuration:0.1 animations:^{
        self.lineView.frame = rect;
    }];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _mainScrollView) {
        float xx = scrollView.contentOffset.x * (_buttonMinWidth / SCREEN_WIDTH) - _buttonMinWidth;
        [_headerView scrollRectToVisible:CGRectMake(xx, 0, SCREEN_WIDTH, _headerView.frame.size.height) animated:YES];
        NSInteger currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
        [self didSelectSegmentIndex:currentIndex + HEADBTN_TAG];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    float xx = scrollView.contentOffset.x * (_buttonMinWidth / SCREEN_WIDTH) - _buttonMinWidth;
    [_headerView scrollRectToVisible:CGRectMake(xx, 0, SCREEN_WIDTH, _headerView.frame.size.height) animated:YES];
}

#pragma mark - 分段选择器相关 begin -
-(void)buildSegmentData
{
    _titleArray = @[@"收到评论", @"发布评论", @"发布", @"关注学校", @"关注机构"];
    _titleColor = RGBA_GGCOLOR(153, 153, 153, 1.0);         //非选中状态字体颜色
    _titleSelectedColor = RGBA_GGCOLOR(34, 34, 34, 1.0);    //选中状态字体颜色
    _titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];  //非选中状态字体
    _titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Medium" size: 16];  //选中状态字体
    _buttonHeight = 22;                                     //按钮高度
    
    //按钮宽度数组
    _buttonWidthArray = [NSMutableArray array];
    _buttonMinWidth = 10000;
    
    NSMutableArray *controlArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _titleArray.count; i ++) {
        
        CGFloat strWidth = [UILabel getWidthWithText:_titleArray[i] font:_titleFont];
        [_buttonWidthArray addObject:@(strWidth + 20)];
        
        if((strWidth + 20) < _buttonMinWidth){
            _buttonMinWidth = strWidth + 20;
        }
        
        if([_titleArray[i] isEqualToString:@"收到评论"]){
            self.venueCommentReceiveVC =  [MineVenueCommentReceiveVC new];
            [controlArray addObject:self.venueCommentReceiveVC];
            
        }else if([_titleArray[i] isEqualToString:@"发布评论"]){
            self.venueCommentPostVC = [MineVenueCommentPostVC new];
            [controlArray addObject:self.venueCommentPostVC];
            
        }else if([_titleArray[i] isEqualToString:@"发布"]){
            self.venuePostVC = [MineVenuePostVC new];
            [controlArray addObject:self.venuePostVC];
            
        }else if([_titleArray[i] isEqualToString:@"已加入群"]){
            MineVenueGroupVC *viewController = [MineVenueGroupVC new];
            [controlArray addObject:viewController];
            
        }else if([_titleArray[i] isEqualToString:@"关注学校"]){
            self.venueSchoolVC = [MineVenueSchoolVC new];
            [controlArray addObject:self.venueSchoolVC];
            
        }else if([_titleArray[i] isEqualToString:@"关注机构"]){
            self.venueOrgVC = [MineVenueOrgVC new];
            [controlArray addObject:self.venueOrgVC];
        }
    }
    
    _subViewControllers = controlArray;
}
#pragma mark - 分段选择器相关 end -

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 右侧按钮点击 -
-(void)rightButtonClick
{
    
}

@end
