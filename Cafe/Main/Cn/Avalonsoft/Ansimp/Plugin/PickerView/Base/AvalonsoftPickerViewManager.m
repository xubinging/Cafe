//
//  AvalonsoftPickerViewManager.m
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftPickerViewManager.h"

@interface AvalonsoftPickerViewManager ()

@end

@implementation AvalonsoftPickerViewManager

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _kPickerViewH = 200;    //选择区域高度
        _kTopViewH = 40;        //标题高度
        _pickerTitleSize  = 18; //选择器中文字大小
        _pickerTitleColor = RGBA_GGCOLOR(34, 34, 34, 1);   //选择器文字颜色
        _lineViewColor = RGBA_GGCOLOR(223, 223, 223, 1);
        
        //标题标签
        _titleLabelColor = RGBA_GGCOLOR(252, 96, 134, 1);
        _titleSize = 16;
        _titleLabelBGColor = [UIColor clearColor];
        
        _rightBtnTitle = @"确定";
        _rightBtnBGColor = [UIColor clearColor];      //背景色
        _rightBtnTitleSize = 15;
        _rightBtnTitleColor = RGBA_GGCOLOR(26, 46, 80, 1);      //文字颜色
        
        _rightBtnborderColor = RGBA_GGCOLOR(252, 96, 134, 1);
        _rightBtnCornerRadius = 6;
        _rightBtnBorderWidth = 0;
        
        _leftBtnTitle = @"取消";
        _leftBtnBGColor =  [UIColor clearColor];
        _leftBtnTitleSize = 15;
        _leftBtnTitleColor = RGBA_GGCOLOR(26, 46, 80, 1);
        
        _leftBtnborderColor = RGBA_GGCOLOR(252, 96, 134, 1);
        _leftBtnCornerRadius = 6;
        _leftBtnBorderWidth = 0;
    }
    
    return self;
}

@end
