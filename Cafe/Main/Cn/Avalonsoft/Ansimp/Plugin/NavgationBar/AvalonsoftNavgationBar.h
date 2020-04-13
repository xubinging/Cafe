//
//  AvalonsoftNavgationBar.h
//  SmartLock
//
//  Created by leo on 2019/9/27.
//  Copyright © 2019 leo. All rights reserved.
//
//  自定义导航栏

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//枚举，中间显示的是图片或者字
typedef NS_ENUM(NSInteger,AvalonsoftNavMiddleStyle)
{
    AvalonsoftNavMiddleWithLab = 0,  // middle_lab
    AvalonsoftNavMiddleWithimg,      // middle_img
};

//声明协议，及定义可选择的方法
@protocol AvalonsoftNavgationBarDelegate <NSObject>

@optional;
- (void)touchTheLeftBtn:(UIButton *)btn;

- (void)touchTheRightBtn:(UIButton *)btn;
@end

@interface AvalonsoftNavgationBar : UIView

/** delegate*/
@property (nonatomic,weak) id <AvalonsoftNavgationBarDelegate>delegate;
/** style*/
@property (nonatomic,assign) AvalonsoftNavMiddleStyle navMiddleStyle;
/** bgcolor*/
@property (nonatomic,strong) UIColor *bgColor;
/** left_nor_img*/
@property (nonatomic,strong) UIImage *leftBtnNorImg;
/** left_select_img*/
@property (nonatomic,strong) UIImage *leftBtnselectImg;
/** left_hightly_img*/
@property (nonatomic,strong) UIImage *leftBtnHightlyImg;
/** right_nor_img*/
@property (nonatomic,strong) UIImage *rightBtnNorImg;
/** right_hightly_img*/
@property (nonatomic,strong) UIImage *rightBtnHightlyImg;
/** middle_img*/
@property (nonatomic,strong) UIImage *middleImage;
/** middle_text_Str*/
@property (nonatomic,copy) NSString *middleTextStr;
/** middle_img_rect*/
@property (nonatomic,assign) CGRect middleImgRect;

/** 左侧按钮中图片偏移量*/
@property (nonatomic,assign) CGFloat leftBtnImgShift;
/** 右侧按钮中图片偏移量*/
@property (nonatomic,assign) CGFloat rightBtnImgShift;
/** 获取左侧按钮*/
@property (nonatomic,strong) UIButton *leftButton;
/** 获取右侧按钮*/
@property (nonatomic,strong) UIButton *rightButton;

@end
NS_ASSUME_NONNULL_END
