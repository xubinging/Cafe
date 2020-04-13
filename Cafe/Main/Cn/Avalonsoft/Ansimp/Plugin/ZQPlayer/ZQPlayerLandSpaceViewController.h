//
//  ZQPlayerLandSpaceViewController.h
//  Cafe
//
//  Created by 孙怡 on 2020/3/12.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQPlayerLandSpaceViewController : UIViewController

/**
 是否为Wi-Fi环境 (默认为YES)
 若为YES则会自动播放视频，如果NO，则会弹出提示框给用户进行选择
 建议获取用户网络环境，若是移动环境则设置为NO，其他设置为YES
 */
@property (nonatomic, assign) BOOL isWiFi;

/**
 视频播放地址
 */
@property (nonatomic, copy) NSString *videoUrl;

/**
 视频标题
 */
@property (nonatomic, copy) NSString *videoTitle;

@end

NS_ASSUME_NONNULL_END
