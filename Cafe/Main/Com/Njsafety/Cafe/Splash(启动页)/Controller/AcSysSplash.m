//
//  AcSysSplash.m
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//
//  启动页

#import "AcSysSplash.h"

#import "AcSysLogin.h"                  //登录注册页

#import "MainTabBarViewController.h"    //底部导航布局

#define KTime 1     //倒计时时间，实际时间：KTime+1

@interface AcSysSplash ()

{
    @private AvalonsoftUserDefaultsModel *avalonsoftUserDefaultsModel;
    @private BOOL isShowWelcome;    //是否显示欢迎页
}

@property (nonatomic, strong) NSTimer *myTimer; //定时器
@property (nonatomic, assign) int countTime;    //倒计时时间
@property (nonatomic, strong) UIImageView *splashImageView; //启动页视图

@end

@implementation AcSysSplash

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initView];
    [self setImage];    //设置图片，同时启动定时器
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    _countTime = KTime;
}

#pragma mark - 初始化数据 -
-(void)initSharedPreferences
{
    @try {
        
        //获取公共信息--是否显示欢迎页
        avalonsoftUserDefaultsModel = [AvalonsoftUserDefaultsModel userDefaultsModel];
        
        isShowWelcome = avalonsoftUserDefaultsModel.isShowWelcome;
        
    } @catch (NSException *exception) {
        @throw exception;
        
    }
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //启动图片
    _splashImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _splashImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_splashImageView setBackgroundColor:RGBA_GGCOLOR(243, 241, 242, 1)];
    
    [self.view addSubview:_splashImageView];
}

#pragma mark - 设置图片 -
-(void)setImage
{
    [_splashImageView setImage:[UIImage imageNamed:@"splash"]];
    
    [self initTimer];
}
    
#pragma mark - 初始化定时器 -
-(void)initTimer
{
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myTimerSelector) userInfo:nil repeats:YES];
}

#pragma mark - 定时器方法 -
-(void)myTimerSelector
{
    if (_countTime == 0) {
        //倒计时结束
        [_myTimer invalidate];
        _myTimer = nil;
                
        //是否显示欢迎页
        if(![_F isStringNotEmptyOrNil:_UserInfo.accountId]){
            //本地的 isShowWelcome 为YES，那么就连接数据库，看看是否有数据
            //如果有，就跳过欢迎页；如果没有，就跳到欢迎页
            //这么做的目的，是防止安装后又卸载。根据本地保存的 isShowWelcome 来判断，可以保证只有第一次安装时访问后台
            
            AcSysLogin *login = [[AcSysLogin alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            
        }else{
            //跳转到首页
            MainTabBarViewController *mainTabBarViewController = [[MainTabBarViewController alloc] init];
            [self.navigationController pushViewController:mainTabBarViewController animated:YES];
        }
        
    }else{
        //倒计时未结束，每次递减1s
        _countTime--;
    }
}

#pragma mark - 隐藏状态栏 -
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 网络请求发起 -
-(void)getGuideData
{
    [AvalonsoftHasNetwork avalonsoft_hasNetwork:^(bool hasNet){
        if(hasNet){
            //有网
            NSMutableDictionary *root = [NSMutableDictionary dictionary];
            
            [[AvalonsoftHttpClient avalonsoftHttpClient] requestWithAction:COMMON_SERVER_URL actionName:WELCOME_GET_PAGEDATA method:HttpRequestPost paramenters:root prepareExecute:^{
                
                [AvalonsoftLoadingHUD showIndicatorWithStatus:@"加载中..."];
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject){
                
                //隐藏加载框
                [AvalonsoftLoadingHUD dismiss];
                
                //处理网络请求结果
                [self handleNetworkRequestWithResponseObject:responseObject eventType:WELCOME_GET_PAGEDATA];
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error){
                //请求失败
                NSLog(@"%@",error);
                
                [AvalonsoftLoadingHUD showFailureWithStatus:@"请求失败"];
            }];
            
        }else{
            //没网
            [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"设备未连接网络，请连接网络后重试！" buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
        }
    }];
}

#pragma mark - 网络请求处理 -
-(void)handleNetworkRequestWithResponseObject:(id)responseObject eventType:(NSString *)eventType
{
    //使用responseObject对_M进行MVC赋值
    _M *responseModel = [_M createResponseJsonObj:responseObject];
    
    @try {
        if([eventType isEqualToString:WELCOME_GET_PAGEDATA]){
            if(responseModel.rescode == 200){
                
                NSArray *dataList = responseModel.data[@"dataList"];
                
                if(dataList.count == 0){
                    //未选择过，进入欢迎页
                    
                    
                }else{
                    //选过了
                    //设置欢迎页标志位为NO
                    avalonsoftUserDefaultsModel.isShowWelcome = NO;
                    
                    //跳转到首页
                    MainTabBarViewController *mainTabBarViewController = [[MainTabBarViewController alloc] init];
                    [self.navigationController pushViewController:mainTabBarViewController animated:YES];
                }
                
            }else{
                //给出提示信息
                [AvalonsoftMsgAlertView showWithTitle:@"信息" content:responseModel.msg buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
            }
        }
        
    } @catch (NSException *exception) {
        @throw exception;
        //给出提示信息
        [AvalonsoftMsgAlertView showWithTitle:@"信息" content:@"系统发生错误，请与平台管理员联系解决。"  buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
    }
}

@end
