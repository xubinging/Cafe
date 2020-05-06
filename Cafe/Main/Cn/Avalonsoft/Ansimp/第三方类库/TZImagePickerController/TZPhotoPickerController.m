//
//  TZPhotoPickerController.m
//  TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import "TZPhotoPickerController.h"
#import "TZImagePickerController.h"
#import "TZPhotoPreviewController.h"
#import "TZAssetCell.h"
#import "TZAssetModel.h"
#import "UIView+Layout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TZImageRequestOperation.h"
#import "UIFont+Custom.h"

#define IS_IPHONEX ((int)(MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) == 812)

@implementation TZPhotoPickerAlbumButton

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect titleLabelRect = self.titleLabel.frame;
    CGRect imageRect = self.imageView.frame;
    CGRect rect = self.frame;
    rect.size.width = CGRectGetWidth(titleLabelRect) + CGRectGetWidth(imageRect) + 3 * 2 + 2;
    self.frame = rect;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, CGRectGetWidth(titleLabelRect) + 2, 0, -(CGRectGetWidth(titleLabelRect) + 2));
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(CGRectGetWidth(imageRect) + 2), 0, CGRectGetWidth(imageRect) + 2);
}
@end

@interface TZPhotoPickerController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate> {
    NSMutableArray *_models;
    
    UIView *_bottomToolBar;
    UIButton *_previewButton;
    UIButton *_doneButton;
    UIImageView *_numberImageView;
    UILabel *_numberLabel;
    UIButton *_originalPhotoButton;
    UILabel *_originalPhotoLabel;
    UIView *_divideLine;
    CGRect _collectionViewRect;
    
    BOOL _shouldScrollToBottom;
    BOOL _showTakePhotoBtn;
    
    CGFloat _offsetItemCount;
}
@property CGRect previousPreheatRect;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
@property (nonatomic, strong) TZCollectionView *collectionView;
@property (nonatomic, strong) UILabel *noDataLabel;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

static CGSize AssetGridThumbnailSize;
static CGFloat itemMargin = 5;

@implementation TZPhotoPickerController

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

-(UIButton *)showAlbumButton {
    if (!_showAlbumButton) {
        _showAlbumButton = [TZPhotoPickerAlbumButton buttonWithType:UIButtonTypeCustom];
        _showAlbumButton.titleLabel.font = [UIFont sourceHanSerifWithFontSize:18];
        [_showAlbumButton setTitleColor:[UIColor colorWithRed:70.0 / 255.0 green:76.0 / 255.0 blue:86.0 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_showAlbumButton setTitleColor:[UIColor colorWithRed:70.0 / 255.0 green:76.0 / 255.0 blue:86.0 / 255.0 alpha:1] forState:UIControlStateSelected];
        [_showAlbumButton setImage:[UIImage tz_imageNamedFromMyBundle:@"photo_select_down"] forState:UIControlStateNormal];
        [_showAlbumButton setImage:[UIImage tz_imageNamedFromMyBundle:@"photo_select_up"] forState:UIControlStateSelected];
        [_showAlbumButton setTitle:self.model.name forState:UIControlStateNormal ];
        [_showAlbumButton setTitle:self.model.name forState: UIControlStateSelected];
        [_showAlbumButton sizeToFit];
        [_showAlbumButton addTarget:self action:@selector(showAlbum:) forControlEvents:UIControlEventTouchUpInside];
        _showAlbumButton.hidden = !self.model.name.length;
    }
    
    return _showAlbumButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstAppear = YES;
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    _isSelectOriginalPhoto = tzImagePickerVc.isSelectOriginalPhoto;
    _shouldScrollToBottom = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavigationView];
    
    // [self resetCachedAssets];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeStatusBarOrientationNotification:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 3;
}

- (void)fetchAssetModels {
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    if (_isFirstAppear && !_model.models.count) {
        [[TZImagePickerConfig sharedInstance] showProgressHUD];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (!tzImagePickerVc.sortAscendingByModificationDate && self->_isFirstAppear && self->_model.isCameraRoll && !self->_model) {
            [[TZImageManager manager] getCameraRollAlbum:tzImagePickerVc.allowPickingVideo allowPickingImage:tzImagePickerVc.allowPickingImage needFetchAssets:YES completion:^(TZAlbumModel *model) {
                self->_model = model;
                self->_models = [NSMutableArray arrayWithArray:self->_model.models];
                [self initSubviews];
            }];
        } else {
            if (self->_showTakePhotoBtn || self->_isFirstAppear) {
                [[TZImageManager manager] getAssetsFromFetchResult:self->_model.result completion:^(NSArray<TZAssetModel *> *models) {
                    self->_models = [NSMutableArray arrayWithArray:models];
                    self->_model.models = [NSMutableArray arrayWithArray:models];
                    [self initSubviews];
                }];
            } else {
                self->_models = [NSMutableArray arrayWithArray:self->_model.models];
                [self initSubviews];
            }
        }
    });
}

- (void)initSubviews {
    dispatch_async(dispatch_get_main_queue(), ^{
        TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
        [[TZImagePickerConfig sharedInstance] hideProgressHUD];
        
        self->_showTakePhotoBtn = self->_model.isCameraRoll && ((tzImagePickerVc.allowTakePicture && tzImagePickerVc.allowPickingImage) || (tzImagePickerVc.allowTakeVideo && tzImagePickerVc.allowPickingVideo));
        
        [self checkSelectedModels];
        [self configCollectionView];
        self->_collectionView.hidden = YES;
        if (self->_models.count > 0) [self configBottomToolBar];
        
        [self scrollCollectionViewToBottom];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    tzImagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    TZImagePickerController *tzImagePicker = (TZImagePickerController *)self.navigationController;
    if (tzImagePicker && [tzImagePicker isKindOfClass:[TZImagePickerController class]]) {
        return tzImagePicker.statusBarStyle;
    }
    return [super preferredStatusBarStyle];
}

- (void)configNavigationView{
    
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    NSString *countString = tzImagePickerVc.selectedModels.count ? [NSString stringWithFormat:@" (%zd)",tzImagePickerVc.selectedModels.count] : @"";
    countString = [NSString stringWithFormat:@"%@%@" , tzImagePickerVc.doneBtnTitleStr , countString];
    
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.frame = CGRectMake(0, 0, 70, 44);
    _doneButton.titleLabel.font = [UIFont sourceHanSerifWithFontSize:14];
    _doneButton.contentHorizontalAlignment = NSTextAlignmentRight;
    [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_doneButton setTitle:countString forState:UIControlStateNormal];
    [_doneButton setTitle:countString forState:UIControlStateDisabled];
    [_doneButton setTitleColor:tzImagePickerVc.oKButtonTitleColorNormal forState:UIControlStateNormal];
    [_doneButton setTitleColor:tzImagePickerVc.oKButtonTitleColorDisabled forState:UIControlStateDisabled];
    _doneButton.enabled = tzImagePickerVc.selectedModels.count;
    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
    [rightButtonView addSubview:_doneButton];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 44, 44);
    cancelButton.titleLabel.font = [UIFont sourceHanSerifWithFontSize:14];
    cancelButton.contentHorizontalAlignment = NSTextAlignmentLeft;
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:tzImagePickerVc.cancelBtnTitleStr forState:UIControlStateNormal];
    [cancelButton setTitleColor:tzImagePickerVc.barItemTextColor forState:UIControlStateNormal];
    [cancelButton setTitleColor:tzImagePickerVc.oKButtonTitleColorDisabled forState:UIControlStateDisabled];
    UIView *leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftButtonView addSubview:cancelButton];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
    
    self.navigationItem.leftBarButtonItem = leftCunstomButtonView;
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    self.navigationItem.titleView = self.showAlbumButton;
}

- (void)configCollectionView {
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    
    CGFloat collectionViewHeight = 0;
    CGFloat barHeight = IS_IPHONEX ? 45 + 34 : 45;
    CGFloat top = 0;
    if (self.navigationController.navigationBar.isTranslucent) {
        top = IS_IPHONEX ? 88 : 64;
        collectionViewHeight = tzImagePickerVc.showSelectBtn ? self.view.tz_height - barHeight - top : self.view.tz_height - top;
    } else {
        CGFloat navigationHeight = IS_IPHONEX ? 88 : 44;
        collectionViewHeight = tzImagePickerVc.showSelectBtn ? self.view.tz_height - barHeight - navigationHeight : self.view.tz_height - navigationHeight;
    }
    CGRect viewRect = CGRectMake(0, top, self.view.tz_width, collectionViewHeight);
    CGFloat itemWH = [self fixSlitWith:viewRect colCount:self.columnNumber space:1];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 0;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = 1;
    
    _collectionView = [[TZCollectionView alloc] initWithFrame:_collectionViewRect collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceHorizontal = NO;
    
    if (_showTakePhotoBtn && tzImagePickerVc.allowTakePicture ) {
        _collectionView.contentSize = CGSizeMake(self.view.tz_width, ((_model.count + self.columnNumber) / self.columnNumber) * self.view.tz_width);
    } else {
        CGFloat rows = (_model.count + self.columnNumber - 1) / self.columnNumber;
        CGFloat height = rows * itemWH + (rows + 1) * margin;
        _collectionView.contentSize = CGSizeMake(self.view.tz_width, height);
    }
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZAssetCell class] forCellWithReuseIdentifier:@"TZAssetCell"];
    [_collectionView registerClass:[TZAssetCameraCell class] forCellWithReuseIdentifier:@"TZAssetCameraCell"];
    
    _collectionView.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Determine the size of the thumbnails to request from the PHCachingImageManager
    CGFloat scale = 2.0;
    if ([UIScreen mainScreen].bounds.size.width > 600) {
        scale = 1.0;
    }
    CGSize cellSize = ((UICollectionViewFlowLayout *)_collectionView.collectionViewLayout).itemSize;
    AssetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
    
    if (!_models) {
        [self fetchAssetModels];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // [self updateCachedAssets];
}

- (void)configBottomToolBar {
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    if (!tzImagePickerVc.showSelectBtn) return;
    
    CGFloat barHeight = IS_IPHONEX ? 45 + 34 : 45;
    CGFloat yOffset = 0;
    if (self.navigationController.navigationBar.isTranslucent) {
        yOffset = self.view.tz_height - barHeight;
    } else {
        CGFloat navigationHeight = 44;
        navigationHeight = IS_IPHONEX ? 44 + 44 : 44;
        yOffset = self.view.tz_height - barHeight - navigationHeight;
    }
    
    UIView *bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, yOffset, self.view.tz_width, barHeight)];
    CGFloat rgb = 255 / 255.0;
    bottomToolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _bottomToolBar = bottomToolBar;
    
    CGFloat previewWidth = [tzImagePickerVc.previewBtnTitleStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width + 2;
    if (!tzImagePickerVc.allowPreview) {
        previewWidth = 0.0;
    }
    _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewButton.frame = CGRectMake(self.view.tz_width - previewWidth - 15, 0, previewWidth, 45);
    _previewButton.tz_width = !tzImagePickerVc.showSelectBtn ? 0 : previewWidth;
    [_previewButton addTarget:self action:@selector(previewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _previewButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_previewButton setTitle:tzImagePickerVc.previewBtnTitleStr forState:UIControlStateNormal];
    [_previewButton setTitle:tzImagePickerVc.previewBtnTitleStr forState:UIControlStateDisabled];
    [_previewButton setTitleColor:[UIColor colorWithRed:195/255.0 green:206/255.0  blue:217/255.0  alpha:1] forState:UIControlStateDisabled];
    [_previewButton setTitleColor:[UIColor colorWithRed:70/255.0 green:76/255.0  blue:86/255.0  alpha:1] forState:UIControlStateNormal];
    _previewButton.enabled = tzImagePickerVc.selectedModels.count;
    
    if (tzImagePickerVc.allowPickingOriginalPhoto) {
        CGFloat fullImageWidth = [tzImagePickerVc.fullImageBtnTitleStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
        _originalPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalPhotoButton.frame = CGRectMake(10, 0, fullImageWidth + 56, 45);
        _originalPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_originalPhotoButton addTarget:self action:@selector(originalPhotoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _originalPhotoButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_originalPhotoButton setTitle:tzImagePickerVc.fullImageBtnTitleStr forState:UIControlStateNormal];
        [_originalPhotoButton setTitle:tzImagePickerVc.fullImageBtnTitleStr forState:UIControlStateSelected];
        [_originalPhotoButton setTitleColor:[UIColor colorWithRed:70/255.0 green:76/255.0  blue:86/255.0  alpha:1] forState:UIControlStateNormal];
        [_originalPhotoButton setTitleColor:[UIColor colorWithRed:70/255.0 green:76/255.0  blue:86/255.0  alpha:1] forState:UIControlStateSelected];
        [_originalPhotoButton setImage:[UIImage tz_imageNamedFromMyBundle:tzImagePickerVc.photoOriginDefImageName] forState:UIControlStateNormal];
        [_originalPhotoButton setImage:[UIImage tz_imageNamedFromMyBundle:tzImagePickerVc.photoOriginSelImageName] forState:UIControlStateSelected];
        _originalPhotoButton.selected = _isSelectOriginalPhoto;
        //        _originalPhotoButton.enabled = tzImagePickerVc.selectedModels.count > 0;
        
        _originalPhotoLabel = [[UILabel alloc] init];
        _originalPhotoLabel.frame = CGRectMake(fullImageWidth + 46, 0, 80, 50);
        _originalPhotoLabel.textAlignment = NSTextAlignmentLeft;
        _originalPhotoLabel.font = [UIFont systemFontOfSize:16];
        _originalPhotoLabel.textColor = [UIColor blackColor];
        if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
    }
    
    UIView *divide = [[UIView alloc] init];
    divide.backgroundColor = [UIColor colorWithRed:227/255.0 green:233/255.0 blue:237/255.0 alpha:1];
    divide.frame = CGRectMake(0, 0, self.view.tz_width, 0.5);
    
    [bottomToolBar addSubview:divide];
    [bottomToolBar addSubview:_previewButton];
    [bottomToolBar addSubview:_numberImageView];
    [bottomToolBar addSubview:_originalPhotoButton];
    [self.view addSubview:bottomToolBar];
    
    if (tzImagePickerVc.photoPickerPageUIConfigBlock) {
        tzImagePickerVc.photoPickerPageUIConfigBlock(_collectionView, _bottomToolBar, _previewButton, _originalPhotoButton, _originalPhotoLabel, _doneButton, _numberImageView, _numberLabel, _divideLine);
    }
}

-(void)reloadPhotoCollectionWith:(TZAlbumModel *)model{
    _model = model;
    [self.showAlbumButton setTitle:model.name forState:UIControlStateNormal ];
    [self.showAlbumButton setTitle:model.name forState: UIControlStateSelected];
    self.showAlbumButton.hidden = NO;
    [self fetchAssetModels];
}

#pragma mark - Layout

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//
//    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
//
//    CGFloat top = 0;
//    CGFloat collectionViewHeight = 0;
//    CGFloat naviBarHeight = self.navigationController.navigationBar.tz_height;
//    BOOL isStatusBarHidden = [UIApplication sharedApplication].isStatusBarHidden;
//    BOOL isFullScreen = self.view.tz_height == [UIScreen mainScreen].bounds.size.height;
//    CGFloat toolBarHeight = [TZCommonTools tz_isIPhoneX] ? 50 + (83 - 49) : 50;
//    if (self.navigationController.navigationBar.isTranslucent) {
//        top = naviBarHeight;
//        if (!isStatusBarHidden && isFullScreen) top += [TZCommonTools tz_statusBarHeight];
//        collectionViewHeight = tzImagePickerVc.showSelectBtn ? self.view.tz_height - toolBarHeight - top : self.view.tz_height - top;;
//    } else {
//        collectionViewHeight = tzImagePickerVc.showSelectBtn ? self.view.tz_height - toolBarHeight : self.view.tz_height;
//    }
//    _collectionView.frame = CGRectMake(0, top, self.view.tz_width, collectionViewHeight);
//    _noDataLabel.frame = _collectionView.bounds;
//    CGFloat itemWH = (self.view.tz_width - (self.columnNumber + 1) * itemMargin) / self.columnNumber;
//    _layout.itemSize = CGSizeMake(itemWH, itemWH);
//    _layout.minimumInteritemSpacing = itemMargin;
//    _layout.minimumLineSpacing = itemMargin;
//    [_collectionView setCollectionViewLayout:_layout];
//    if (_offsetItemCount > 0) {
//        CGFloat offsetY = _offsetItemCount * (_layout.itemSize.height + _layout.minimumLineSpacing);
//        [_collectionView setContentOffset:CGPointMake(0, offsetY)];
//    }
//
//    CGFloat toolBarTop = 0;
//    if (!self.navigationController.navigationBar.isHidden) {
//        toolBarTop = self.view.tz_height - toolBarHeight;
//    } else {
//        CGFloat navigationHeight = naviBarHeight + [TZCommonTools tz_statusBarHeight];
//        toolBarTop = self.view.tz_height - toolBarHeight - navigationHeight;
//    }
//    _bottomToolBar.frame = CGRectMake(0, toolBarTop, self.view.tz_width, toolBarHeight);
//
//    CGFloat previewWidth = [tzImagePickerVc.previewBtnTitleStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width + 2;
//    if (!tzImagePickerVc.allowPreview) {
//        previewWidth = 0.0;
//    }
//    _previewButton.frame = CGRectMake(10, 3, previewWidth, 44);
//    _previewButton.tz_width = !tzImagePickerVc.showSelectBtn ? 0 : previewWidth;
//    if (tzImagePickerVc.allowPickingOriginalPhoto) {
//        CGFloat fullImageWidth = [tzImagePickerVc.fullImageBtnTitleStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
//        _originalPhotoButton.frame = CGRectMake(CGRectGetMaxX(_previewButton.frame), 0, fullImageWidth + 56, 50);
//        _originalPhotoLabel.frame = CGRectMake(fullImageWidth + 46, 0, 80, 50);
//    }
//    [_doneButton sizeToFit];
//    _doneButton.frame = CGRectMake(self.view.tz_width - _doneButton.tz_width - 12, 0, _doneButton.tz_width, 50);
//    _numberImageView.frame = CGRectMake(_doneButton.tz_left - 24 - 5, 13, 24, 24);
//    _numberLabel.frame = _numberImageView.frame;
//    _divideLine.frame = CGRectMake(0, 0, self.view.tz_width, 1);
//
//    [TZImageManager manager].columnNumber = [TZImageManager manager].columnNumber;
//    [TZImageManager manager].photoWidth = tzImagePickerVc.photoWidth;
//    [self.collectionView reloadData];
//
//    if (tzImagePickerVc.photoPickerPageDidLayoutSubviewsBlock) {
//        tzImagePickerVc.photoPickerPageDidLayoutSubviewsBlock(_collectionView, _bottomToolBar, _previewButton, _originalPhotoButton, _originalPhotoLabel, _doneButton, _numberImageView, _numberLabel, _divideLine);
//    }
//}

#pragma mark - Notification

- (void)didChangeStatusBarOrientationNotification:(NSNotification *)noti {
    _offsetItemCount = _collectionView.contentOffset.y / (_layout.itemSize.height + _layout.minimumLineSpacing);
}

#pragma mark - Click Event

-(void)showAlbum:(UIButton *)button{
    button.selected = !button.selected;
    [TZAlbumPickerView showAlbumViewWithImagePickerVc:(TZImagePickerController *)self.navigationController complete:^(TZAlbumModel *albumModel) {
        [self.showAlbumButton setTitle:albumModel.name forState:UIControlStateNormal];
        [self.showAlbumButton setTitle:albumModel.name forState:UIControlStateSelected];
        self->_model = albumModel;
        [self fetchAssetModels];
        
    } hidenAlbumViewBlock:^(BOOL endAnimate) {
        button.selected = !endAnimate;
    }];
}

- (void)navLeftBarButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)previewButtonClick {
    TZPhotoPreviewController *photoPreviewVc = [[TZPhotoPreviewController alloc] init];
    [self pushPhotoPrevireViewController:photoPreviewVc needCheckSelectedModels:YES];
}

- (void)originalPhotoButtonClick {
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    if (!_originalPhotoButton.isSelected &&  _isSelectOriginalPhoto == NO) {
        for (int i = 0; i < tzImagePickerVc.selectedModels.count; i++) {
            TZAssetModel *model = tzImagePickerVc.selectedModels[i];
            if (tzImagePickerVc.maxPhotoByte > 0 && model.photoByte > tzImagePickerVc.maxPhotoByte * 1024 * 1024) {
                [tzImagePickerVc showAlertWithTitle:[NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Please select a picture smaller than %zdM"], tzImagePickerVc.maxPhotoByte]];
                _isSelectOriginalPhoto = NO;
                _originalPhotoButton.selected = NO;
                tzImagePickerVc.isSelectOriginalPhoto = NO;
                return;
            }
        }
    }
    _originalPhotoButton.selected = !_originalPhotoButton.isSelected;
    _isSelectOriginalPhoto = _originalPhotoButton.isSelected;
    tzImagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
}

- (void)doneButtonClick {
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    // 1.6.8 判断是否满足最小必选张数的限制
    if (tzImagePickerVc.minImagesCount && tzImagePickerVc.selectedModels.count < tzImagePickerVc.minImagesCount) {
        NSString *title = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Select a minimum of %zd photos"], tzImagePickerVc.minImagesCount];
        [tzImagePickerVc showAlertWithTitle:title];
        return;
    }
    
    if (tzImagePickerVc.isSelectOriginalPhoto) {
        for (TZAssetModel *model in tzImagePickerVc.selectedModels) {
            if (tzImagePickerVc.maxPhotoByte > 0 && model.photoByte > tzImagePickerVc.maxPhotoByte * 1024 * 1024) {
                [tzImagePickerVc showAlertWithTitle:[NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Please select a picture smaller than %zdM"], tzImagePickerVc.maxPhotoByte]];
                _originalPhotoButton.selected = NO;
                _isSelectOriginalPhoto = NO;
                tzImagePickerVc.isSelectOriginalPhoto = NO;
                return;
            }
        }
    }
    
    [[TZImagePickerConfig sharedInstance] showProgressHUD];
    NSMutableArray *assets = [NSMutableArray array];
    NSMutableArray *photos;
    NSMutableArray *infoArr;
    if (tzImagePickerVc.onlyReturnAsset) { // not fetch image
        for (NSInteger i = 0; i < tzImagePickerVc.selectedModels.count; i++) {
            TZAssetModel *model = tzImagePickerVc.selectedModels[i];
            [assets addObject:model.asset];
        }
    } else { // fetch image
        photos = [NSMutableArray array];
        infoArr = [NSMutableArray array];
        for (NSInteger i = 0; i < tzImagePickerVc.selectedModels.count; i++) { [photos addObject:@1];[assets addObject:@1];[infoArr addObject:@1]; }
        
        __block BOOL havenotShowAlert = YES;
        [TZImageManager manager].shouldFixOrientation = YES;
        __block UIAlertController *alertView;
        for (NSInteger i = 0; i < tzImagePickerVc.selectedModels.count; i++) {
            TZAssetModel *model = tzImagePickerVc.selectedModels[i];
            TZImageRequestOperation *operation = [[TZImageRequestOperation alloc] initWithAsset:model.asset completion:^(UIImage * _Nonnull photo, NSDictionary * _Nonnull info, BOOL isDegraded) {
                if (isDegraded) return;
                if (photo) {
                    if (![TZImagePickerConfig sharedInstance].notScaleImage) {
                        photo = [[TZImageManager manager] scaleImage:photo toSize:CGSizeMake(tzImagePickerVc.photoWidth, (int)(tzImagePickerVc.photoWidth * photo.size.height / photo.size.width))];
                    }
                    [photos replaceObjectAtIndex:i withObject:photo];
                }
                if (info)  [infoArr replaceObjectAtIndex:i withObject:info];
                [assets replaceObjectAtIndex:i withObject:model.asset];
                
                for (id item in photos) { if ([item isKindOfClass:[NSNumber class]]) return; }
                
                if (havenotShowAlert) {
                    [tzImagePickerVc hideAlertView:alertView];
                    [self didGetAllPhotos:photos assets:assets infoArr:infoArr];
                }
            } progressHandler:^(double progress, NSError * _Nonnull error, BOOL * _Nonnull stop, NSDictionary * _Nonnull info) {
                // 如果图片正在从iCloud同步中,提醒用户
                if (progress < 1 && havenotShowAlert && !alertView) {
                    [[TZImagePickerConfig sharedInstance] hideProgressHUD];
                    alertView = [tzImagePickerVc showAlertWithTitle:[NSBundle tz_localizedStringForKey:@"Synchronizing photos from iCloud"]];
                    havenotShowAlert = NO;
                    return;
                }
                if (progress >= 1) {
                    havenotShowAlert = YES;
                }
            }];
            [self.operationQueue addOperation:operation];
        }
    }
    if (tzImagePickerVc.selectedModels.count <= 0 || tzImagePickerVc.onlyReturnAsset) {
        [self didGetAllPhotos:photos assets:assets infoArr:infoArr];
    }
}

-(void)cancelButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didGetAllPhotos:(NSArray *)photos assets:(NSArray *)assets infoArr:(NSArray *)infoArr {
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    [[TZImagePickerConfig sharedInstance] hideProgressHUD];
    
    if (tzImagePickerVc.autoDismiss) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [self callDelegateMethodWithPhotos:photos assets:assets infoArr:infoArr];
        }];
    } else {
        [self callDelegateMethodWithPhotos:photos assets:assets infoArr:infoArr];
    }
}

- (void)callDelegateMethodWithPhotos:(NSArray *)photos assets:(NSArray *)assets infoArr:(NSArray *)infoArr {
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    if (tzImagePickerVc.allowPickingVideo && tzImagePickerVc.maxImagesCount == 1) {
        if ([[TZImageManager manager] isVideo:[assets firstObject]]) {
            if ([tzImagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingVideo:sourceAssets:)]) {
                [tzImagePickerVc.pickerDelegate imagePickerController:tzImagePickerVc didFinishPickingVideo:[photos firstObject] sourceAssets:[assets firstObject]];
            }
            if (tzImagePickerVc.didFinishPickingVideoHandle) {
                tzImagePickerVc.didFinishPickingVideoHandle([photos firstObject], [assets firstObject]);
            }
            return;
        }
    }
    
    if ([tzImagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:)]) {
        [tzImagePickerVc.pickerDelegate imagePickerController:tzImagePickerVc didFinishPickingPhotos:photos sourceAssets:assets isSelectOriginalPhoto:_isSelectOriginalPhoto];
    }
    if ([tzImagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:infos:)]) {
        [tzImagePickerVc.pickerDelegate imagePickerController:tzImagePickerVc didFinishPickingPhotos:photos sourceAssets:assets isSelectOriginalPhoto:_isSelectOriginalPhoto infos:infoArr];
    }
    if (tzImagePickerVc.didFinishPickingPhotosHandle) {
        tzImagePickerVc.didFinishPickingPhotosHandle(photos,assets,_isSelectOriginalPhoto);
    }
    if (tzImagePickerVc.didFinishPickingPhotosWithInfosHandle) {
        tzImagePickerVc.didFinishPickingPhotosWithInfosHandle(photos,assets,_isSelectOriginalPhoto,infoArr);
    }
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_showTakePhotoBtn) {
        return _models.count + 1;
    }
    return _models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // the cell lead to take a picture / 去拍照的cell
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    if (((tzImagePickerVc.sortAscendingByModificationDate && indexPath.item >= _models.count) || (!tzImagePickerVc.sortAscendingByModificationDate && indexPath.item == 0)) && _showTakePhotoBtn) {
        TZAssetCameraCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZAssetCameraCell" forIndexPath:indexPath];
        cell.imageView.image = tzImagePickerVc.takePictureImage;
        return cell;
    }
    // the cell dipaly photo or video / 展示照片或视频的cell
    TZAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZAssetCell" forIndexPath:indexPath];
    cell.allowPickingMultipleVideo = tzImagePickerVc.allowPickingMultipleVideo;
    cell.photoDefImage = tzImagePickerVc.photoDefImage;
    cell.photoSelImage = tzImagePickerVc.photoSelImage;
    cell.assetCellDidSetModelBlock = tzImagePickerVc.assetCellDidSetModelBlock;
    cell.assetCellDidLayoutSubviewsBlock = tzImagePickerVc.assetCellDidLayoutSubviewsBlock;
    TZAssetModel *model;
    if (tzImagePickerVc.sortAscendingByModificationDate || !_showTakePhotoBtn) {
        model = _models[indexPath.item];
    } else {
        model = _models[indexPath.item - 1];
    }
    cell.allowPickingGif = tzImagePickerVc.allowPickingGif;
    cell.model = model;
    if (model.isSelected && tzImagePickerVc.showSelectedIndex) {
        cell.index = [tzImagePickerVc.selectedAssetIds indexOfObject:model.asset.localIdentifier] + 1;
    }
    cell.showSelectBtn = tzImagePickerVc.showSelectBtn;
    cell.allowPreview = tzImagePickerVc.allowPreview;
    
    if (tzImagePickerVc.selectedModels.count >= tzImagePickerVc.maxImagesCount && tzImagePickerVc.showPhotoCannotSelectLayer && !model.isSelected) {
        cell.cannotSelectLayerButton.backgroundColor = tzImagePickerVc.cannotSelectLayerColor;
        cell.cannotSelectLayerButton.hidden = NO;
    } else {
        cell.cannotSelectLayerButton.hidden = YES;
    }
    
    __weak typeof(cell) weakCell = cell;
    __weak typeof(self) weakSelf = self;
    __weak typeof(_numberImageView.layer) weakLayer = _numberImageView.layer;
    cell.didSelectPhotoBlock = ^(BOOL isSelected) {
        __strong typeof(weakCell) strongCell = weakCell;
        __strong typeof(weakSelf) strongSelf = weakSelf;
        __strong typeof(weakLayer) strongLayer = weakLayer;
        TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)strongSelf.navigationController;
        // 1. cancel select / 取消选择
        if (isSelected) {
            strongCell.selectPhotoButton.selected = NO;
            model.isSelected = NO;
            NSArray *selectedModels = [NSArray arrayWithArray:tzImagePickerVc.selectedModels];
            for (TZAssetModel *model_item in selectedModels) {
                if ([model.asset.localIdentifier isEqualToString:model_item.asset.localIdentifier]) {
                    [tzImagePickerVc removeSelectedModel:model_item];
                    break;
                }
            }
            [strongSelf refreshBottomToolBarStatus];
            if (tzImagePickerVc.showSelectedIndex || tzImagePickerVc.showPhotoCannotSelectLayer) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TZ_PHOTO_PICKER_RELOAD_NOTIFICATION" object:strongSelf.navigationController];
            }
            [UIView showOscillatoryAnimationWithLayer:strongLayer type:TZOscillatoryAnimationToSmaller];
        } else {
            // 2. select:check if over the maxImagesCount / 选择照片,检查是否超过了最大个数的限制
            if (tzImagePickerVc.selectedModels.count < tzImagePickerVc.maxImagesCount) {
                
                if (tzImagePickerVc.maxImagesCount == 1 && !tzImagePickerVc.allowPreview) {
                    model.isSelected = YES;
                    [tzImagePickerVc addSelectedModel:model];
                    [strongSelf doneButtonClick];
                    return;
                }
                [weakSelf setCellSelectedButtonStateWithModel:model];
//                [UIView showOscillatoryAnimationWithLayer:strongLayer type:TZOscillatoryAnimationToSmaller];
            } else {
                if ([tzImagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerControllerSelectedOverMax:)]) {
                    [tzImagePickerVc.pickerDelegate imagePickerControllerSelectedOverMax:tzImagePickerVc];
                } else {
                    NSString *title = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Select a maximum of %zd photos"], tzImagePickerVc.maxImagesCount];
                    [tzImagePickerVc showAlertWithTitle:title];
                }
            }
        }
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // take a photo / 去拍照
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    if (((tzImagePickerVc.sortAscendingByModificationDate && indexPath.item >= _models.count) || (!tzImagePickerVc.sortAscendingByModificationDate && indexPath.item == 0)) && _showTakePhotoBtn)  {
        [self takePhoto]; return;
    }
    // preview phote or video / 预览照片或视频
    NSInteger index = indexPath.item;
    if (!tzImagePickerVc.sortAscendingByModificationDate && _showTakePhotoBtn) {
        index = indexPath.item - 1;
    }
    TZAssetModel *model = _models[index];
    if (model.type == TZAssetModelMediaTypeVideo && !tzImagePickerVc.allowPickingMultipleVideo) {
        if (tzImagePickerVc.selectedModels.count > 0) {
            TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
            [imagePickerVc showAlertWithTitle:[NSBundle tz_localizedStringForKey:@"Can not choose both video and photo"]];
        } else {
            TZVideoPlayerController *videoPlayerVc = [[TZVideoPlayerController alloc] init];
            videoPlayerVc.model = model;
            [self.navigationController pushViewController:videoPlayerVc animated:YES];
        }
    } else if (model.type == TZAssetModelMediaTypePhotoGif && tzImagePickerVc.allowPickingGif && !tzImagePickerVc.allowPickingMultipleVideo) {
        if (tzImagePickerVc.selectedModels.count > 0) {
            TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
            [imagePickerVc showAlertWithTitle:[NSBundle tz_localizedStringForKey:@"Can not choose both photo and GIF"]];
        } else {
            TZGifPhotoPreviewController *gifPreviewVc = [[TZGifPhotoPreviewController alloc] init];
            gifPreviewVc.model = model;
            [self.navigationController pushViewController:gifPreviewVc animated:YES];
        }
    } else {
        TZPhotoPreviewController *photoPreviewVc = [[TZPhotoPreviewController alloc] init];
        photoPreviewVc.currentIndex = index;
        photoPreviewVc.models = _models;
        [self pushPhotoPrevireViewController:photoPreviewVc];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // [self updateCachedAssets];
}

#pragma mark - Private Method

- (CGFloat)fixSlitWith:(CGRect)rect colCount:(CGFloat)colCount space:(CGFloat)space {
    CGFloat totalSpace = (colCount - 1) * space;
    CGFloat itemWidth = (rect.size.width - totalSpace) / colCount;
    CGFloat fixValue = 1 / [UIScreen mainScreen].scale;
    CGFloat realItemWidth = floor(itemWidth) + fixValue;
    if (realItemWidth < itemWidth) {
        realItemWidth += fixValue;
    }
    CGFloat realWidth = colCount * realItemWidth + totalSpace;
    CGFloat pointX = (realWidth - rect.size.width) / 2;
    rect.origin.x = -pointX;
    rect.size.width = realWidth;
    _collectionViewRect = rect;
    return realItemWidth;
}

/// 拍照按钮点击事件
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) {
        
        NSDictionary *infoDict = [TZCommonTools tz_getInfoDictionary];
        // 无权限 做一个友好的提示
        NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
        if (!appName) appName = [infoDict valueForKey:@"CFBundleExecutable"];

        NSString *message = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Please allow %@ to access your camera in \"Settings -> Privacy -> Camera\""],appName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSBundle tz_localizedStringForKey:@"Can not use camera"] message:message delegate:self cancelButtonTitle:[NSBundle tz_localizedStringForKey:@"Cancel"] otherButtonTitles:[NSBundle tz_localizedStringForKey:@"Setting"], nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self pushImagePickerController];
                });
            }
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    if (tzImagePickerVc.allowCameraLocation) {
        __weak typeof(self) weakSelf = self;
        [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.location = [locations firstObject];
        } failureBlock:^(NSError *error) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.location = nil;
        }];
    }
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: sourceType]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (tzImagePickerVc.allowTakePicture) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if (tzImagePickerVc.allowTakeVideo) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
            self.imagePickerVc.videoMaximumDuration = tzImagePickerVc.videoMaximumDuration;
        }
        self.imagePickerVc.mediaTypes= mediaTypes;
        if (tzImagePickerVc.uiImagePickerControllerSettingBlock) {
            tzImagePickerVc.uiImagePickerControllerSettingBlock(_imagePickerVc);
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)refreshBottomToolBarStatus {
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    
    _previewButton.enabled = tzImagePickerVc.selectedModels.count > 0;
    _doneButton.enabled = tzImagePickerVc.selectedModels.count;
    
    NSString *countString = tzImagePickerVc.selectedModels.count ? [NSString stringWithFormat:@" (%zd)",tzImagePickerVc.selectedModels.count] : @"";
    [_doneButton setTitle:[NSString stringWithFormat:@"%@%@" , tzImagePickerVc.doneBtnTitleStr , countString] forState:UIControlStateNormal];
    [_doneButton setTitle:[NSString stringWithFormat:@"%@%@" , tzImagePickerVc.doneBtnTitleStr , countString] forState:UIControlStateDisabled];
    
    //    _originalPhotoButton.enabled = tzImagePickerVc.selectedModels.count > 0;
    _originalPhotoButton.selected = (_isSelectOriginalPhoto && _originalPhotoButton.enabled);
    _originalPhotoLabel.hidden = (!_originalPhotoButton.isSelected);
    if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
    
    if (tzImagePickerVc.photoPickerPageDidRefreshStateBlock) {
        tzImagePickerVc.photoPickerPageDidRefreshStateBlock(_collectionView, _bottomToolBar, _previewButton, _originalPhotoButton, _originalPhotoLabel, _doneButton, _numberImageView, _numberLabel, _divideLine);;
    }
}

- (void)pushPhotoPrevireViewController:(TZPhotoPreviewController *)photoPreviewVc {
    [self pushPhotoPrevireViewController:photoPreviewVc needCheckSelectedModels:NO];
}

- (void)pushPhotoPrevireViewController:(TZPhotoPreviewController *)photoPreviewVc needCheckSelectedModels:(BOOL)needCheckSelectedModels {
    __weak typeof(self) weakSelf = self;
    photoPreviewVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    [photoPreviewVc setBackButtonClickBlock:^(BOOL isSelectOriginalPhoto) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
        if (needCheckSelectedModels) {
            [strongSelf checkSelectedModels];
        }
        [strongSelf.collectionView reloadData];
        [strongSelf refreshBottomToolBarStatus];
    }];
    [photoPreviewVc setDoneButtonClickBlock:^(BOOL isSelectOriginalPhoto) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
        [strongSelf doneButtonClick];
    }];
    [photoPreviewVc setDoneButtonClickBlockCropMode:^(UIImage *cropedImage, id asset) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf didGetAllPhotos:@[cropedImage] assets:@[asset] infoArr:nil];
    }];
    [self.navigationController pushViewController:photoPreviewVc animated:YES];
}

- (void)getSelectedPhotoBytes {
    // 越南语 && 5屏幕时会显示不下，暂时这样处理
    if ([[TZImagePickerConfig sharedInstance].preferredLanguage isEqualToString:@"vi"] && self.view.tz_width <= 320) {
        return;
    }
    TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
    [[TZImageManager manager] getPhotosBytesWithArray:imagePickerVc.selectedModels completion:^(NSString *totalBytes) {
        self->_originalPhotoLabel.text = [NSString stringWithFormat:@"(%@)",totalBytes];
    }];
}

- (void)scrollCollectionViewToBottom {
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    if (_shouldScrollToBottom && _models.count > 0) {
        NSInteger item = 0;
        if (tzImagePickerVc.sortAscendingByModificationDate) {
            item = _models.count - 1;
            if (_showTakePhotoBtn) {
                item += 1;
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self->_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
            self->_shouldScrollToBottom = NO;
            self->_collectionView.hidden = NO;
        });
    } else {
        _collectionView.hidden = NO;
    }
}

-(void)setCellSelectedButtonStateWithModel:(TZAssetModel *)model{
    if (model.photoByte > 0) {
        [self compareImageSizeWithModel:model];
    } else {
        [[TZImageManager manager] getPhotoBytesWithModel:model completion:^(NSInteger photoByte) {
            model.photoByte = photoByte;
            [self compareImageSizeWithModel:model];
        }];
    }
}

-(void)compareImageSizeWithModel:(TZAssetModel *)model{
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    if (_originalPhotoButton.isSelected) { //勾选了原图
        if (tzImagePickerVc.maxPhotoByte > 0 && model.photoByte > tzImagePickerVc.maxPhotoByte * 1024 * 1024) {
            [tzImagePickerVc showAlertWithTitle:[NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Please select a picture smaller than %zdM"], tzImagePickerVc.maxPhotoByte]];
            return;
        }
    }
    [self refreshToolBarCollectionViewWithModel:model];
}

-(void)refreshToolBarCollectionViewWithModel:(TZAssetModel *)model{
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    model.isSelected = YES;
    [tzImagePickerVc addSelectedModel:model];
    if (tzImagePickerVc.showSelectedIndex || tzImagePickerVc.showPhotoCannotSelectLayer) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TZ_PHOTO_PICKER_RELOAD_NOTIFICATION" object:self.navigationController];
    }
    [self refreshBottomToolBarStatus];
    if (tzImagePickerVc.selectedModels.count == tzImagePickerVc.maxImagesCount) {
        [self.collectionView reloadData];
    } else {
        [self.collectionView reloadItemsAtIndexPaths:self.collectionView.indexPathsForVisibleItems];
    }
}

- (void)checkSelectedModels {
    NSMutableArray *selectedAssets = [NSMutableArray array];
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    for (TZAssetModel *model in tzImagePickerVc.selectedModels) {
        [selectedAssets addObject:model.asset];
    }
    for (TZAssetModel *model in _models) {
        model.isSelected = NO;
        if ([selectedAssets containsObject:model.asset]) {
            model.isSelected = YES;
        }
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
        [[TZImagePickerConfig sharedInstance] showProgressHUD];
        UIImage *photo = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *meta = [info objectForKey:UIImagePickerControllerMediaMetadata];
        if (photo) {
            [[TZImageManager manager] savePhotoWithImage:photo meta:meta location:self.location completion:^(PHAsset *asset, NSError *error){
                if (!error) {
                    [self addPHAsset:asset];
                }
            }];
            self.location = nil;
        }
    } else if ([type isEqualToString:@"public.movie"]) {
        TZImagePickerController *imagePickerVc = (TZImagePickerController *)self.navigationController;
        [[TZImagePickerConfig sharedInstance] showProgressHUD];
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                if (!error) {
                    [self addPHAsset:asset];
                }
            }];
            self.location = nil;
        }
    }
}

- (void)addPHAsset:(PHAsset *)asset {
    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    [[TZImagePickerConfig sharedInstance] hideProgressHUD];
    if (tzImagePickerVc.sortAscendingByModificationDate) {
        [_models addObject:assetModel];
    } else {
        [_models insertObject:assetModel atIndex:0];
    }
    
    if (tzImagePickerVc.maxImagesCount <= 1) {
        if (tzImagePickerVc.allowCrop && asset.mediaType == PHAssetMediaTypeImage) {
            TZPhotoPreviewController *photoPreviewVc = [[TZPhotoPreviewController alloc] init];
            if (tzImagePickerVc.sortAscendingByModificationDate) {
                photoPreviewVc.currentIndex = _models.count - 1;
            } else {
                photoPreviewVc.currentIndex = 0;
            }
            photoPreviewVc.models = _models;
            [self pushPhotoPrevireViewController:photoPreviewVc];
        } else {
            [tzImagePickerVc addSelectedModel:assetModel];
            [self doneButtonClick];
        }
        return;
    }
    
    if (tzImagePickerVc.selectedModels.count < tzImagePickerVc.maxImagesCount) {
        if (assetModel.type == TZAssetModelMediaTypeVideo && !tzImagePickerVc.allowPickingMultipleVideo) {
            // 不能多选视频的情况下，不选中拍摄的视频
        } else {
            assetModel.isSelected = YES;
            [tzImagePickerVc addSelectedModel:assetModel];
            [self refreshBottomToolBarStatus];
        }
    }
    _collectionView.hidden = YES;
    [_collectionView reloadData];
    
    _shouldScrollToBottom = YES;
    [self scrollCollectionViewToBottom];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

#pragma mark - Asset Caching

- (void)resetCachedAssets {
    [[TZImageManager manager].cachingImageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets {
    BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
    if (!isViewVisible) { return; }
    
    // The preheat window is twice the height of the visible rect.
    CGRect preheatRect = _collectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
    
    /*
     Check if the collection view is showing an area that is significantly
     different to the last preheated area.
     */
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    if (delta > CGRectGetHeight(_collectionView.bounds) / 3.0f) {
        
        // Compute the assets to start caching and to stop caching.
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            NSArray *indexPaths = [self aapl_indexPathsForElementsInRect:removedRect];
            [removedIndexPaths addObjectsFromArray:indexPaths];
        } addedHandler:^(CGRect addedRect) {
            NSArray *indexPaths = [self aapl_indexPathsForElementsInRect:addedRect];
            [addedIndexPaths addObjectsFromArray:indexPaths];
        }];
        
        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
        
        // Update the assets the PHCachingImageManager is caching.
        [[TZImageManager manager].cachingImageManager startCachingImagesForAssets:assetsToStartCaching
                                                                       targetSize:AssetGridThumbnailSize
                                                                      contentMode:PHImageContentModeAspectFill
                                                                          options:nil];
        [[TZImageManager manager].cachingImageManager stopCachingImagesForAssets:assetsToStopCaching
                                                                      targetSize:AssetGridThumbnailSize
                                                                     contentMode:PHImageContentModeAspectFill
                                                                         options:nil];
        
        // Store the preheat rect to compare against in the future.
        self.previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler {
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    } else {
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths {
    if (indexPaths.count == 0) { return nil; }
    
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        if (indexPath.item < _models.count) {
            TZAssetModel *model = _models[indexPath.item];
            [assets addObject:model.asset];
        }
    }
    
    return assets;
}

- (NSArray *)aapl_indexPathsForElementsInRect:(CGRect)rect {
    NSArray *allLayoutAttributes = [_collectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
    if (allLayoutAttributes.count == 0) { return nil; }
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:allLayoutAttributes.count];
    for (UICollectionViewLayoutAttributes *layoutAttributes in allLayoutAttributes) {
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}
#pragma clang diagnostic pop

@end



@implementation TZCollectionView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
