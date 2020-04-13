//
//  AvalonsoftPhotoBrowserView.h
//  Cafe
//
//  Created by leo on 2020/2/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AvalonsoftPhotoBrowserView;
@protocol AvalonsoftPhotoBrowserViewDelegate <NSObject>
@optional
//点击某一张图片
- (void)photoBrowser:(AvalonsoftPhotoBrowserView *)photoBrowser didSelectItemAtIndex:(NSInteger)index;
//点击转发按钮
- (void)photoBrowser:(AvalonsoftPhotoBrowserView *)photoBrowser didClickTransmitBtnAtIndex:(NSInteger)index;
//点击退出按钮
- (void)photoBrowser:(AvalonsoftPhotoBrowserView *)photoBrowser didClickQuitBtnAtIndex:(NSInteger)index;
@end

@interface AvalonsoftPhotoBrowserView : UIView<UICollectionViewDataSource,UIScrollViewAccessibilityDelegate,UICollectionViewDelegateFlowLayout>

{
    CGRect frameRect;
    
    UICollectionView *photoCollectionView;
    NSMutableArray *photoArray;
    int totalItemsCount;
    
    UILabel *pageNumberLabel;
    UILabel *pageTopNumLabel;
    NSTimer *autoScrollTimer;
    
    UIButton *quitBtn;          //退出按钮
    
    UIView *transmitView;       //转发视图
    UIButton *transmitBtn;      //转发按钮
}
@property (nonatomic,assign) BOOL displayTransmitBtn;       //是否显示转发
@property (nonatomic,assign) BOOL displayTopPageNumber;     //是否显示顶部页码
@property (nonatomic,assign) BOOL displayPageNumber;        //是否显示下方页码

@property (nonatomic,assign) CGFloat padding;               //间隔
@property (nonatomic,assign) BOOL isInfiniteLoop;           //是否无限循环
@property (nonatomic,assign) BOOL autoScroll;               //是否自动滚动
@property (nonatomic,assign) CGFloat autoScrollTimeInterval;

@property (nonatomic,assign)int currentImgIndex;        //移动到第几个图片 从1开始
@property (nonatomic, weak) id<AvalonsoftPhotoBrowserViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame Photos:(NSMutableArray*)array;

- (void)reloadPhotoBrowseWithPhotoArray:(NSMutableArray*)array;

@end

NS_ASSUME_NONNULL_END
