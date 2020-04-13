//
//  AvalonsoftImagePicker.m
//  Cafe
//
//  Created by leo on 2020/1/3.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Photos/Photos.h>                   //判断相册权限 -- ios8之后的判断方式
#import <AVFoundation/AVCaptureDevice.h>    //判断相机权限
#import <AVFoundation/AVMediaFormat.h>      //判断相机权限

#import "AvalonsoftImagePicker.h"

@interface AvalonsoftImagePicker()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, copy) AvalonsoftImagePickerFinishAction finishAction;
@property (nonatomic, assign) BOOL allowsEditing;

@end

static AvalonsoftImagePicker *avalonsoftImagePickerInstance = nil;

@implementation AvalonsoftImagePicker

+ (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(AvalonsoftImagePickerFinishAction)finishAction
{
    if (avalonsoftImagePickerInstance == nil) {
        avalonsoftImagePickerInstance = [[AvalonsoftImagePicker alloc] init];
    }
    
    [avalonsoftImagePickerInstance showImagePickerFromViewController:viewController
                                                       allowsEditing:allowsEditing
                                                        finishAction:finishAction];
}

- (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(AvalonsoftImagePickerFinishAction)finishAction {
    _viewController = viewController;
    _finishAction = finishAction;
    _allowsEditing = allowsEditing;
    
    AvalonsoftActionSheet *actionSheet = [[AvalonsoftActionSheet alloc] initSheetWithTitle:@"" style:AvalonsoftSheetStyleDefault itemTitles:@[@"拍摄",@"相册"]];
    actionSheet.itemTextColor = RGBA_GGCOLOR(102, 102, 102, 1);
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        
        if(index == 0){
            //拍照，先判断用户有没有授权
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
                //无权限，做一个友好的提示
                [AvalonsoftMsgAlertView showWithTitle:@"温馨提示" content:@"请您设置允许APP访问您的相机\n设置>隐私>相机" buttonTitles:@[@"确定"] buttonClickedBlock:nil];
                return;
                
            } else {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.allowsEditing = self->_allowsEditing;
                
                //ios13需要手动设置打开方式为全屏
                picker.modalPresentationStyle = UIModalPresentationFullScreen;
                [self->_viewController presentViewController:picker animated:YES completion:nil];
            }
            
        }else if(index == 1){
            //从相册选择，先判断用户有没有授权
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
                //无权限，做一个友好的提示
                [AvalonsoftMsgAlertView showWithTitle:@"温馨提示" content:@"请您设置允许APP访问您的相册\n设置>隐私>照片" buttonTitles:@[@"确定"] buttonClickedBlock:nil];
                return;
                
            }else{
                //从相册选择
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                
                //ios13需要手动设置打开方式为全屏
                picker.modalPresentationStyle = UIModalPresentationFullScreen;
                [self->_viewController presentViewController:picker animated:YES completion:nil];
            }
            
        }
    }];
    
}

#pragma mark - 选择图片回调 -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    if (_finishAction) {
        _finishAction(image);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    avalonsoftImagePickerInstance = nil;
}

#pragma mark - 点击取消按钮 -
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIImage *image = nil;
    if (_finishAction) {
        _finishAction(image);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    avalonsoftImagePickerInstance = nil;
}

@end
