//
//  AvalonsoftScanViewController.h
//  SmartLock
//
//  Created by leo on 2019/10/20.
//  Copyright © 2019 leo. All rights reserved.
//

#import "LBXScanViewController.h"

NS_ASSUME_NONNULL_BEGIN

//继承LBXScanViewController，可在界面上绘制想要的按钮，提示语等
@interface AvalonsoftScanViewController : LBXScanViewController

//回调函数
@property (nonatomic,copy)void(^sendValueBlock)(NSDictionary *valueDict);

@property (nonatomic, strong) UILabel *topTitle;    //扫码区域上方提示文字

#pragma mark - 下面几个功能，是模仿QQ扫码出现的，暂时没用 -
@property (nonatomic, assign) BOOL isQQSimulator;   //模仿qq界面

@property (nonatomic, assign) BOOL isVideoZoom;     //增加拉近/远视频界面

@property (nonatomic, strong) UIView *bottomItemsView;  //底部显示的功能项

@property (nonatomic, strong) UIButton *btnPhoto;       //相册

@property (nonatomic, strong) UIButton *btnFlash;       //开启闪光灯

@property (nonatomic, strong) UIButton *btnMyQR;        //我的二维码

@end

NS_ASSUME_NONNULL_END
