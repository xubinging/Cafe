//
//  AvalonsoftPhotoCollectionCell.h
//  Cafe
//
//  Created by leo on 2020/2/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvalonsoftTapImageView.h"
#import "AvalonsoftPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftPhotoCollectionCell : UICollectionViewCell<UIScrollViewDelegate,AvalonsoftTapImageViewDelegate>
{
    CGRect frameRect;
}

@property(nonatomic,strong) AvalonsoftTapImageView *photoView;
@property(nonatomic,strong) UIScrollView *imgScrollView;
@property(nonatomic,strong) UIActivityIndicatorView *loadingIndicator;

- (void)reloadCellWith:(AvalonsoftPhotoModel*)photo;

@end

NS_ASSUME_NONNULL_END
