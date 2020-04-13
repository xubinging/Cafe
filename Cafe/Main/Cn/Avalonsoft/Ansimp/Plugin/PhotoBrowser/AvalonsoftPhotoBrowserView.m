//
//  AvalonsoftPhotoBrowserView.m
//  Cafe
//
//  Created by leo on 2020/2/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftPhotoBrowserView.h"
#import "AvalonsoftPhotoCollectionCell.h"

@interface AvalonsoftPhotoBrowserView()
@property (assign, nonatomic) int currentIndex;
@end

@implementation AvalonsoftPhotoBrowserView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        frameRect = frame;
        totalItemsCount = 0;
        photoArray = [[NSMutableArray alloc] init];
        
        self.displayPageNumber = YES;
        self.isInfiniteLoop = NO;
        
        [self createView];
        
        self.autoScroll = NO;
        self.autoScrollTimeInterval = 3.0;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame Photos:(NSMutableArray*)array {
    self = [self initWithFrame:frame];
    if (self) {
        [self reloadPhotoBrowseWithPhotoArray:array];
    }
    return self;
}

- (void)reloadPhotoBrowseWithPhotoArray:(NSMutableArray *)array {
    
    [photoArray removeAllObjects];
    
    [photoArray addObjectsFromArray:array];
    
    if (self.isInfiniteLoop) {
        totalItemsCount = (int)photoArray.count * 100;
    }
    else {
        totalItemsCount = (int)photoArray.count;
    }
    
    if (self.displayTopPageNumber) {    //若显示顶部,底部隐藏
        [pageNumberLabel setTextColor:[UIColor clearColor]];
    }
    
    [self reloadPageNumberLabel];
    
    [photoCollectionView reloadData];
    
}

- (void)setPadding:(CGFloat)padding
{
    _padding = padding;
    frameRect.size.width = frameRect.size.width+self.padding;
    [self setFrame:frameRect];
}

- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    if (_autoScroll) {
        [autoScrollTimer invalidate];
        autoScrollTimer = nil;
        [self setupTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}

- (void)setupTimer
{
    autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:autoScrollTimer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll
{
    if (photoArray.count > 1) {
        int currentIndex = photoCollectionView.contentOffset.x / frameRect.size.width;
        int targetIndex = currentIndex + 1;
        if (targetIndex == totalItemsCount) {
            if (self.isInfiniteLoop) {
                targetIndex = totalItemsCount * 0.5;
            }
            else {
                targetIndex = 0;
            }
            [photoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        [photoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

- (void)createView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frameRect.size.width, frameRect.size.height) collectionViewLayout:layout];
    [photoCollectionView setPagingEnabled:YES];
    [photoCollectionView setDelegate:self];
    [photoCollectionView setDataSource:self];
    [photoCollectionView setShowsHorizontalScrollIndicator:NO];
    [photoCollectionView setBackgroundColor:[UIColor clearColor]];
    [photoCollectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [photoCollectionView registerClass:[AvalonsoftPhotoCollectionCell class] forCellWithReuseIdentifier:@"photoCollectionViewCellIndex"];
    [self addSubview:photoCollectionView];
    
    pageNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake((frameRect.size.width - 120)/2, frameRect.size.height - 18 -24 - TabbarSafeBottomMargin, 120, 24)];
    [pageNumberLabel setTextColor:[UIColor whiteColor]];
    [pageNumberLabel setTextAlignment:NSTextAlignmentCenter];
    [pageNumberLabel setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [pageNumberLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size: 17]];
    int currentPage = 1;
    int sumPage = (int)photoArray.count;
    [pageNumberLabel setText:[NSString stringWithFormat:@"%d/%d",currentPage,sumPage]];
    [self addSubview:pageNumberLabel];

    //新增顶部页码
    pageTopNumLabel = [[UILabel alloc] initWithFrame:CGRectMake((frameRect.size.width - 120)/2, StatusBarSafeTopMargin + 34, 120, 24)];
    [pageTopNumLabel setTextColor:[UIColor whiteColor]];
    [pageTopNumLabel setTextAlignment:NSTextAlignmentCenter];
    [pageTopNumLabel setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [pageTopNumLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size: 17]];
    [pageTopNumLabel setText:[NSString stringWithFormat:@"%d/%d",currentPage,sumPage]];
    [self addSubview:pageTopNumLabel];
    
    //新增转发按钮
    transmitView = [UIView new];
    transmitView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 54 - 5, StatusBarHeight, 54, 44);
    transmitView.backgroundColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1.0];
    transmitView.layer.cornerRadius = 14;
    [self addSubview:transmitView];
    
    transmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    transmitBtn.frame = CGRectMake(16, 11, 22, 22);
    [transmitBtn setImage:[UIImage imageNamed:@"browser_transmit"] forState:UIControlStateNormal];
    [transmitBtn addTarget:self action:@selector(transmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [transmitView addSubview:transmitBtn];
    
    //退出按钮
    UIView *quitView = [UIView new];
    quitView.frame = CGRectMake(5, StatusBarHeight, 54, 44);
    quitView.backgroundColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1.0];
    quitView.layer.cornerRadius = 14;
    [self addSubview:quitView];
    
    quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(18, 13, 18, 18);
    [quitBtn setImage:[UIImage imageNamed:@"browser_quit"] forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(quitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [quitView addSubview:quitBtn];
}

//点击转发按钮
- (void)transmitBtnClick:(UIButton *)sender
{
    if([self.delegate respondsToSelector:@selector(photoBrowser:didClickTransmitBtnAtIndex:)])
    {
        [self.delegate photoBrowser:self didClickTransmitBtnAtIndex:_currentIndex];
    }
}

//点击转发按钮
- (void)quitBtnClick:(UIButton *)sender
{
    if([self.delegate respondsToSelector:@selector(photoBrowser:didClickQuitBtnAtIndex:)])
    {
        [self.delegate photoBrowser:self didClickQuitBtnAtIndex:_currentIndex];
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    if (photoCollectionView.contentOffset.x == 0) {
        int targetIndex = 0;
        if (self.isInfiniteLoop) {
            targetIndex = totalItemsCount * 0.5;
        }
        else {
            targetIndex = 0;
        }
        
        targetIndex += self.currentImgIndex;
        
        if (totalItemsCount > 1) {
            [photoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }
}

- (void)setDisplayPageNumber:(BOOL)displayPageNumber
{
    _displayPageNumber = displayPageNumber;
    [pageNumberLabel setHidden:!displayPageNumber];
}

- (void)setDisplayTopPageNumber:(BOOL)displayTopPageNumber
{
    _displayTopPageNumber = displayTopPageNumber;
    //新增顶部页码
    [pageTopNumLabel setHidden:!displayTopPageNumber];
}

- (void)setDisplayTransmitBtn:(BOOL)displayTransmitBtn
{
    _displayTransmitBtn = displayTransmitBtn;
    //新增删除按钮
    [transmitView setHidden:!displayTransmitBtn];
}

- (void)reloadPageNumberLabel
{
    int currentPage = _currentIndex + 1;
    int sumPage = (int)photoArray.count;
    
//    if (sumPage <= 1) {
//        self.displayPageNumber = NO;
//        self.displayTopPageNumber = NO;
//    }

    [pageNumberLabel setText:[NSString stringWithFormat:@"%d/%d",currentPage,sumPage]];
    
    //新增顶部页码
    [pageTopNumLabel setText:[NSString stringWithFormat:@"%d/%d",currentPage,sumPage]];
}

#pragma mark scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [autoScrollTimer invalidate];
        autoScrollTimer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (photoCollectionView == scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        int indexOnPageControl = (currentPage % (int)photoArray.count)+1;
        int sumPage = (int)photoArray.count;
        
        _currentIndex = indexOnPageControl - 1;
        
        if (self.displayPageNumber) {
            [pageNumberLabel setText:[NSString stringWithFormat:@"%d/%d",indexOnPageControl,sumPage]];
            //新增顶部页码
            [pageTopNumLabel setText:[NSString stringWithFormat:@"%d/%d",indexOnPageControl,sumPage]];
        }
    }
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int row = 0;
    row = totalItemsCount;
    return row;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return frameRect.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int itemIndex = indexPath.item % (int)photoArray.count;
    
    AvalonsoftPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCollectionViewCellIndex" forIndexPath:indexPath];
    
    AvalonsoftPhotoModel *photo = nil;
    photo = [photoArray objectAtIndex:itemIndex];
    [cell reloadCellWith:photo];
    
    if (itemIndex < (int)photoArray.count-1) {
        AvalonsoftPhotoCollectionCell *nextCell = [[AvalonsoftPhotoCollectionCell alloc] init];
        photo = [photoArray objectAtIndex:itemIndex + 1];
        [nextCell reloadCellWith:photo];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.item % (int)photoArray.count;
    if ([self.delegate respondsToSelector:@selector(photoBrowser:didSelectItemAtIndex:)]) {
        [self.delegate photoBrowser:self didSelectItemAtIndex:row];
    }
}

@end
