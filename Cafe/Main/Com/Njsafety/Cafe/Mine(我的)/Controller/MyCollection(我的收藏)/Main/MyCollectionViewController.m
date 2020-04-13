//
//  MyCollectionViewController.m
//  Cafe
//
//  Created by leo on 2020/1/5.
//  Copyright © 2020 leo. All rights reserved.
//
//  我的收藏

#import "MyCollectionViewController.h"

#import "MyCollectionPostVC.h"              //帖子
#import "MyCollectionPrepareCourseVC.h"     //预科项目

#define HEADBTN_TAG 10000

@interface MyCollectionViewController ()<UIScrollViewDelegate>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    
    @private UIView *segmentView;
    @private NSArray *inUseItems;
}

//分段选择器参数
@property (nonatomic, strong) UIScrollView *headerView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation MyCollectionViewController

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
    
    //创建分段选择器数据
    inUseItems = @[@"帖子", @"预科项目"];
    
    _titleArray = inUseItems;
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
    
    //标题
    UILabel *titleLabel = [UILabel new];
    [navigationView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-100)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"我的收藏"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

-(void)initSegment
{
    //segment视图
    segmentView = [UIView new];
    [self.view addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make){
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
    [segmentView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(segmentView);
        make.left.equalTo(segmentView);
        make.right.equalTo(segmentView);
        make.bottom.equalTo(segmentView);
    }];
    [self.headerView setBackgroundColor:[UIColor clearColor]];
    [self.headerView setShowsVerticalScrollIndicator:NO];
    [self.headerView setShowsHorizontalScrollIndicator:NO];
    
    //可滚动
    self.headerView.contentSize = CGSizeMake(self.buttonWidth * _titleArray.count, 40);

    for (NSInteger index = 0; index < _titleArray.count; index++) {
        
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        segmentBtn.frame = CGRectMake(self.buttonWidth * index, 0, self.buttonWidth, self.buttonHeight);
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
        }
        
    }
    
    //选择时的指示视图
    _lineView = [[UIView alloc] initWithFrame:CGRectMake((self.buttonWidth-25)/2, 22+10, 25, 4)];
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
        make.top.equalTo(segmentView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
    }];
    [_mainScrollView setBackgroundColor:[UIColor clearColor]];
    
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, SCREEN_HEIGHT-StatusBarSafeTopMargin-64-40-10-TabbarSafeBottomMargin);
    [_mainScrollView setPagingEnabled:YES];

    //不可滑动
    _mainScrollView.scrollEnabled = NO;
    
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
    rect.origin.x = (index - HEADBTN_TAG) * _buttonWidth + (self.buttonWidth-25)/2;
    [UIView animateWithDuration:0.1 animations:^{
        self.lineView.frame = rect;
    }];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _mainScrollView) {
        float xx = scrollView.contentOffset.x * (_buttonWidth / SCREEN_WIDTH) - _buttonWidth;
        [_headerView scrollRectToVisible:CGRectMake(xx, 0, SCREEN_WIDTH, _headerView.frame.size.height) animated:YES];
        NSInteger currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
        [self didSelectSegmentIndex:currentIndex + HEADBTN_TAG];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    float xx = scrollView.contentOffset.x * (_buttonWidth / SCREEN_WIDTH) - _buttonWidth;
    [_headerView scrollRectToVisible:CGRectMake(xx, 0, SCREEN_WIDTH, _headerView.frame.size.height) animated:YES];
}

#pragma mark - 分段选择器相关 begin -
-(void)buildSegmentData
{
    
    NSMutableArray *controlArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < inUseItems.count; i ++) {
        if([inUseItems[i] isEqualToString:@"帖子"]){
            MyCollectionPostVC *postVC = [MyCollectionPostVC new];
            [controlArray addObject:postVC];
            
        }else if([inUseItems[i] isEqualToString:@"预科项目"]){
            MyCollectionPrepareCourseVC *prepareCourseVC = [MyCollectionPrepareCourseVC new];
            [controlArray addObject:prepareCourseVC];
        }
    }
    
    _subViewControllers = controlArray;
    _titleColor = RGBA_GGCOLOR(153, 153, 153, 1.0);         //非选中状态字体颜色
    _titleSelectedColor = RGBA_GGCOLOR(34, 34, 34, 1.0);    //选中状态字体颜色
    _titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];  //非选中状态字体
    _titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Medium" size: 16];  //选中状态字体
    _buttonHeight = 22;                                     //按钮高度
    _buttonWidth = 75;                                      //按钮宽度
}
#pragma mark - 分段选择器相关 end -

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
