//
//  AvalonsoftScanViewController.m
//  SmartLock
//
//  Created by leo on 2019/10/20.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftScanViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"

@interface AvalonsoftScanViewController ()<AvalonsoftNavgationBarDelegate>

@end

@implementation AvalonsoftScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupNavBar];
    //绘制提示文字，然后将提示文字显示在最前面
    [self drawTitle];
    [self.view bringSubviewToFront:_topTitle];
}

#pragma mark - 绘制提示文字 -
- (void)drawTitle
{
    if (!_topTitle)
    {
        self.topTitle = [[UILabel alloc] init];
        _topTitle.bounds = CGRectMake(0, 0, 300, 40);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 70 + NavBarHeight);
        _topTitle.font = [UIFont systemFontOfSize:13];
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将二维码/条码放入框内，即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
}

#pragma mark - 设置自定义导航栏 -
-(void)setupNavBar
{
    AvalonsoftNavgationBar *navBar = [[AvalonsoftNavgationBar alloc] initWithFrame:CGRectMake(0, StatusBarSafeTopMargin, SCREEN_WIDTH, NavBarHeight - StatusBarSafeTopMargin)];
    //使用文字进行显示
    navBar.navMiddleStyle = AvalonsoftNavMiddleWithLab;
    navBar.bgColor =  RGBA_GGCOLOR(12, 97, 173, 100);
    navBar.middleTextStr = @"二维码/条码";
    navBar.leftBtnNorImg = [UIImage imageNamed:@"btn_back"];
    [self.view addSubview:navBar];
    navBar.delegate=self;
    [self.view bringSubviewToFront:navBar];
}

#pragma mark - AvalonsoftNavgationBarDelegate -
//点击左侧按钮
- (void)touchTheLeftBtn:(UIButton *)btn
{    
    //返回上个页面
    [self.navigationController popViewControllerAnimated:YES];
}
//点击右侧按钮
- (void)touchTheRightBtn:(UIButton *)btn
{
}

#pragma mark - 扫码结果，自动执行的方法 -
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (array.count < 1){
        //识别失败
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    LBXScanResult *scanResult = array[0];

    //scanResult.strScanned 是 NSCFString 格式
    NSString *strResult = [NSString stringWithFormat:@"%@",scanResult.strScanned];
    
    //这句话结合 self.isNeedScanImage = YES; 可将扫码图片显示出来
    //self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    
    //震动提醒
    [LBXScanWrapper systemVibrate];
    //声音提醒
    //[LBXScanWrapper systemSound];
    
    [self showParentVCWithScanResult:scanResult];
    
}

#pragma mark - 识别失败弹出框 -
- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        strResult = @"识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
    [AvalonsoftMsgAlertView showWithTitle:@"信息" content:strResult buttonTitles:@[@"关闭"] buttonClickedBlock:^(NSInteger buttonIndex){
        if(buttonIndex==0){
            //继续扫码
            [weakSelf reStartDevice];
        }
    }];

}

#pragma mark - 扫码后自动返回上一页 -
- (void)showParentVCWithScanResult:(LBXScanResult*)scanResult
{
    //设置回调
    NSString *strResult = [NSString stringWithFormat:@"%@",scanResult.strScanned];
    
    NSDictionary *sendDataDic = @{@"scanResult":strResult};
    //Block传值step 3:传值类将要传的值传入自己的block中
    self.sendValueBlock(sendDataDic);
    
    //返回上个页面
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 该方法是父类中方法，子类必须实现 -
- (void)showError:(NSString *)str
{
    [AvalonsoftMsgAlertView showWithTitle:@"信息" content:str buttonTitles:@[@"关闭"] buttonClickedBlock:nil];
}

@end
