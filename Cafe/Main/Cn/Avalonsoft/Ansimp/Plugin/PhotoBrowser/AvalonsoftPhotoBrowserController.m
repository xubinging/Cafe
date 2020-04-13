//
//  AvalonsoftPhotoBrowserController.m
//  Cafe
//
//  Created by leo on 2020/2/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftPhotoBrowserController.h"
#import "AvalonsoftPhotoBrowserView.h"

@interface AvalonsoftPhotoBrowserController ()<AvalonsoftPhotoBrowserViewDelegate>
{
    AvalonsoftPhotoBrowserView *photoBrowser;
}
@end

@implementation AvalonsoftPhotoBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    photoBrowser = [[AvalonsoftPhotoBrowserView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    photoBrowser.displayTopPageNumber = self.displayTopPage;    //是否显示上方页码
    photoBrowser.displayTransmitBtn= self.displayTransmitBtn;   //是否显示转发按钮
    photoBrowser.currentImgIndex = self.currentImgIndex;        //当前页
    [photoBrowser reloadPhotoBrowseWithPhotoArray:self.imgArray];
    [photoBrowser setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    photoBrowser.delegate = self;
    
    [self.view addSubview:photoBrowser];
}

//点击转发按钮
- (void)photoBrowser:(AvalonsoftPhotoBrowserView *)photoBrowser didClickTransmitBtnAtIndex:(NSInteger)index
{
    [AvalonsoftToast showWithMessage:@"转发图片"];
}

//点击退出按钮
- (void)photoBrowser:(AvalonsoftPhotoBrowserView *)photoBrowser didClickQuitBtnAtIndex:(NSInteger)index
{
    [self singleTapDetected];
}

//点击退出
- (void)singleTapDetected
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setDisplayTopPage:(BOOL)displayTopPage
{
    _displayTopPage = displayTopPage;
}

- (void)setDisplayTransmitBtn:(BOOL)displayTransmitBtn
{
    _displayTransmitBtn = displayTransmitBtn;
}

//如果没有图片点击进来了,直接退出
//- (void)viewDidAppear:(BOOL)animated{
//    if (self.imgArray.count == 0) {
//        [SVProgressHUD showSuccessWithStatus:@"请设置图片"];
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
