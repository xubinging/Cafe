//
//  AvalonsoftMenuScrollView.m
//  Cafe
//
//  Created by leo on 2019/12/31.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftMenuScrollView.h"
#import "AvalonsoftMenuPageControl.h"

@interface AvalonsoftMenuScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) AvalonsoftMenuPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *upScrollView;

@end

@implementation AvalonsoftMenuScrollView

-(instancetype)initWithFrame:(CGRect)frame viewsArray:(NSArray *)views{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.views = views;
        self.maxCount = 8;
        [self createSubViews];
    }
    
    return self;
}

- (void)createSubViews{
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES;
    _pageControl = [[AvalonsoftMenuPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20,self.frame.size.width, 20)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = (self.views.count - 1) / self.maxCount + 1;
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255/255.0 green:212/255.0 blue:174/255.0 alpha:1.0];
    [self addSubview:_pageControl];
    
    _upScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - _pageControl.frame.size.height)];
    _upScrollView.delegate = self;
    _upScrollView.pagingEnabled = YES;
    _upScrollView.showsVerticalScrollIndicator = NO;
    _upScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_upScrollView];
    
    for (int i = 0; i < (self.views.count - 1) / self.maxCount + 1; i++) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, _upScrollView.frame.size.height)];
        NSInteger index = self.maxCount;
        if ((self.views.count - i * 8) < self.maxCount) {
            index = (self.views.count - i * self.maxCount);
        }
        for (int j = 0; j <index; j++) {
            int row = j/4;
            int col = j % 4;
            
//            NSLog(@"row = %d",row);
//            NSLog(@"col = %d",col);
//            NSLog(@"btnHieght = %f",(bgView.frame.size.height / 2));
            
            UIButton *btn = self.views[i * self.maxCount + j];
            btn.frame = CGRectMake(col * (self.frame.size.width / 4), row * (bgView.frame.size.height / 2) , (self.frame.size.width / 4), (bgView.frame.size.height / 2));
            btn.tag = 100000 + i * self.maxCount + j;
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:btn];
        }
        [_upScrollView addSubview:bgView];
        
    }
    
     _upScrollView.contentSize = CGSizeMake(self.frame.size.width * ((self.views.count - 1) / self.maxCount + 1), _upScrollView.frame.size.height);
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;  //计算这是第几页
    self.pageControl.currentPage = index;
}

- (void)btnAction:(UIButton *)btn{
    NSInteger index = btn.tag - 100000;
    if ([self.delegate respondsToSelector:@selector(buttonUpInsideWithView:withIndex:withView:)]) {
        [self.delegate buttonUpInsideWithView:btn withIndex:index withView:self];
    }
    
}

@end
