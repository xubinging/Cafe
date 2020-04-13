//
//  AvalonsoftPhotoModel.h
//  Cafe
//
//  Created by leo on 2020/2/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftPhotoModel : NSObject

@property (nonatomic,strong) NSString *caption;     //说明文字
@property (nonatomic,readonly) UIImage *image;      //本地图片
@property (nonatomic,readonly) NSURL *photoURL;     //网络图片url

+ (AvalonsoftPhotoModel *)photoWithImage:(UIImage *)image;
+ (AvalonsoftPhotoModel *)photoWithURL:(NSURL *)url;

- (id)initWithImage:(UIImage *)image;
- (id)initWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
