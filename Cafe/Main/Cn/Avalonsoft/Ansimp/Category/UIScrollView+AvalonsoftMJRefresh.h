//
//  UIScrollView+AvalonsoftMJRefresh.h
//  Cafe
//
//  Created by leo on 2020/3/10.
//  Copyright © 2020 leo. All rights reserved.
//
//  二次封装的 MJRefresh

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (AvalonsoftMJRefresh)

/**
 下拉刷新

 @param beginRefresh    是否自动刷新
 @param animation       是否需要动画
 @param refreshBlock    刷新回调
 */
- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh
                                  animation:(BOOL)animation
                               refreshBlock:(void(^)(NSInteger pageIndex))refreshBlock;


/**
 上拉加载

 @param automaticallyRefresh    是否自动加载
 @param loadMoreBlock           加载回调
 */
- (void)addFooterWithWithHeaderWithAutomaticallyRefresh:(BOOL)automaticallyRefresh
                                          loadMoreBlock:(void(^)(NSInteger pageIndex))loadMoreBlock;


/**
 普通请求结束刷新
 */
- (void)endFooterRefresh;


/**
 没有数据结束刷新
 */
- (void)endFooterNoMoreData;

@end

NS_ASSUME_NONNULL_END
