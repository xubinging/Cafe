//
//  ZQPlayerPortraitViewController.m
//  Cafe
//
//  Created by 孙怡 on 2020/3/12.
//  Copyright © 2020 leo. All rights reserved.
//

#import "ZQPlayerPortraitViewController.h"

#import "Masonry.h"
#import "ZQPlayer.h"
#import "ZQPlayerMaskView.h"
#import "ZQPlayerLandSpaceViewController.h"

@interface ZQPlayerPortraitViewController () <ZQPlayerDelegate>

/** 视频播放器*/
@property (nonatomic, strong) ZQPlayerMaskView *playerMaskView;


/** 音频播放器 */
@property (nonatomic, strong) ZQPlayer *audioPlayer;

@end

@implementation ZQPlayerPortraitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景色
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    // 视频播放
    _playerMaskView = [[ZQPlayerMaskView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height)];
    _playerMaskView.delegate = self;
    _playerMaskView.isWiFi = self.isWiFi; // 是否允许自动加载，
    _playerMaskView.titleLab.text = self.videoTitle;
    [self.view addSubview:_playerMaskView];
    
    [_playerMaskView playWithVideoUrl:self.videoUrl];
    
    [_playerMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(StatusBarSafeTopMargin);
        make.bottom.equalTo(self.view).offset(-StatusBarSafeTopMargin);
    }];
    /*
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(StatusBarSafeTopMargin);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    //设置点击不变色
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_foreign_detail_back"] forState:UIControlStateNormal];
    //左上角退出按钮
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *landspaceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [landspaceBtn setTitle:@"横屏" forState:UIControlStateNormal];
    landspaceBtn.frame = CGRectMake(self.view.frame.size.width - 50, 10, 50, 30);
    [landspaceBtn addTarget:self action:@selector(landspaceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landspaceBtn];
    landspaceBtn.hidden = YES;
    */
    
    //退出按钮
    UIView *quitView = [UIView new];
    quitView.frame = CGRectMake(5, StatusBarHeight, 54, 44);
    quitView.backgroundColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1.0];
    quitView.layer.cornerRadius = 14;
    [self.view addSubview:quitView];
    
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(18, 13, 18, 18);
    [quitBtn setImage:[UIImage imageNamed:@"browser_quit"] forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [quitView addSubview:quitBtn];
}

- (void)landspaceAction {
//    ZQPlayerLandSpaceViewController *vc = [[ZQPlayerLandSpaceViewController alloc] init];
//    vc.videoUrl = self.videoUrl;
//    vc.videoTitle = self.videoTitle;
//    [self presentViewController:vc animated:YES completion:nil];
}

-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 屏幕旋转
//是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate {
    return YES;
}

//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

//这个是返回优先方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

// 全屏需要重写方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator  {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        // 隐藏导航栏
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [_playerMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(StatusBarSafeTopMargin);
            make.bottom.equalTo(self.view).offset(-StatusBarSafeTopMargin);
        }];
    }
    else {
        // 显示导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [_playerMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

@end
