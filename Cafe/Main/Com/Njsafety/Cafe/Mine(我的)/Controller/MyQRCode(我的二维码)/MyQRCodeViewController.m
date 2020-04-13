//
//  MyQRCodeViewController.m
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import "MyQRCodeViewController.h"

@interface MyQRCodeViewController ()

{
    @private UIView *navigationView;
    @private UIButton *backButton;          //左上角返回按钮
    
    @private UILabel *nameLabel;            //姓名标签
    @private UIImageView *sexImageView;     //性别标签
    @private UIImageView *iconImageView;    //头像
    @private UIImageView *qrCodeImageView;  //二维码
    
    @private NSString *userName;            //用户姓名
    
}

@end

@implementation MyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVars];
    [self initSharedPreferences];
    [self initNavigationView];
    [self initView];
    [self setData];
}

#pragma mark - 初始化一些参数 -
-(void)initVars
{
    self.view.backgroundColor = RGBA_GGCOLOR(249, 249, 249, 1);
    
    userName = @"灵儿Sunny";
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
        make.left.equalTo(navigationView).offset((SCREEN_WIDTH-150)/2);
        make.bottom.equalTo(navigationView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(150, 24));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.alpha = 1.0;
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:@"我的二维码" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    titleLabel.attributedText = titleLabelString;
}

#pragma mark - 初始化视图 -
-(void)initView
{
    //背景视图
    UIView *backView = [UIView new];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(navigationView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(22);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 22*2, 470));
    }];
    backView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    backView.layer.cornerRadius = 15;
    backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:0.15].CGColor;
    backView.layer.shadowOffset = CGSizeMake(0,0);
    backView.layer.shadowOpacity = 1;
    backView.layer.shadowRadius = 10;
    
    //姓名
    nameLabel = [UILabel new];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(backView).offset(35);
        make.left.equalTo(backView).offset(22);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.alpha = 1.0;
    nameLabel.numberOfLines = 0;
    [nameLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:18]];
    [nameLabel setTextColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
    
    //性别
    sexImageView = [UIImageView new];
    [self.view addSubview:sexImageView];
    [sexImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(nameLabel).offset(5);
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    //头像
    iconImageView = [UIImageView new];
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(backView).offset(22);
        make.right.equalTo(backView).offset(-22);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    iconImageView.layer.masksToBounds = YES;
    iconImageView.layer.cornerRadius = 25;
    
    //二维码背景
    UIImageView *qrCodeBackImageView = [UIImageView new];
    [self.view addSubview:qrCodeBackImageView];
    [qrCodeBackImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(backView).offset(95);
        make.left.equalTo(backView).offset((SCREEN_WIDTH - 22*2 - 285)/2);
        make.size.mas_equalTo(CGSizeMake(285, 285));
    }];
    [qrCodeBackImageView setImage:[UIImage imageNamed:@"mine_qrcode_border"]];
    
    [self.view layoutIfNeeded];
    
    //二维码图片
    qrCodeImageView = [UIImageView new];
    [qrCodeBackImageView addSubview:qrCodeImageView];
    [qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(qrCodeBackImageView).offset((qrCodeBackImageView.frame.size.height - 245)/2);
        make.left.equalTo(qrCodeBackImageView).offset((qrCodeBackImageView.frame.size.width - 245)/2);
        make.size.mas_equalTo(CGSizeMake(245, 245));
    }];
    
    //分割线
    UIView *splitView = [UIView new];
    [self.view addSubview:splitView];
    [splitView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(qrCodeBackImageView.mas_bottom).offset(30);
        make.left.equalTo(backView);
        make.right.equalTo(backView);
        make.height.mas_equalTo(@0.5);
    }];
    [splitView setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
    
    //提示文字
    UILabel *explainLabel = [UILabel new];
    [self.view addSubview:explainLabel];
    [explainLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(splitView.mas_bottom).offset(15);
        make.left.equalTo(backView).offset((SCREEN_WIDTH - 22*2 - 90)/2);
        make.size.mas_equalTo(CGSizeMake(90, 22));
    }];
    explainLabel.numberOfLines = 0;
    explainLabel.textAlignment = NSTextAlignmentCenter;
    explainLabel.alpha = 1.0;
    NSMutableAttributedString *explainLabelString = [[NSMutableAttributedString alloc] initWithString:@"扫一扫加我"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    explainLabel.attributedText = explainLabelString;
    
}

#pragma mark - 设置值 -
-(void)setData
{
    
    //姓名
    CGFloat nameWidth = [UILabel getWidthWithText:userName font:[UIFont fontWithName:@"PingFangSC-Medium" size:18]];
    if(nameWidth > (SCREEN_WIDTH - 22*2 - 22- 22 - 50 - 10 - 16 - 10)){
        nameWidth = SCREEN_WIDTH - 22*2 - 22- 22 - 50 - 10 - 16 - 10;
    }
    [nameLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(nameWidth, 25));
    }];
    [nameLabel setText:userName];
    
    //性别
    [sexImageView setImage:[UIImage imageNamed:@"mine_girl_color"]];
    
    //头像
    [iconImageView setImage:[UIImage imageNamed:@"home_foreign_school_icon"]];
    
    //生成二维码
    UIImage *qrCodeImage = [self generateQRCodeWithString:userName Size:245];
    [qrCodeImageView setImage:qrCodeImage];
    
}

#pragma mark - 返回按钮点击 -
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 生成二维码
- (UIImage *)generateQRCodeWithString:(NSString *)string Size:(CGFloat)size
{
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据<字符串长度893>
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKey:@"inputMessage"];
    //获取二维码过滤器生成二维码
    CIImage *image = [filter outputImage];
    UIImage *img = [self createNonInterpolatedUIImageFromCIImage:image WithSize:size];
    return img;
}

// 用生成的模糊图片重新生成清晰图片
- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image WithSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //创建bitmap
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //保存图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
