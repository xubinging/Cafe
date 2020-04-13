//
//  MineOfferDetailViewController.m
//  Cafe
//
//  Created by leo on 2020/1/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import "MineOfferDetailViewController.h"

#import "MineOfferModel.h"

#import "MineDetailCommonModel.h"           //信息列表
#import "MineDetailCommonTableViewCell.h"

#import "MineOfferScoreModel.h"             //分数列表
#import "MineOfferScoreTableViewCell.h"

#define K_DetailTableView_Tag   10000
#define K_ScoreTableView_Tag    20000
#define K_DetailTableView_CellHeight    48
#define K_ScoreTableView_CellHeight     114

@interface MineOfferDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    @private UIButton *rightButton;         //右侧按钮
    
    @private UIScrollView *contentView;     //内容
    
    @private UILabel *GPALabel;             //平均分标签
    @private UITextView *contentTextView;
    
    @private MineOfferModel *slctModel;
}

@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) NSArray *detailArray;

@property (nonatomic,strong) UITableView *scoreTableView;
@property (nonatomic,strong) NSArray *scoreArray;

@end

@implementation MineOfferDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initVars];
    [self initSharedPreferences];
    [self getParentVars];
    [self initNavigationView];
    [self initView];
    [self setData];
    [self resetSize];
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

#pragma mark - 获取父页面参数 -
-(void)getParentVars
{
    if(_dataDic != nil){
        slctModel = _dataDic[@"slctModel"];
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
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    NSMutableAttributedString *rightButtonString = [[NSMutableAttributedString alloc] initWithString:@"编辑" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0]}];
    [rightButton setAttributedTitle:rightButtonString forState:UIControlStateNormal];
    //右上角按钮点击
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
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //内容视图
    contentView = [UIScrollView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
    }];
    [contentView setBackgroundColor:[UIColor clearColor]];
    contentView.showsVerticalScrollIndicator = NO;
    
    //列表
    _detailTableView = [UITableView new];
    [contentView addSubview:_detailTableView];
    _detailTableView.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 6*K_DetailTableView_CellHeight);
    
    _detailTableView.tag = K_DetailTableView_Tag;
    _detailTableView.bounces = NO;
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_detailTableView registerClass:[MineDetailCommonTableViewCell class] forCellReuseIdentifier:@"MineDetailCommonTableViewCell"];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _detailTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _detailTableView.showsVerticalScrollIndicator = NO;
    
    _detailTableView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    _detailTableView.layer.cornerRadius = 10;
    _detailTableView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    _detailTableView.layer.shadowOffset = CGSizeMake(0,0);
    _detailTableView.layer.shadowOpacity = 1;
    _detailTableView.layer.shadowRadius = 10;
    
    //GPA视图
    UIView *gpaView = [UIView new];
    [contentView addSubview:gpaView];
    [gpaView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_detailTableView.mas_bottom).offset(10);
        make.left.equalTo(_detailTableView);
        make.right.equalTo(_detailTableView);
        make.height.mas_equalTo(@(42));
    }];
    gpaView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    gpaView.layer.cornerRadius = 10;
    gpaView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    gpaView.layer.shadowOffset = CGSizeMake(0,0);
    gpaView.layer.shadowOpacity = 1;
    gpaView.layer.shadowRadius = 10;
    
    //左侧的背景
    UIView *leftBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, 3, 18)];
    [gpaView addSubview:leftBackView];
    
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = leftBackView.bounds;
    gl.startPoint = CGPointMake(-0.17, -0.17);
    gl.endPoint = CGPointMake(1.17, 0.83);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:154/255.0 blue:66/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [leftBackView.layer addSublayer:gl];

    //设置右上角和右下角为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:leftBackView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.5, 5.5)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc] init];
    cornerRadiusLayer.frame = leftBackView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    leftBackView.layer.mask = cornerRadiusLayer;
    
    UILabel *gpaTitleLabel = [UILabel new];
    [gpaView addSubview:gpaTitleLabel];
    [gpaTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(gpaView).offset(10);
        make.left.equalTo(gpaView).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 22));
    }];
    gpaTitleLabel.numberOfLines = 0;
    gpaTitleLabel.textAlignment = NSTextAlignmentLeft;
    gpaTitleLabel.alpha = 1.0;
    NSMutableAttributedString *gpaTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"GPA:"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]}];
    gpaTitleLabel.attributedText = gpaTitleLabelString;
    
    GPALabel = [UILabel new];
    [gpaView addSubview:GPALabel];
    [GPALabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(gpaView).offset(7);
        make.left.equalTo(gpaTitleLabel.mas_right).offset(10);
        make.right.equalTo(gpaView).offset(-15);
        make.height.mas_equalTo(@28);
    }];
    GPALabel.numberOfLines = 0;
    GPALabel.textAlignment = NSTextAlignmentLeft;
    GPALabel.alpha = 1.0;
    [GPALabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:20]];
    [GPALabel setTextColor:[UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0]];
    
    //分数列表
    _scoreTableView = [UITableView new];
    [contentView addSubview:_scoreTableView];
    [_scoreTableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(gpaView.mas_bottom);
        make.left.equalTo(gpaView);
        make.right.equalTo(gpaView);
        make.height.mas_equalTo(@(0));
    }];
    [_scoreTableView setBackgroundColor:[UIColor clearColor]];
    
    _scoreTableView.tag = K_ScoreTableView_Tag;
    _scoreTableView.bounces = NO;
    _scoreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scoreTableView registerClass:[MineOfferScoreTableViewCell class] forCellReuseIdentifier:@"MineOfferScoreTableViewCell"];
    _scoreTableView.delegate = self;
    _scoreTableView.dataSource = self;
    //这句话可以设置tableview没有数据时不显示横线
    _scoreTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _scoreTableView.showsVerticalScrollIndicator = NO;
    _scoreTableView.layer.cornerRadius = 10;
    
    
    //内容视图
    UIView *contentTextViewParent = [UIView new];
    [contentView addSubview:contentTextViewParent];
    [contentTextViewParent mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_scoreTableView.mas_bottom).offset(10);
        make.left.equalTo(gpaView).offset(-10);
        make.right.equalTo(gpaView).offset(10);
        make.height.mas_equalTo(@(200));
    }];
    [contentTextViewParent setBackgroundColor:[UIColor whiteColor]];

    //内容
    contentTextView = [UITextView new];
    [contentTextViewParent addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentTextViewParent).offset(15);
        make.left.equalTo(contentTextViewParent).offset(10);
        make.right.equalTo(contentTextViewParent).offset(-10);
        make.bottom.equalTo(contentTextViewParent).offset(-10);
    }];
    contentTextView.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0].CGColor;
    contentTextView.layer.cornerRadius = 8;
    contentTextView.editable = NO;
    
}

#pragma mark - 设置参数 -
-(void)setData
{
    //detail
    _detailArray = nil;
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSString *country = slctModel.country;
    NSString *school = slctModel.school;
    NSString *stage = slctModel.stage;
    NSString *major = slctModel.major;
    NSString *agentCompany = slctModel.agentCompany;
    NSString *internationalSchool = slctModel.internationalSchool;
    
    NSString *showLanguage = slctModel.showLanguage;
    
    for(int i=0; i<6; i++){
        if(i==0){
            NSString *title = @"国家:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Country:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":country
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==1){
            NSString *title = @"学校名称(英文):";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"School Name(EN):";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":school
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==2){
            NSString *title = @"就读阶段:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Study Stage:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":stage
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==3){
            NSString *title = @"专业:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"major:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":major
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==4){
            NSString *title = @"代办留学公司:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"Agent Company:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":agentCompany
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }else if(i==5){
            NSString *title = @"就读国际学校:";
            if([showLanguage isEqualToString:@"EN"]){
                title = @"International School:";
            }
            
            NSDictionary *dic = @{
                @"title":title,
                @"content":internationalSchool
            };
            MineDetailCommonModel *model = [MineDetailCommonModel modelWithDict:dic];
            [tempArray addObject:model];
            
        }
    }
    _detailArray = [tempArray copy];
    
    
    //score
    NSDictionary *TOEFLDic = slctModel.TOEFLDic;
    NSDictionary *IELTSDic = slctModel.IELTSDic;
    NSDictionary *GREDic = slctModel.GREDic;
    NSDictionary *GMATDic = slctModel.GMATDic;
    NSDictionary *SATDic = slctModel.SATDic;
    NSDictionary *ACTDic = slctModel.ACTDic;
    
    _scoreArray = nil;
    NSMutableArray *tempScoreArray = [NSMutableArray array];
    
    //TOEFL
    if(TOEFLDic != nil){
        NSString *scoreType = @"";            //分数类别
        NSString *totalScoreTitle = @"";      //总分
        NSString *totalScore = @"";
        NSString *scoreOneTitle = @"";        //分数一
        NSString *scoreOne = @"";
        NSString *scoreTwoTitle = @"";        //分数二
        NSString *scoreTwo = @"";
        NSString *scoreThreeTitle = @"";      //分数三
        NSString *scoreThree = @"";
        NSString *scoreFourTitle = @"";       //分数四
        NSString *scoreFour = @"";
        
        scoreType = @"TOEFL";
        if(TOEFLDic[@"总分"] != nil){
            totalScoreTitle = @"总分";
            totalScore = TOEFLDic[@"总分"];
        }
        
        if(TOEFLDic[@"L"] != nil){
            scoreOneTitle = @"L";
            scoreOne = TOEFLDic[@"L"];
        }
        
        if(TOEFLDic[@"S"] != nil){
            scoreTwoTitle = @"S";
            scoreTwo = TOEFLDic[@"S"];
        }
        
        if(TOEFLDic[@"R"] != nil){
            scoreThreeTitle = @"R";
            scoreThree = TOEFLDic[@"R"];
        }
        
        if(TOEFLDic[@"W"] != nil){
            scoreFourTitle = @"W";
            scoreFour = TOEFLDic[@"W"];
        }
        
        NSDictionary *dic = @{
            @"scoreType":scoreType,
            @"totalScoreTitle":totalScoreTitle,
            @"totalScore":totalScore,
            @"scoreOneTitle":scoreOneTitle,
            @"scoreOne":scoreOne,
            @"scoreTwoTitle":scoreTwoTitle,
            @"scoreTwo":scoreTwo,
            @"scoreThreeTitle":scoreThreeTitle,
            @"scoreThree":scoreThree,
            @"scoreFourTitle":scoreFourTitle,
            @"scoreFour":scoreFour
        };
        MineOfferScoreModel *model = [MineOfferScoreModel modelWithDict:dic];
        [tempScoreArray addObject:model];
    }
    
    //IELTS
    if(IELTSDic != nil){
        NSString *scoreType = @"";            //分数类别
        NSString *totalScoreTitle = @"";      //总分
        NSString *totalScore = @"";
        NSString *scoreOneTitle = @"";        //分数一
        NSString *scoreOne = @"";
        NSString *scoreTwoTitle = @"";        //分数二
        NSString *scoreTwo = @"";
        NSString *scoreThreeTitle = @"";      //分数三
        NSString *scoreThree = @"";
        NSString *scoreFourTitle = @"";       //分数四
        NSString *scoreFour = @"";
        
        scoreType = @"IELTS";
        if(IELTSDic[@"总分"] != nil){
            totalScoreTitle = @"总分";
            totalScore = IELTSDic[@"总分"];
        }
        
        if(IELTSDic[@"L"] != nil){
            scoreOneTitle = @"L";
            scoreOne = IELTSDic[@"L"];
        }
        
        if(IELTSDic[@"S"] != nil){
            scoreTwoTitle = @"S";
            scoreTwo = IELTSDic[@"S"];
        }
        
        if(IELTSDic[@"R"] != nil){
            scoreThreeTitle = @"R";
            scoreThree = IELTSDic[@"R"];
        }
        
        if(IELTSDic[@"W"] != nil){
            scoreFourTitle = @"W";
            scoreFour = IELTSDic[@"W"];
        }
        
        NSDictionary *dic = @{
            @"scoreType":scoreType,
            @"totalScoreTitle":totalScoreTitle,
            @"totalScore":totalScore,
            @"scoreOneTitle":scoreOneTitle,
            @"scoreOne":scoreOne,
            @"scoreTwoTitle":scoreTwoTitle,
            @"scoreTwo":scoreTwo,
            @"scoreThreeTitle":scoreThreeTitle,
            @"scoreThree":scoreThree,
            @"scoreFourTitle":scoreFourTitle,
            @"scoreFour":scoreFour
        };
        MineOfferScoreModel *model = [MineOfferScoreModel modelWithDict:dic];
        [tempScoreArray addObject:model];
    }
    
    //GRE
    if(GREDic != nil){
        NSString *scoreType = @"";            //分数类别
        NSString *totalScoreTitle = @"";      //总分
        NSString *totalScore = @"";
        NSString *scoreOneTitle = @"";        //分数一
        NSString *scoreOne = @"";
        NSString *scoreTwoTitle = @"";        //分数二
        NSString *scoreTwo = @"";
        NSString *scoreThreeTitle = @"";      //分数三
        NSString *scoreThree = @"";
        NSString *scoreFourTitle = @"";       //分数四
        NSString *scoreFour = @"";
        
        scoreType = @"GRE";
        if(GREDic[@"总分"] != nil){
            totalScoreTitle = @"总分";
            totalScore = GREDic[@"总分"];
        }
        
        if(GREDic[@"L"] != nil){
            scoreOneTitle = @"L";
            scoreOne = GREDic[@"L"];
        }
        
        if(GREDic[@"Q"] != nil){
            scoreTwoTitle = @"Q";
            scoreTwo = GREDic[@"Q"];
        }
        
        if(GREDic[@"AW"] != nil){
            scoreThreeTitle = @"AW";
            scoreThree = GREDic[@"AW"];
        }
        
        NSDictionary *dic = @{
            @"scoreType":scoreType,
            @"totalScoreTitle":totalScoreTitle,
            @"totalScore":totalScore,
            @"scoreOneTitle":scoreOneTitle,
            @"scoreOne":scoreOne,
            @"scoreTwoTitle":scoreTwoTitle,
            @"scoreTwo":scoreTwo,
            @"scoreThreeTitle":scoreThreeTitle,
            @"scoreThree":scoreThree,
            @"scoreFourTitle":scoreFourTitle,
            @"scoreFour":scoreFour
        };
        MineOfferScoreModel *model = [MineOfferScoreModel modelWithDict:dic];
        [tempScoreArray addObject:model];
    }
    
    //GMAT
    if(GMATDic != nil){
        NSString *scoreType = @"";            //分数类别
        NSString *totalScoreTitle = @"";      //总分
        NSString *totalScore = @"";
        NSString *scoreOneTitle = @"";        //分数一
        NSString *scoreOne = @"";
        NSString *scoreTwoTitle = @"";        //分数二
        NSString *scoreTwo = @"";
        NSString *scoreThreeTitle = @"";      //分数三
        NSString *scoreThree = @"";
        NSString *scoreFourTitle = @"";       //分数四
        NSString *scoreFour = @"";
        
        scoreType = @"GMAT";
        if(GMATDic[@"总分"] != nil){
            totalScoreTitle = @"总分";
            totalScore = GMATDic[@"总分"];
        }
        
        if(GMATDic[@"V"] != nil){
            scoreOneTitle = @"V";
            scoreOne = GMATDic[@"V"];
        }
        
        if(GMATDic[@"Q"] != nil){
            scoreTwoTitle = @"Q";
            scoreTwo = GMATDic[@"Q"];
        }
        
        if(GMATDic[@"AW"] != nil){
            scoreThreeTitle = @"AW";
            scoreThree = GMATDic[@"AW"];
        }
        
        if(GMATDic[@"IR"] != nil){
            scoreFourTitle = @"IR";
            scoreFour = GMATDic[@"IR"];
        }
        
        NSDictionary *dic = @{
            @"scoreType":scoreType,
            @"totalScoreTitle":totalScoreTitle,
            @"totalScore":totalScore,
            @"scoreOneTitle":scoreOneTitle,
            @"scoreOne":scoreOne,
            @"scoreTwoTitle":scoreTwoTitle,
            @"scoreTwo":scoreTwo,
            @"scoreThreeTitle":scoreThreeTitle,
            @"scoreThree":scoreThree,
            @"scoreFourTitle":scoreFourTitle,
            @"scoreFour":scoreFour
        };
        MineOfferScoreModel *model = [MineOfferScoreModel modelWithDict:dic];
        [tempScoreArray addObject:model];
    }
    
    //SAT
    if(SATDic != nil){
        NSString *scoreType = @"";            //分数类别
        NSString *totalScoreTitle = @"";      //总分
        NSString *totalScore = @"";
        NSString *scoreOneTitle = @"";        //分数一
        NSString *scoreOne = @"";
        NSString *scoreTwoTitle = @"";        //分数二
        NSString *scoreTwo = @"";
        NSString *scoreThreeTitle = @"";      //分数三
        NSString *scoreThree = @"";
        NSString *scoreFourTitle = @"";       //分数四
        NSString *scoreFour = @"";
        
        scoreType = @"SAT";
        if(SATDic[@"总分"] != nil){
            totalScoreTitle = @"总分";
            totalScore = SATDic[@"总分"];
        }
        
        if(SATDic[@"EBRW"] != nil){
            scoreOneTitle = @"EBRW";
            scoreOne = SATDic[@"EBRW"];
        }
        
        if(SATDic[@"M"] != nil){
            scoreTwoTitle = @"M";
            scoreTwo = SATDic[@"M"];
        }
        
        if(SATDic[@"ER"] != nil){
            scoreThreeTitle = @"ER";
            scoreThree = SATDic[@"ER"];
        }
        
        if(SATDic[@"EA"] != nil){
            scoreFourTitle = @"EA";
            scoreFour = SATDic[@"EA"];
        }
        
        NSDictionary *dic = @{
            @"scoreType":scoreType,
            @"totalScoreTitle":totalScoreTitle,
            @"totalScore":totalScore,
            @"scoreOneTitle":scoreOneTitle,
            @"scoreOne":scoreOne,
            @"scoreTwoTitle":scoreTwoTitle,
            @"scoreTwo":scoreTwo,
            @"scoreThreeTitle":scoreThreeTitle,
            @"scoreThree":scoreThree,
            @"scoreFourTitle":scoreFourTitle,
            @"scoreFour":scoreFour
        };
        MineOfferScoreModel *model = [MineOfferScoreModel modelWithDict:dic];
        [tempScoreArray addObject:model];
    }
    
    //ACT
    if(ACTDic != nil){
        NSString *scoreType = @"";            //分数类别
        NSString *totalScoreTitle = @"";      //总分
        NSString *totalScore = @"";
        NSString *scoreOneTitle = @"";        //分数一
        NSString *scoreOne = @"";
        NSString *scoreTwoTitle = @"";        //分数二
        NSString *scoreTwo = @"";
        NSString *scoreThreeTitle = @"";      //分数三
        NSString *scoreThree = @"";
        NSString *scoreFourTitle = @"";       //分数四
        NSString *scoreFour = @"";
        
        scoreType = @"ACT";
        if(ACTDic[@"总分"] != nil){
            totalScoreTitle = @"总分";
            totalScore = ACTDic[@"总分"];
        }
        
        if(ACTDic[@"R"] != nil){
            scoreOneTitle = @"R";
            scoreOne = ACTDic[@"R"];
        }
        
        if(ACTDic[@"E"] != nil){
            scoreTwoTitle = @"E";
            scoreTwo = ACTDic[@"E"];
        }
        
        if(ACTDic[@"M"] != nil){
            scoreThreeTitle = @"M";
            scoreThree = ACTDic[@"M"];
        }
        
        if(ACTDic[@"S"] != nil){
            scoreFourTitle = @"S";
            scoreFour = ACTDic[@"S"];
        }
        
        NSDictionary *dic = @{
            @"scoreType":scoreType,
            @"totalScoreTitle":totalScoreTitle,
            @"totalScore":totalScore,
            @"scoreOneTitle":scoreOneTitle,
            @"scoreOne":scoreOne,
            @"scoreTwoTitle":scoreTwoTitle,
            @"scoreTwo":scoreTwo,
            @"scoreThreeTitle":scoreThreeTitle,
            @"scoreThree":scoreThree,
            @"scoreFourTitle":scoreFourTitle,
            @"scoreFour":scoreFour
        };
        MineOfferScoreModel *model = [MineOfferScoreModel modelWithDict:dic];
        [tempScoreArray addObject:model];
    }
    
    _scoreArray = [tempScoreArray copy];
    [self.scoreTableView reloadData];
    
    //GPA数据
    NSString *gpa = slctModel.gpa;
    [GPALabel setText:gpa];

    //content
    NSString *content = slctModel.content;
    if(![content isEqualToString:@""] && content != nil){
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:content attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        [contentTextView setAttributedText:string];

    }else{
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"您可以在这里输入内容…"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:203/255.0 green:207/255.0 blue:217/255.0 alpha:1.0]}];
        [contentTextView setAttributedText:string];

    }
    
}

-(void)resetSize
{
    CGFloat scoreTableViewHeight = 0;
    if(self.scoreArray.count != 0){
        scoreTableViewHeight = K_ScoreTableView_CellHeight*self.scoreArray.count + 10*self.scoreArray.count;
    }
    
    [_scoreTableView mas_updateConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(@(scoreTableViewHeight));
    }];
    
    //设置内容视图尺寸
    [contentView setContentSize:CGSizeMake(SCREEN_WIDTH, 10 + 6*K_DetailTableView_CellHeight + 10 + 42 + scoreTableViewHeight + 10 + 200)];
    
}

//**********    tableView代理 begin   **********//
#pragma mark - 设置cell行高 -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == K_DetailTableView_Tag){
        return K_DetailTableView_CellHeight;
        
    }else if(tableView.tag == K_ScoreTableView_Tag){
        return K_ScoreTableView_CellHeight;
    }
    
    return 0;
}

#pragma mark - 设置section数量 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag == K_DetailTableView_Tag){
        return 1;
        
    }else if(tableView.tag == K_ScoreTableView_Tag){
        return self.scoreArray.count;
    }
    
    return 0;
}

#pragma mark - 设置每个section中row的数量 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == K_DetailTableView_Tag){
        return self.detailArray.count;
        
    }else if(tableView.tag == K_ScoreTableView_Tag){
        return 1;
    }
    
    return 0;
}

#pragma mark - 获取cell -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(tableView.tag == K_DetailTableView_Tag){
        MineDetailCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineDetailCommonTableViewCell"];

        //更新cell
        [cell updateCellWithModel:self.detailArray[indexPath.row]];

        return cell;
        
    }else if(tableView.tag == K_ScoreTableView_Tag){
        MineOfferScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineOfferScoreTableViewCell"];

        //更新cell
        [cell updateCellWithModel:self.scoreArray[indexPath.section]];

        return cell;
        
    }
    
    return  nil;

}

#pragma mark - 设置header高度 -
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == K_ScoreTableView_Tag){
        return 10;
    }
    
    return 0;
}

#pragma mark - 设置header样式 -
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == K_ScoreTableView_Tag){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
        
    }
    
    return nil;
}

#pragma mark - 点击cell -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//**********    tableView代理 end   **********//

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    //设置回调
    NSDictionary *sendDataDic = @{
        @"modelReturn":slctModel
    };
    
    //Block传值step 3:传值类将要传的值传入自己的block中
    self.sendValueBlock(sendDataDic);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 编辑按钮点击 -
-(void)rightButtonClick
{
//    NSDictionary *sendDic = @{
//        @"type":type,
//        @"date":date,
//        @"location":location,
//        @"org":org,
//        @"resultL":resultL,
//        @"resultS":resultS,
//        @"resultR":resultR,
//        @"resultW":resultW,
//        @"resultScore":resultScore
//    };
//
//    MineResultShowViewController *showVC = [MineResultShowViewController new];
//
//    //设置block回调
//    [showVC setSendValueBlock:^(NSDictionary *valueDict){
//
//        //回调函数
//        self->type = valueDict[@"type"];
//        self->date = valueDict[@"date"];
//        self->location = valueDict[@"location"];
//        self->org = valueDict[@"org"];
//        self->resultL = valueDict[@"resultL"];
//        self->resultS = valueDict[@"resultS"];
//        self->resultR = valueDict[@"resultR"];
//        self->resultW = valueDict[@"resultW"];
//        self->resultScore = valueDict[@"resultScore"];
//
//        [self setData];
//
//    }];
//
//    showVC.dataDic = sendDic;
//
//    [self.navigationController pushViewController:showVC animated:YES];
}

@end
