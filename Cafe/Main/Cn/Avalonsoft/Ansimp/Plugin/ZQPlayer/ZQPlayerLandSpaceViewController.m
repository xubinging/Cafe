//
//  ZQPlayerLandSpaceViewController.m
//  Cafe
//
//  Created by 孙怡 on 2020/3/12.
//  Copyright © 2020 leo. All rights reserved.
//

#import "ZQPlayerLandSpaceViewController.h"

#import "Masonry.h"
#import "ZQPlayer.h"

@interface ZQPlayerLandSpaceViewController ()<ZQPlayerDelegate,UIGestureRecognizerDelegate>
{
    BOOL _isDragSlider;
}

/** 播放器 */
@property (nonatomic, strong) ZQPlayer *player;

// 控件
/** 顶部包含，返回按钮，标题等视图 */
@property (nonatomic, strong) UIView *topView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLab;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backBtn;
/** 底部包含，播放、当前时间、总时间、进度条等视图 */
@property (nonatomic, strong) UIView *bottomView;
/** 播放按钮 */
@property (nonatomic, strong) UIButton *playBtn;
/** 当前时间 */
@property (nonatomic, strong) UILabel *currentTimeLabel;
/** 总时间 */
@property (nonatomic, strong) UILabel *totalTimeLabel;
/** 加载进度条 */
@property (nonatomic, strong) UIProgressView *progressView;
/** 视频播放进度条 */
@property (nonatomic, strong) UISlider *videoSlider;

/** 加载中View */
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIImageView *loadingImage;


/** bottom渐变层*/
@property (nonatomic, strong) CAGradientLayer *bottomGradientLayer;
/** top渐变层 */
@property (nonatomic, strong) CAGradientLayer *topGradientLayer;

/** 定时隐藏buttomView和TopView的定时器 */
@property (nonatomic,strong) NSTimer *hideBottomTimer;

// 手势
@property(nonatomic, strong) UIPanGestureRecognizer *pan;  // 快进，快退手势
@property(nonatomic, strong) UITapGestureRecognizer *sliderTap; // 视频播放进度条点击快进、快退手势
@property(nonatomic, strong) UITapGestureRecognizer *tap; // 点击显示控件手势

@end

@implementation ZQPlayerLandSpaceViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isDragSlider = NO;
        _isWiFi = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    
    [self initCAGradientLayer];
    
    [self cofigGestureRecognizer];
    
    self.videoSlider.value = 0;
    _currentTimeLabel.text = @"00:00";
    
    if (_isWiFi) {
        [_player nextWithUrl:self.videoUrl];
        [_player play];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _player.playerLayer.frame = self.view.bounds;
    _topGradientLayer.frame = self.topView.bounds;
    _bottomGradientLayer.frame = self.bottomView.bounds;
}


- (void)setUI {
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    
    self.player.playerLayer.frame = self.view.bounds;
    if (![self.view.layer.sublayers containsObject:self.player.playerLayer]) {
        [self.view.layer addSublayer:self.player.playerLayer];
    }
    
    [self.view addSubview:self.topView];
    [_topView addSubview:self.titleLab];
    [_topView addSubview:self.backBtn];
    self.titleLab.text = self.videoTitle;
    
    [self.view addSubview:self.bottomView];
    [_bottomView addSubview:self.playBtn];
    [_bottomView addSubview:self.currentTimeLabel];
    [_bottomView addSubview:self.progressView];
    [_bottomView addSubview:self.videoSlider];
    [_bottomView addSubview:self.totalTimeLabel];
    [self.view addSubview:self.loadingView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.offset(5);
        make.top.equalTo(self.topView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.topView);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).with.offset(20);
        make.bottom.equalTo(self.bottomView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playBtn.mas_right).with.offset(10);
        make.centerY.equalTo(self.playBtn);
        make.width.mas_equalTo(38);
    }];
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-20);
        make.centerY.equalTo(self.playBtn);
    }];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentTimeLabel.mas_right).with.offset(10);
        make.right.equalTo(self.totalTimeLabel.mas_left).with.offset(-10);
        make.centerY.equalTo(self.playBtn);
    }];
    [_videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentTimeLabel.mas_right).with.offset(10);
        make.right.equalTo(self.totalTimeLabel.mas_left).with.offset(-10);
        make.centerY.equalTo(self.playBtn).with.offset(-1);
    }];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 70));
    }];
}

- (void)cofigGestureRecognizer {
    // 添加平移手势，用来控制音量、亮度、快进快退
    _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];
    [self.view addGestureRecognizer:_pan];
    
    _tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOrHidden:)];
    _tap.delegate = self;
    [self.view addGestureRecognizer:_tap];
    
    _sliderTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSlider:)];
    _sliderTap.delegate = self;
    [_videoSlider addGestureRecognizer:_sliderTap];
}

- (void)initCAGradientLayer {
    //初始化Bottom渐变层
    self.bottomGradientLayer            = [CAGradientLayer layer];
    [self.bottomView.layer insertSublayer:self.bottomGradientLayer atIndex:0];
    //设置渐变颜色方向
    self.bottomGradientLayer.startPoint = CGPointMake(0, 0);
    self.bottomGradientLayer.endPoint   = CGPointMake(0, 1);
    //设定颜色组
    self.bottomGradientLayer.colors     = @[(__bridge id)[UIColor colorWithWhite:0 alpha:0.0].CGColor,
                                            (__bridge id)[UIColor colorWithWhite:0 alpha:0.5].CGColor];
    //设定颜色分割点
    self.bottomGradientLayer.locations  = @[@(0.0f) ,@(1.0f)];
    
    
    //初始Top化渐变层
    self.topGradientLayer               = [CAGradientLayer layer];
    [self.topView.layer insertSublayer:self.topGradientLayer atIndex:0];
    //设置渐变颜色方向
    self.topGradientLayer.startPoint    = CGPointMake(1, 0);
    self.topGradientLayer.endPoint      = CGPointMake(1, 1);
    //设定颜色组
    self.topGradientLayer.colors        = @[ (__bridge id)[UIColor colorWithWhite:0 alpha:0.5].CGColor,
                                             (__bridge id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    //设定颜色分割点
    self.topGradientLayer.locations     = @[@(0.0f) ,@(1.0f)];
    
}


#pragma mark - public method



#pragma mark - private method
// 从ZQPlayerImage.bundle 中加载图片
- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName {
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ZQPlayerImage.bundle"];
    NSString *img_path = [bundlePath stringByAppendingPathComponent:imgName];
    return [UIImage imageWithContentsOfFile:img_path];
}
// 播放视频，判断用户网络来
- (void)playWithJudgeNet {
    if (_isWiFi) {
        [_player play];
    }else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示"
                                                                        message:@"您正处于移动网络环境下，是否要使用流量播放"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.isWiFi = YES;
            [self.player nextWithUrl:self.videoUrl];
            [self.player play];
        }]];
        [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.playBtn.selected = NO;
        }]];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertC animated:YES completion:nil];
    }
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (_tap == gestureRecognizer) {
        return self.view == touch.view;
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (_sliderTap == gestureRecognizer) {
        return _videoSlider == gestureRecognizer.view;
    }else {
        return self.view == gestureRecognizer.view;
    }
}

#pragma mark - slider事件
// slider开始滑动事件
- (void)progressSliderTouchBegan:(UISlider *)slider {
    _isDragSlider = YES;
    [_player.player pause];
    
    if (_hideBottomTimer) {
        [_hideBottomTimer invalidate];
        _hideBottomTimer = nil;
    }
    [self showOrHideWith:YES];
}
// slider滑动中事件
- (void)progressSliderValueChanged:(UISlider *)slider {
    CGFloat current = _player.timeInterval*slider.value;
    //秒数
    NSInteger proSec = (NSInteger)current%60;
    //分钟
    NSInteger proMin = (NSInteger)current/60;
    _currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", proMin, proSec];
    
}
// slider结束滑动事件
- (void)progressSliderTouchEnded:(UISlider *)slider {
    if (_player.player.status != AVPlayerStatusReadyToPlay) {
        return;
    }
    //转换成CMTime才能给player来控制播放进度
    __weak typeof(self) weakself = self;
    CMTime dragedCMTime     = CMTimeMakeWithSeconds(_player.timeInterval * slider.value, 600);
    [_player.player seekToTime:dragedCMTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        __strong typeof(weakself) strongself = self;
        strongself->_isDragSlider = NO;
        if (finished) {
            if (weakself.player.isPlaying) {
                [weakself.player.player play];
            }
        }
    }];
    [self hidePlayerSubviewWithTimer];
}

- (void)tapSlider:(UITapGestureRecognizer *)tap {
    [self progressSliderTouchBegan:self.videoSlider];
    CGPoint point = [tap locationInView:tap.view];
    CGFloat value = point.x/ tap.view.frame.size.width;
    self.videoSlider.value = value;
    [self progressSliderValueChanged:self.videoSlider];
    [self progressSliderTouchEnded:self.videoSlider];
}

#pragma mark - ZQPlayerDelegate
/**
 播放器状态变化
 @param player 播放器
 @param state 状态
 */
- (void)ZQPlayerStateChange:(ZQPlayer *)player state:(ZQPlayerState)state {
    if (state == ZQPlayerStatePlaying) {
        _playBtn.selected = YES;
        if (_player.isBuffering) {
            [self startLoading];
        }else {
            self.loadingView.hidden = YES;
            [self hidePlayerSubviewWithTimer];
        }
    }
    else if (state == ZQPlayerStatePause) {
        _playBtn.selected = NO;
        [self showPlayerSubview];
    }
    else if (state == ZQPlayerStateBufferEmpty) {
        [self startLoading];
    }
    else if (state == ZQPlayerStateKeepUp) {
        [self stopLoading];
    }
    else if (state == ZQPlayerStateStop) {
        _playBtn.selected = NO;
        _currentTimeLabel.text = @"00:00";
        [_videoSlider setValue:0 animated:YES];
        
        [self showPlayerSubview];
    }
    else if (state == ZQPlayerStateReadyToPlay) {
        
    }
}

/**
 视频源开始加载后调用 ，返回视频的长度
 */
- (void)ZQPlayerTotalTime:(ZQPlayer *)player totalTime:(CGFloat)time {
    //秒数
    NSInteger proSec = (NSInteger)time%60;
    //分钟
    NSInteger proMin = (NSInteger)time/60;
    _totalTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", proMin, proSec];
}

/**
 视频源加载时调用 ，返回视频的缓冲长度
 */
- (void)ZQPlayerLoadTime:(ZQPlayer *)player loadTime:(CGFloat)time {
    // 判断视频长度
    if (player.timeInterval > 0) {
        [_progressView setProgress:time / player.timeInterval animated:YES];
    }
}

/**
 播放时调用，返回当前时间
 */
- (void)ZQPlayerCurrentTime:(ZQPlayer *)player currentTime:(CGFloat)time {
    [self.videoSlider setValue:time/player.timeInterval animated:YES];
    //秒数
    NSInteger proSec = (NSInteger)time%60;
    //分钟
    NSInteger proMin = (NSInteger)time/60;
    _currentTimeLabel.text    = [NSString stringWithFormat:@"%02ld:%02ld", proMin, proSec];
}
#pragma mark - Events
// 是否显示控件
- (void)showOrHideWith:(BOOL)isShow {
    [UIView animateWithDuration:0.3 animations:^{
        for (UIView *view in self.view.subviews) {
            if (![view isEqual:self.loadingView]) {
                view.hidden = !isShow;
            }
        }
    }];
}

// 开始加载
- (void)startLoading {
    if (!_player.isPlaying) {
        return;
    }
    if (_hideBottomTimer) {
        [_hideBottomTimer invalidate];
        _hideBottomTimer = nil;
    }
    [self showOrHideWith:YES]; // 显示控件
    
    self.loadingView.hidden = NO;
    self.loadingImage.image = [self imagesNamedFromCustomBundle:@"icon_video_loading"];
    if (![self.loadingImage.layer animationForKey:@"loading"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: M_PI *2];
        animation.duration = 3;
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [self.loadingImage.layer addAnimation:animation forKey:@"loading"];
    }
}
// 加载完成
- (void)stopLoading {
    if (!_player.isPlaying) {
        return;
    }
    if (_player.isPlaying) {
        self.loadingView.hidden = YES;
        [self.loadingImage.layer removeAnimationForKey:@"loading"];
        // 自动隐藏控件
        [self hidePlayerSubviewWithTimer];
    }
}

// 4秒后自动隐藏底部视图
- (void)hidePlayerSubviewWithTimer {
    if (_hideBottomTimer) {
        [_hideBottomTimer invalidate];
        _hideBottomTimer = nil;
    }
    // 开启定时器
    _hideBottomTimer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(hidePlayerSubview) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_hideBottomTimer forMode:NSRunLoopCommonModes];
}
// 隐藏底部试图
- (void) hidePlayerSubview {
    if (!_player.isPlaying) {
        return;
    }
    if (_hideBottomTimer) {
        [_hideBottomTimer invalidate];
        _hideBottomTimer = nil;
    }
    
    [self showOrHideWith:NO];
}
// 显示底部试图
- (void)showPlayerSubview {
    if (_hideBottomTimer) {
        [_hideBottomTimer invalidate];
        _hideBottomTimer = nil;
    }
    [self showOrHideWith:YES];
    
    if (_player.isPlaying) {
        [self hidePlayerSubviewWithTimer];
    }
}


#pragma mark - 手势 和按钮事件
// 点击手势 显示和隐藏播放器上其他视图
- (void)showOrHidden:(UITapGestureRecognizer *)gr {
    if (_player.isPlaying) {
        if (_bottomView.hidden) {
            [self showPlayerSubview];
        }else {
            [self hidePlayerSubview];
        }
    }
}
//添加平移手势  快进快退
- (void)panDirection:(UIPanGestureRecognizer *)pan {
    CGPoint veloctyPoint = [pan velocityInView:self.view];
    // 判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{ // 开始移动
            // 使用绝对值来判断移动的方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) { // 水平移动
                [self progressSliderTouchBegan:_videoSlider];
            }else if (x < y){ // 垂直移动
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{ // 正在移动
            float v = _videoSlider.value + veloctyPoint.x/40000;
            [_videoSlider setValue:v animated:YES];
            [self progressSliderValueChanged:_videoSlider];
            break;
        }
        case UIGestureRecognizerStateEnded:{ // 移动停止
            [self progressSliderTouchEnded:_videoSlider];
        }
        default:
            break;
    }
}

#pragma mark - 按钮事件
// 播放按钮事件
- (void)startAndPause:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self playWithJudgeNet];
    }else {
        [_player pause];
    }
}
// lodingView上的View点击手势 暂停后，点击播放
- (void)play {
    if (!_player.isPlaying) {
        [self playWithJudgeNet];
    }
}

- (void)popbackAction{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - 屏幕旋转

-(BOOL)shouldAutorotate {
    return YES;
}
//当前支持的旋转类型
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
// 默认进去类型
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}


#pragma mark - Getter & Setter

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"";
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[self imagesNamedFromCustomBundle:@"icon_back_white"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(popbackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.frame = CGRectMake(0, 0, 21, 21);
        [_playBtn setImage:[self imagesNamedFromCustomBundle:@"icon_video_play"] forState:UIControlStateNormal];
        [_playBtn setImage:[self imagesNamedFromCustomBundle:@"icon_video_stop"] forState:UIControlStateSelected];
        [_playBtn addTarget:self action:@selector(startAndPause:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}
- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc]init];
        _currentTimeLabel.text = @"00:00";
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        _currentTimeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _currentTimeLabel;
}
- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc]init];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        _totalTimeLabel.font = [UIFont systemFontOfSize:11];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.text = @"00:00";
    }
    return _totalTimeLabel;
}
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]init];
        _progressView.progressTintColor    = [UIColor colorWithWhite:1 alpha:0.3];
        _progressView.trackTintColor       = [UIColor colorWithRed:81/255.0 green:81/255.0 blue:81/255.0 alpha:0.5];
    }
    return _progressView;
}
- (UISlider *)videoSlider {
    if (!_videoSlider) {
        _videoSlider = [[UISlider alloc]init];
        [_videoSlider setThumbImage:[self imagesNamedFromCustomBundle:@"icon_video_spot"] forState:UIControlStateNormal];
        _videoSlider.minimumTrackTintColor = [UIColor colorWithWhite:1 alpha:0.6];
        _videoSlider.maximumTrackTintColor = [UIColor clearColor];
        // slider开始滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    }
    return _videoSlider;
}
- (UIView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        _loadingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _loadingView.layer.cornerRadius = 7;
        [_loadingView addSubview:self.loadingImage];
        [_loadingImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self->_loadingView);
            make.size.mas_equalTo(CGSizeMake(31, 31));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play)];
        [_loadingView addGestureRecognizer:tap];
    }
    return _loadingView;
}
- (UIImageView *)loadingImage {
    if (!_loadingImage ){
        _loadingImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 31)];
        _loadingImage.image = [self imagesNamedFromCustomBundle:@"icon_video_play"];
        _loadingImage.userInteractionEnabled = YES;
    }
    return _loadingImage;
}

- (ZQPlayer *)player {
    if (!_player) {
        _player = [[ZQPlayer alloc] init];
        _player.delegate = self;
    }
    return _player;
}

- (void)dealloc {
    if (_hideBottomTimer) {
        [_hideBottomTimer invalidate];
        _hideBottomTimer = nil;
    }
}





@end
