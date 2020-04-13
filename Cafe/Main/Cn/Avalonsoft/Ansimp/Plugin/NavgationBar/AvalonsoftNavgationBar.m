//
//  AvalonsoftNavgationBar.m
//  SmartLock
//
//  Created by leo on 2019/9/27.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftNavgationBar.h"

@implementation AvalonsoftNavgationBar

{
    UIButton *_leftBtn;         //左侧按钮
    UIButton *_rightBtn;        //右侧按钮
    UIImageView *_middleImg;    //中间图片
    UILabel *_middleText;       //中间文字
    UIView *_cotainView;        //父view
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    //设置背景色
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = _bgColor;
    }
    return self;
}

#pragma mark - UI布局
- (void)setupSubViews
{
    //导航栏高度设置了64
    //设置左侧按钮位置
    _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(15,26,32,32)];
    _leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_leftBtn addTarget:self action:@selector(clickleftWithbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtn];
    
    //设置右侧按钮位置
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-47, 26, 32, 32)];
    _rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_rightBtn addTarget:self action:@selector(clickRightWithbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];
    
    //如果中间是图片
    if (_navMiddleStyle == AvalonsoftNavMiddleWithimg) {
        _middleImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,20,100,28)];
        _middleImg.contentMode = UIViewContentModeScaleAspectFill;
        // 当设置成NO的时候，不剪裁超出父视图范围的子视图
        _middleImg.clipsToBounds = NO;
        CGPoint center = _middleImg.center;
        center.x = SCREEN_WIDTH / 2;
        center.y = 42;
        _middleImg.center = center;
        [self addSubview:_middleImg];
    }
    
    //如果中间是文字
    if(_navMiddleStyle == AvalonsoftNavMiddleWithLab){
        _middleText = [[UILabel alloc] initWithFrame:CGRectMake(0,20,SCREEN_WIDTH/2,20)];
        CGPoint center = _middleText.center;
        center.x = SCREEN_WIDTH / 2;
        center.y = 42;
        _middleText.center = center;
        [_middleText setTextColor:[UIColor whiteColor]];
        _middleText.textAlignment = NSTextAlignmentCenter;
        _middleText.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:_middleText];
    }
}

#pragma mark 点击逻辑处理
//点击左侧按钮
- (void)clickleftWithbtn:(UIButton *)sender;
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(touchTheLeftBtn:)])
    {
        [self.delegate touchTheLeftBtn:sender];
    }
}

//点击右侧按钮
- (void)clickRightWithbtn:(UIButton *)sender;
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchTheRightBtn:)])
    {
        [self.delegate touchTheRightBtn:sender];
    }
}

#pragma mark - set/get
// set_nar_style
- (void)setNavMiddleStyle:(AvalonsoftNavMiddleStyle)navMiddleStyle
{
    _navMiddleStyle = navMiddleStyle;
    [self setupSubViews];
}

// bgColor
- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

// left_img_nor
-(void)setLeftBtnNorImg:(UIImage *)leftBtnNorImg
{
    _leftBtnNorImg = leftBtnNorImg;
    [_leftBtn setImage:leftBtnNorImg forState:UIControlStateNormal];
}

// leftBtnselectImg
- (void)setLeftBtnselectImg:(UIImage *)leftBtnselectImg
{
    _leftBtnselectImg = leftBtnselectImg;
    [_leftBtn setImage:leftBtnselectImg forState:UIControlStateSelected];
}

// left_hightly_img
- (void)setLeftBtnHightlyImg:(UIImage *)leftBtnHightlyImg
{
    _leftBtnHightlyImg = leftBtnHightlyImg;
    [_leftBtn setImage:leftBtnHightlyImg forState:UIControlStateHighlighted];
}

// right_img_nor
- (void)setRightBtnNorImg:(UIImage *)rightBtnNorImg
{
    _rightBtnNorImg = rightBtnNorImg;
    [_rightBtn setImage:rightBtnNorImg forState:UIControlStateNormal];
}

// right_hightly_nor
- (void)setRightBtnHightlyImg:(UIImage *)rightBtnHightlyImg
{
    _rightBtnHightlyImg = rightBtnHightlyImg;
    [_rightBtn setImage:rightBtnHightlyImg forState:UIControlStateHighlighted];
}

// middle_image
-(void)setMiddleImage:(UIImage *)middleImage
{
    _middleImage = middleImage;
    _middleImg.image = middleImage;
}

// middleTextStr
-(void)setMiddleTextStr:(NSString *)middleTextStr
{
    _middleTextStr = middleTextStr;
    _middleText.text = middleTextStr;
}

//middleImgRect
- (void)setMiddleImgRect:(CGRect)middleImgRect
{
    _middleImgRect = middleImgRect;
    _middleImg.bounds = middleImgRect;
}

//leftBtnImgShift
- (void)setLeftBtnImgShift:(CGFloat)leftBtnImgShift
{
    _leftBtnImgShift = leftBtnImgShift;
    [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(leftBtnImgShift, leftBtnImgShift, leftBtnImgShift, leftBtnImgShift)];
}

//rightBtnImgShift
- (void)setRightBtnImgShift:(CGFloat)rightBtnImgShift
{
    _rightBtnImgShift = rightBtnImgShift;
    [_rightBtn setImageEdgeInsets:UIEdgeInsetsMake(rightBtnImgShift, rightBtnImgShift, rightBtnImgShift, rightBtnImgShift)];
}

//获取左侧按钮
- (UIButton *)leftButton
{
    return _leftBtn;
}

- (UIButton *)rightButton
{
    return _rightBtn;
}

@end

