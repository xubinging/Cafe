//
//  UIImage+shareManager.h
//  CMRead-iPhone
//
//  Created by Yrl on 15/7/24.
//  Copyright (c) 2015年 CMRead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (shareManager)

-(UIImage*)scaleToSize:(CGSize)size;

- (NSData *)compressImageToMaxFileSize:(NSUInteger)maxLength;


@end
