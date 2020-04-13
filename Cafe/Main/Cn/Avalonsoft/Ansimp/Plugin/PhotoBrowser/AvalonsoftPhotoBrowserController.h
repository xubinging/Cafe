//
//  AvalonsoftPhotoBrowserController.h
//  Cafe
//
//  Created by leo on 2020/2/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvalonsoftPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftPhotoBrowserController : UIViewController

@property (nonatomic,strong)NSMutableArray *imgArray;
@property (nonatomic,assign)int currentImgIndex;

// 是否显示顶部页码(显示顶部,则底部隐藏)
@property (nonatomic,assign) BOOL displayTopPage;

// 是否显示转发按钮(默认不显示)
@property (nonatomic,assign) BOOL displayTransmitBtn;

// 单击退出浏览
- (void)singleTapDetected;

@end

NS_ASSUME_NONNULL_END
