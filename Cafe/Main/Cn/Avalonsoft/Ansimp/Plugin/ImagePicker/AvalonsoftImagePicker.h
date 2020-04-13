//
//  AvalonsoftImagePicker.h
//  Cafe
//
//  Created by leo on 2020/1/3.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AvalonsoftImagePickerFinishAction)(UIImage *image);

@interface AvalonsoftImagePicker : NSObject

/**
 @param viewController  用于present UIImagePickerController对象
 @param allowsEditing   是否允许用户编辑图像
 */
+ (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(AvalonsoftImagePickerFinishAction)finishAction;

@end

NS_ASSUME_NONNULL_END
