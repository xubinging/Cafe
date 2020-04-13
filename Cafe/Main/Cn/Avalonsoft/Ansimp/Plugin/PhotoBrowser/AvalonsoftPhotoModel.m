//
//  AvalonsoftPhotoModel.m
//  Cafe
//
//  Created by leo on 2020/2/10.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftPhotoModel.h"

@implementation AvalonsoftPhotoModel

+ (AvalonsoftPhotoModel *)photoWithImage:(UIImage *)image {
    return [[AvalonsoftPhotoModel alloc] initWithImage:image];
}

+ (AvalonsoftPhotoModel *)photoWithURL:(NSURL *)url {
    return [[AvalonsoftPhotoModel alloc] initWithURL:url];
}

- (id)initWithImage:(UIImage *)image {
    if ((self = [super init])) {
        _image = image;
    }
    return self;
}

- (id)initWithURL:(NSURL *)url {
    if ((self = [super init])) {
        _photoURL = [url copy];
    }
    return self;
}

@end
