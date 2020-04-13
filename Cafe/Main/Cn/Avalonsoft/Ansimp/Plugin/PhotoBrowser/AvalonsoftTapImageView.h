//
//  AvalonsoftTapImageView.h
//  Cafe
//
//  Created by leo on 2020/2/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AvalonsoftTapImageViewDelegate;

@interface AvalonsoftTapImageView : UIImageView
@property (nonatomic, weak) id<AvalonsoftTapImageViewDelegate> delegate;
@end

@protocol AvalonsoftTapImageViewDelegate <NSObject>
@optional
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;  //单击
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;  //双击
- (void)imageView:(UIImageView *)imageView tripleTapDetected:(UITouch *)touch;  //三击
@end

NS_ASSUME_NONNULL_END
