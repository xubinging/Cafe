//
//  AvalonsoftPickerViewManager.h
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftPickerViewManager : NSObject

@property (nonatomic , assign) CGFloat kPickerViewH;
@property (nonatomic , assign) CGFloat kTopViewH;

@property (nonatomic , strong) UIColor *pickerTitleColor;   //字体颜色
@property (nonatomic , assign) CGFloat pickerTitleSize;     //字体大小


@property (nonatomic , strong) UIColor *lineViewColor;      //分割线颜色
@property (nonatomic , strong) UIColor *titleLabelColor;    //中间标题颜色
@property (nonatomic , strong) UIColor *titleLabelBGColor;  //中间标题背景颜色
@property (nonatomic , assign) CGFloat titleSize;           //字体大小


@property (nonatomic , strong) UIColor *rightBtnTitleColor;     //右侧标题颜色
@property (nonatomic , strong) UIColor *rightBtnBGColor;        //右侧标题背景颜色
@property (nonatomic , assign) CGFloat rightBtnTitleSize;       //字体大小
@property (nonatomic , strong) NSString *rightBtnTitle;         //右侧文字
@property (nonatomic , assign) CGFloat rightBtnCornerRadius;    //右侧圆角
@property (nonatomic , assign) CGFloat rightBtnBorderWidth;     //右侧边框宽
@property (nonatomic , strong) UIColor *rightBtnborderColor;    //右侧边框颜色


@property (nonatomic , strong) UIColor *leftBtnTitleColor;      //左侧标题颜色
@property (nonatomic , strong) UIColor *leftBtnBGColor;         //左侧标题背景颜色
@property (nonatomic , assign) CGFloat leftBtnTitleSize;        //字体大小
@property (nonatomic , strong) NSString *leftBtnTitle;          //左侧文字
@property (nonatomic , assign) CGFloat leftBtnCornerRadius;     //左侧圆角
@property (nonatomic , assign) CGFloat leftBtnBorderWidth;      //左侧边框宽
@property (nonatomic , strong) UIColor *leftBtnborderColor;     //左侧边框颜色

@end

NS_ASSUME_NONNULL_END
