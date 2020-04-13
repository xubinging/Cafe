//
//  AcSysRegistService.m
//  Cafe
//
//  Created by leo on 2019/12/12.
//  Copyright © 2019 leo. All rights reserved.
//
//  注册条款

#import "AcSysRegistService.h"

#define K_LINESPACING 2      //行间距

@interface AcSysRegistService ()

{
    @private UIView *navigationView;            //导航
    @private UIButton *backButton;              //左上角返回按钮
    
    
    @private CGFloat textScrollViewHeight;      //ScrollView 内容高度

}

@end

@implementation AcSysRegistService

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self setListener];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    textScrollViewHeight = 0;
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
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, NavBarHeight));
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
    [backButton setBackgroundImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    
    //标题
    UILabel *titleLabel = [UILabel new];
    [navigationView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH - 160)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(160, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"留学咖啡馆注册协议" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:46/255.0 blue:80/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
        
    //分割线
    UIView *splitView = [UIView new];
    [navigationView addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(navigationView).offset(-1);
        make.left.right.equalTo(navigationView);
        make.height.equalTo(@1);
    }];
    splitView.layer.backgroundColor = [UIColor colorWithRed:229/255.0 green:237/255.0 blue:240/255.0 alpha:1.0].CGColor;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //4.文本内容
    //创建ScrollView
    UIScrollView *textScrollView = [UIScrollView new];
    [self.view addSubview:textScrollView];
    [textScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabbarSafeBottomMargin);
    }];
    //设置边缘不弹跳
    textScrollView.bounces = YES;
    
    //***** 副标题：留学咖啡馆注册协议 *****//
    UILabel *subTitleLabel = [UILabel new];
    [textScrollView addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(textScrollView).offset(15);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(144, 22));
    }];
    subTitleLabel.numberOfLines = 0;
    NSMutableAttributedString *subTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"留学咖啡馆注册协议"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    subTitleLabel.attributedText = subTitleLabelString;
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    subTitleLabel.alpha = 1.0;
    
    //行间距是通用的
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = K_LINESPACING;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 15 + 22;
    
    //****************************** 一、总则 ******************************//
    //***** 标题 *****//
    UILabel *generalTitleLabel = [UILabel new];
    [textScrollView addSubview:generalTitleLabel];
    [generalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(subTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(56, 20));
    }];
    generalTitleLabel.numberOfLines = 0;
    NSMutableAttributedString *generalTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"一、总则"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    generalTitleLabel.attributedText = generalTitleLabelString;
    generalTitleLabel.textAlignment = NSTextAlignmentLeft;
    generalTitleLabel.alpha = 1.0;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 10 + 20;
    
    //***** 内容 *****//
    NSMutableString *generalContent = [NSMutableString new];
    [generalContent appendString:@"1.1  用户应当同意本协议的条款并按照页面上的提示完成全部的注册程序。"];
    [generalContent appendString:@"用户在进行注册程序过程中勾选\"我已阅读并接受\"模块即表示用户与产品名称达成协议，完全接受本协议项下的全部条款。\n\n"];
    
    [generalContent appendString:@"1.2  用户注册成功后，产品名称将给予每个用户一个用户帐号及相应的密码，该用户帐号和密码由用户负责保管；"];
    [generalContent appendString:@"用户应当对以其用户帐号进行的所有活动和事件负法律责任。\n\n"];

    [generalContent appendString:@"1.3  用户可以使用产品名称各个频道单项服务，"];
    [generalContent appendString:@"当用户使用产品名称各单项服务时，用户的使用行为视为其对该单项服务的服务条款以及产品名称在该单项服务中发出的各类公告的同意。"];
    
    //设置文本格式
    NSMutableAttributedString *generalContentString = [[NSMutableAttributedString alloc] initWithString:generalContent attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];

    [generalContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(0, 36)];

    [generalContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(36, 55)];

    [generalContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(93, 53)];

    [generalContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(146, 27)];

    [generalContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(175, 24)];

    [generalContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(199, 61)];
    
    //获取富文本高度
    CGFloat generalContentHeight = [generalContentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    UILabel *generalContentLabel = [UILabel new];
    [textScrollView addSubview:generalContentLabel];
    [generalContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(generalTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, generalContentHeight+10));
    }];
    generalContentLabel.numberOfLines = 0;  //值设定为0时，多行显示。
    generalContentLabel.textAlignment = NSTextAlignmentLeft;
    generalContentLabel.alpha = 1.0;
    generalContentLabel.attributedText = generalContentString;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 10 + generalContentHeight+10;
    
    //****************************** 二、注册信息和隐私保护 ******************************//
    //***** 标题 *****//
    UILabel *secretTitleLabel = [UILabel new];
    [textScrollView addSubview:secretTitleLabel];
    [secretTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(generalContentLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(154, 20));
    }];
    secretTitleLabel.numberOfLines = 0;
    NSMutableAttributedString *secretTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"二、注册信息和隐私保护"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    secretTitleLabel.attributedText = secretTitleLabelString;
    secretTitleLabel.textAlignment = NSTextAlignmentLeft;
    secretTitleLabel.alpha = 1.0;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 15 + 20;
    
    //***** 内容 *****//
    NSMutableString *secretContent = [NSMutableString new];
    [secretContent appendString:@"2.1  产品名称帐号（即产品名称用户ID）的所有权归产品名称，用户完成注册申请后，获得产品名称帐号的使用权。所有原始键入的资料将引用为注册资料。"];
    [secretContent appendString:@"如果因注册信息不真实而引起的问题，并对问题发生所带来的后果，产品名称不负任何责任。\n\n"];
    
    [secretContent appendString:@"2.2  用户不应将其帐号、密码转让或出借予他人使用。如用户发现其帐号遭他人非法使用，应立即通知产品名称。"];
    [secretContent appendString:@"因黑客行为或用户的保管疏忽导致帐号、密码遭他人非法使用，产品名称不承担任何责任。\n\n"];

    [secretContent appendString:@"2.3  产品名称不对外公开或向第三方提供单个用户的注册资料，除非：\n"];
    [secretContent appendString:@"• 事先获得用户的明确授权；\n"];
    [secretContent appendString:@"• 只有透露您的个人资料，才能提供您所要求的产品和服务；\n"];
    [secretContent appendString:@"• 根据有关的法律法规要求；\n"];
    [secretContent appendString:@"• 按照相关政府主管部门的要求；\n"];
    [secretContent appendString:@"• 为维护产品名称的合法权益。\n\n"];
    
    [secretContent appendString:@"2.4  在您注册产品名称，使用其他产品名称产品或服务，访问产品名称网页时，产品名称会收集您的个人身份识别资料，"];
    [secretContent appendString:@"并会将这些资料用于：改进为你提供的服务及网页内容。"];
    
    //设置文本格式
    NSMutableAttributedString *secretContentString = [[NSMutableAttributedString alloc] initWithString:secretContent attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];

    [secretContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(0, 73)];

    [secretContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(73, 41)];

    [secretContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(73+41+2, 53)];

    [secretContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(73+41+2+53, 40)];
    
    [secretContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(73+41+2+53+40+2, 34)];
    
    [secretContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]} range:NSMakeRange(73+41+2+53+40+2+34+1, 91)];
    
    [secretContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(73+41+2+53+40+2+34+1+91+2, 81)];
    
    //获取富文本高度
    CGFloat secretContentHeight = [secretContentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    UILabel *secretContentLabel = [UILabel new];
    [textScrollView addSubview:secretContentLabel];
    [secretContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(secretTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, secretContentHeight+10));
    }];
    secretContentLabel.numberOfLines = 0;  //值设定为0时，多行显示。
    secretContentLabel.textAlignment = NSTextAlignmentLeft;
    secretContentLabel.alpha = 1.0;
    secretContentLabel.attributedText = secretContentString;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 10 + secretContentHeight+10;
    
    //****************************** 三、使用规则 ******************************//
    //***** 标题 *****//
    UILabel *ruleTitleLabel = [UILabel new];
    [textScrollView addSubview:ruleTitleLabel];
    [ruleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(secretContentLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(84, 20));
    }];
    ruleTitleLabel.numberOfLines = 0;
    NSMutableAttributedString *ruleTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"三、使用规则"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    ruleTitleLabel.attributedText = ruleTitleLabelString;
    ruleTitleLabel.textAlignment = NSTextAlignmentLeft;
    ruleTitleLabel.alpha = 1.0;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 15 + 20;
    
    //***** 内容 *****//
    NSMutableString *ruleContent = [NSMutableString new];
    
    [ruleContent appendString:@"3.1  用户在使用产品名称服务时，必须遵守中华人民共和国相关法律法规的规定，"];
    [ruleContent appendString:@"用户应同意将不会利用本服务进行任何违法或不正当的活动，包括但不限于下列行为：\n"];
    
    [ruleContent appendString:@"• 上载、展示、张贴、传播或以其它方式传送含有下列内容之一的信息：\n"];
    [ruleContent appendString:@"• 不得为任何非法目的而使用网络服务系统\n"];
    [ruleContent appendString:@"不利用产品名称服务从事以下活动：\n"];
    [ruleContent appendString:@"• 未经允许，进入计算机信息网络或者使用计算机信息网络资源的；\n"];
    [ruleContent appendString:@"• 未经允许，对计算机信息网络功能进行删除、修改或者增加的；\n"];
    [ruleContent appendString:@"• 未经允许，对进入计算机信息网络中存储、处理或者传输的数据和应用程序进行删除、修改或者增加的；\n"];
    [ruleContent appendString:@"• 故意制作、传播计算机病毒等破坏性程序的；\n"];
    [ruleContent appendString:@"• 其他危害计算机信息网络安全的行为。\n\n"];
    
    [ruleContent appendString:@"3.2  用户违反本协议或相关的服务条款的规定，导致或产生的任何第三方主张的任何索赔、要求或损失，"];
    [ruleContent appendString:@"包括合理的律师费，您同意赔偿数据堂与合作公司、关联公司，并使之免受损害。"];
    
    [ruleContent appendString:@"对此，产品名称有权视用户的行为性质，采取包括但不限于删除用户发布信息内容、暂停使用许可、终止服务、限制使用、回收产品名称帐号、追究法律责任等措施。"];
    
    [ruleContent appendString:@"对恶意注册产品名称帐号或利用产品名称帐号进行违法活动、捣乱、骚扰、欺骗、其他用户以及其他违反本协议的行为，产品名称有权回收其帐号。"];
    
    [ruleContent appendString:@"同时，产品名称会视司法部门的要求，协助调查。\n\n"];
    
    [ruleContent appendString:@"3.3  用户不得对本服务任何部分或本服务之使用或获得，进行复制、拷贝、出售、转售或用于任何其它商业目的。\n\n"];
    
    [ruleContent appendString:@"3.4  用户须对自己在使用产品名称服务过程中的行为承担法律责任。用户承担法律责任的形式包括但不限于："];
    
    [ruleContent appendString:@"对受到侵害者进行赔偿，以及在产品名称首先承担了因用户行为导致的行政处罚或侵权损害赔偿责任后，用户应给予产品名称等额的赔偿。"];
    
    //设置文本格式
    NSMutableAttributedString *ruleContentString = [[NSMutableAttributedString alloc] initWithString:ruleContent attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];

    [ruleContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(0, 77)];
    
    [ruleContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]} range:NSMakeRange(77+1, 226)];
    
    [ruleContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(77+1+226+2, 85)];
    
    [ruleContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(77+1+226+2+85, 73)];
    
    [ruleContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(77+1+226+2+85+73, 65)];
    
    [ruleContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(77+1+226+2+85+73+65, 22)];
    
    [ruleContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(77+1+226+2+85+73+65+22+2, 53)];

    [ruleContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(77+1+226+2+85+73+65+22+2+53+2, 51)];
    
    [ruleContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(77+1+226+2+85+73+65+22+2+53+2+51, 61)];
    
    //获取富文本高度
    CGFloat ruleContentHeight = [ruleContentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    UILabel *ruleContentLabel = [UILabel new];
    [textScrollView addSubview:ruleContentLabel];
    [ruleContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(ruleTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, ruleContentHeight+10));
    }];
    ruleContentLabel.numberOfLines = 0;  //值设定为0时，多行显示。
    ruleContentLabel.textAlignment = NSTextAlignmentLeft;
    ruleContentLabel.alpha = 1.0;
    ruleContentLabel.attributedText = ruleContentString;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 10 + ruleContentHeight+10;
    
    //****************************** 四、服务内容 ******************************//
    //***** 标题 *****//
    UILabel *serviceTitleLabel = [UILabel new];
    [textScrollView addSubview:serviceTitleLabel];
    [serviceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(ruleContentLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(84, 20));
    }];
    serviceTitleLabel.numberOfLines = 0;
    NSMutableAttributedString *serviceTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"四、服务内容"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    serviceTitleLabel.attributedText = serviceTitleLabelString;
    serviceTitleLabel.textAlignment = NSTextAlignmentLeft;
    serviceTitleLabel.alpha = 1.0;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 15 + 20;
    
    //***** 内容 *****//
    NSMutableString *serviceContent = [NSMutableString new];
                                    
    [serviceContent appendString:@"4.1  产品名称网络服务的具体内容由产品名称根据实际情况提供。\n\n"];
                                    
    [serviceContent appendString:@"4.2  除非您与产品名称另有约定，您同意本服务仅为您个人非商业性质的使用。\n\n"];
                                    
    [serviceContent appendString:@"4.3  产品名称的部分服务是以收费方式提供的，如您使用收费服务，请遵守相关的协议。\n\n"];
                                    
    [serviceContent appendString:@"4.4  产品名称可能根据实际需要对收费服务的收费标准、方式进行修改和变更，产品名称也可能会对部分免费服务开始收费。"];
    [serviceContent appendString:@"前述修改、变更或开始收费前，产品名称将在相应服务页面进行通知或公告。如果您不同意上述修改、变更或付费内容，则应停止使用该服务。\n\n"];
                                    
    [serviceContent appendString:@"4.5  产品名称网络需要定期或不定期地对提供网络服务的平台或相关的设备进行检修或者维护，如因此类情况而造成网络服务（包括收费网络服务）"];
    [serviceContent appendString:@"在合理时间内的中断，产品名称网络无需为此承担任何责任。产品名称网络保留不经事先通知为维修保养、升级或其它目的暂停本服务任何部分的权利。\n\n"];
                      
    [serviceContent appendString:@"4.6  本服务或第三人可提供与其它国际互联网上之网站或资源之链接。由于产品名称网络无法控制这些网站及资源，您了解并同意"];
    [serviceContent appendString:@"此类网站或资源是否可供利用，产品名称网络不予负责，存在或源于此类网站或资源之任何内容、广告、产品或其它资料，产品名称网络亦不予保证或负责。"];
                                    
    [serviceContent appendString:@"因使用或依赖任何此类网站或资源发布的或经由此类网站或资源获得的任何内容、商品或服务所产生的任何损害或损失，产品名称网络不承担任何责任。\n\n"];
                                    
    [serviceContent appendString:@"4.7  产品名称网络对在服务网上得到的任何商品购物服务、交易进程、招聘信息，都不作担保。\n\n"];
                                    
    [serviceContent appendString:@"4.8  产品名称网络有权于任何时间暂时或永久修改或终止本服务(或其任何部分），而无论其通知与否，产品名称对用户和任何第三人均无需承担任何责任。\n\n"];
    
    [serviceContent appendString:@"4.9　终止服务\n"];
    
    [serviceContent appendString:@"您同意产品名称得基于其自行之考虑，因任何理由，包含但不限于产品名称认为您已经违反本服务协议的文字及精神，"];
    [serviceContent appendString:@"终止您的密码、帐号或本服务之使用（或服务之任何部分），并将您在本服务内任何内容加以移除并删除。"];
    
    [serviceContent appendString:@"您同意依本服务协议任何规定提供之本服务，无需进行事先通知即可中断或终止。"];
    
    [serviceContent appendString:@"您承认并同意，产品名称可立即关闭或删除您的帐号及您帐号中所有相关信息及文件，或禁止继续使用前述文件或本服务。"];
    
    [serviceContent appendString:@"此外，您同意若本服务之使用被中断或终止或您的帐号及相关信息和文件被关闭或删除，产品名称对您或任何第三人均不承担任何责任。"];
                                    
    //设置文本格式
    NSMutableAttributedString *serviceContentString = [[NSMutableAttributedString alloc] initWithString:serviceContent attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];

    [serviceContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(0, 32+2+38+2+42)];
 
    [serviceContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(32+2+38+2+42+2, 58)];
    
    [serviceContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(32+2+38+2+42+2+58, 63+2+135+2+129)];
    
    [serviceContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(32+2+38+2+42+2+58+63+2+135+2+129, 67+2+45)];
    
    [serviceContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(32+2+38+2+42+2+58+63+2+135+2+129+67+2+45, 72+2+8+1+99)];
    
    [serviceContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(32+2+38+2+42+2+58+63+2+135+2+129+67+2+45+72+2+8+1+99, 36)];
    
    [serviceContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(32+2+38+2+42+2+58+63+2+135+2+129+67+2+45+72+2+8+1+99+36,54)];
    
    [serviceContentString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]} range:NSMakeRange(32+2+38+2+42+2+58+63+2+135+2+129+67+2+45+72+2+8+1+99+36+54,60)];
    
    //获取富文本高度
    CGFloat serviceContentHeight = [serviceContentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    UILabel *serviceContentLabel = [UILabel new];
    [textScrollView addSubview:serviceContentLabel];
    [serviceContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(serviceTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, serviceContentHeight+10));
    }];
    serviceContentLabel.numberOfLines = 0;  //值设定为0时，多行显示。
    serviceContentLabel.textAlignment = NSTextAlignmentLeft;
    serviceContentLabel.alpha = 1.0;
    serviceContentLabel.attributedText = serviceContentString;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 10 + serviceContentHeight+10;
    
    //****************************** 五、知识产权和其他合法权益（包括但不限于名誉权、商誉权） ******************************//
       //***** 标题 *****//
    NSMutableAttributedString *knowledgeTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"五、知识产权和其他合法权益（包括但不限于名誉权、商誉权）"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    CGFloat knowledgeTitleLabelStringHeight = [knowledgeTitleLabelString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    UILabel *knowledgeTitleLabel = [UILabel new];
    [textScrollView addSubview:knowledgeTitleLabel];
    [knowledgeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(serviceContentLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, knowledgeTitleLabelStringHeight));
    }];
    knowledgeTitleLabel.numberOfLines = 0;
    knowledgeTitleLabel.attributedText = knowledgeTitleLabelString;
    knowledgeTitleLabel.textAlignment = NSTextAlignmentLeft;
    knowledgeTitleLabel.alpha = 1.0;
      
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 15 + knowledgeTitleLabelStringHeight;
       
    //***** 内容 *****//
    NSMutableString *knowledgeContent = [NSMutableString new];

    [knowledgeContent appendString:@"5.1  产品名称在本服务中提供的内容（包括但不限于网页、文字、图片、音频、视频、图表等）的知识产权归产品名称所有，"];
    [knowledgeContent appendString:@"用户在使用本服务中所产生的内容的知识产权归用户或相关权利人所有。\n\n"];
    
    [knowledgeContent appendString:@"5.2  除另有特别声明外，产品名称提供本服务时所依托软件的著作权、专利权及其他知识产权均归产品名称所有。\n\n"];
    
    [knowledgeContent appendString:@"5.3  产品名称在本服务中所使用的“产品名称”等商业标识，其著作权或商标权归产品名称所有。\n\n"];
    
    [knowledgeContent appendString:@"5.4  上述及其他任何本服务包含的内容的知识产权均受到法律保护,未经产品名称、用户或相关权利人书面许可，"];
    [knowledgeContent appendString:@"任何人不得以任何形式进行使用或创造相关衍生作品。"];
                                       
    //设置文本格式
    NSMutableAttributedString *knowledgeContentString = [[NSMutableAttributedString alloc] initWithString:knowledgeContent attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];
       
    //获取富文本高度
    CGFloat knowledgeContentHeight = [knowledgeContentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    UILabel *knowledgeContentLabel = [UILabel new];
    [textScrollView addSubview:knowledgeContentLabel];
    [knowledgeContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(knowledgeTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, knowledgeContentHeight+10));
    }];
    knowledgeContentLabel.numberOfLines = 0;  //值设定为0时，多行显示。
    knowledgeContentLabel.textAlignment = NSTextAlignmentLeft;
    knowledgeContentLabel.alpha = 1.0;
    knowledgeContentLabel.attributedText = knowledgeContentString;
   
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 10 + knowledgeContentHeight+10;
    
    //****************************** 六、未成年人使用条款 ******************************//
    //***** 标题 *****//
    NSMutableAttributedString *less18TitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"六、未成年人使用条款"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

    UILabel *less18TitleLabel = [UILabel new];
    [textScrollView addSubview:less18TitleLabel];
    [less18TitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(knowledgeContentLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(140, 20));
    }];
    less18TitleLabel.numberOfLines = 0;
    less18TitleLabel.attributedText = less18TitleLabelString;
    less18TitleLabel.textAlignment = NSTextAlignmentLeft;
    less18TitleLabel.alpha = 1.0;
       
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 15 + 20;
        
    //***** 内容 *****//
    NSMutableString *less18Content = [NSMutableString new];
    
    [less18Content appendString:@"6.1  若用户未满18周岁，则为未成年人，应在监护人监护、指导下阅读本协议和使用本服务。\n\n"];
    
    [less18Content appendString:@"6.2  未成年人用户涉世未深，容易被网络虚象迷惑，且好奇心强，遇事缺乏随机应变的处理能力，"];
    [less18Content appendString:@"很容易被别有用心的人利用而又缺乏自我保护能力。因此，未成年人用户在使用本服务时应注意以下事项，提高安全意识，加强自我保护：\n"];
    
    [less18Content appendString:@"（1）认清网络世界与现实世界的区别，避免沉迷于网络，影响日常的学习生活；\n"];
    [less18Content appendString:@"（2）填写个人资料时，加强个人保护意识，以免不良分子对个人生活造成骚扰；\n"];
    [less18Content appendString:@"（3）在监护人或老师的指导下，学习正确使用网络；\n"];
    [less18Content appendString:@"（4）避免陌生网友随意会面或参与联谊活动，以免不法分子有机可乘，危及自身安全。"];

    //设置文本格式
    NSMutableAttributedString *less18ContentString = [[NSMutableAttributedString alloc] initWithString:less18Content attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];
    
    [less18ContentString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]} range:NSMakeRange(155, [less18Content length]-155)];
        
    //获取富文本高度
    CGFloat less18ContentHeight = [less18ContentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    UILabel *less18ContentLabel = [UILabel new];
    [textScrollView addSubview:less18ContentLabel];
    [less18ContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(less18TitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, less18ContentHeight+10));
    }];
    less18ContentLabel.numberOfLines = 0;  //值设定为0时，多行显示。
    less18ContentLabel.textAlignment = NSTextAlignmentLeft;
    less18ContentLabel.alpha = 1.0;
    less18ContentLabel.attributedText = less18ContentString;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 10 + less18ContentHeight+10;
    
    //****************************** 七、其他 ******************************//
    //***** 标题 *****//
    NSMutableAttributedString *otherTitleLabelString = [[NSMutableAttributedString alloc] initWithString:@"七、其他"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

    UILabel *otherTitleLabel = [UILabel new];
    [textScrollView addSubview:otherTitleLabel];
    [otherTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(less18ContentLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(56, 20));
    }];
    otherTitleLabel.numberOfLines = 0;
    otherTitleLabel.attributedText = otherTitleLabelString;
    otherTitleLabel.textAlignment = NSTextAlignmentLeft;
    otherTitleLabel.alpha = 1.0;
       
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 15 + 20;
        
    //***** 内容 *****//
    NSMutableString *otherContent = [NSMutableString new];
    
    [otherContent appendString:@"7.1  本协议的订立、执行和解释及争议的解决均应适用中华人民共和国法律。\n\n"];
    
    [otherContent appendString:@"7.2  如双方就本协议内容或其执行发生任何争议，双方应尽量友好协商解决；协商不成时，任何一方均可向产品名称所在地的人民法院提起诉讼。\n\n"];
    
    [otherContent appendString:@"7.3  产品名称未行使或执行本服务协议任何权利或规定，不构成对前述权利或权利之放弃。\n\n"];
    
    [otherContent appendString:@"7.4  如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，本协议的其余条款仍应有效并且有约束力。\n\n"];
    
    [otherContent appendString:@"请您在发现任何违反本服务协议以及其他任何单项服务的服务条款、产品名称各类公告之情形时，通知产品名称。"];
    
    //设置文本格式
    NSMutableAttributedString *otherContentString = [[NSMutableAttributedString alloc] initWithString:otherContent attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0], NSParagraphStyleAttributeName:paragraphStyle}];
        
    //获取富文本高度
    CGFloat otherContentHeight = [otherContentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    UILabel *otherContentLabel = [UILabel new];
    [textScrollView addSubview:otherContentLabel];
    [otherContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(otherTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, otherContentHeight+10));
    }];
    otherContentLabel.numberOfLines = 0;  //值设定为0时，多行显示。
    otherContentLabel.textAlignment = NSTextAlignmentLeft;
    otherContentLabel.alpha = 1.0;
    otherContentLabel.attributedText = otherContentString;
    
    //textScrollViewHeight叠加
    textScrollViewHeight = textScrollViewHeight + 10 + otherContentHeight+10;
    
    //设置scrollview内容尺寸
    textScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, textScrollViewHeight+15);
    
}

#pragma mark - 设置控件监听事件 -
-(void)setListener
{
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
