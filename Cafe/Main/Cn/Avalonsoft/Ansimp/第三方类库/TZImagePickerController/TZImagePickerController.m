//
//  TZImagePickerController.m
//  TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//  version 3.2.6 - 2019.10.21
//  更多信息，请前往项目的github地址：https://github.com/banchichen/TZImagePickerController

#import "TZImagePickerController.h"
#import "TZPhotoPickerController.h"
#import "TZPhotoPreviewController.h"
#import "TZAssetModel.h"
#import "TZAssetCell.h"
#import "UIView+Layout.h"
#import "TZImageManager.h"
#import "MBProgressHUD.h"
#import "UIFont+Custom.h"

@interface TZImagePickerController () {
    NSTimer *_timer;
    UILabel *_tipLabel;
    UIButton *_settingBtn;
    BOOL _pushPhotoPickerVc;
    BOOL _didPushPhotoPickerVc;
    CGRect _cropRect;
    
    UIButton *_progressHUD;
    UIView *_HUDContainer;
    UIActivityIndicatorView *_HUDIndicatorView;
    UILabel *_HUDLabel;
    
    UIStatusBarStyle _originStatusBarStyle;
}
/// Default is 4, Use in photos collectionView in TZPhotoPickerController
/// 默认4列, TZPhotoPickerController中的照片collectionView
@property (nonatomic, assign) NSInteger columnNumber;
@end

@implementation TZImagePickerController

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [self initWithMaxImagesCount:9 delegate:nil];
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)viewDidLoad {
    [super viewDidLoad];
    self.needShowStatusBar = ![UIApplication sharedApplication].statusBarHidden;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = YES;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationBar.tz_height - 0.5, self.navigationBar.tz_width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:227/255.0 green:233/255.0 blue:237/255.0 alpha:1];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.navigationBar addSubview:lineView];
    
    [TZImageManager manager].shouldFixOrientation = NO;

    // Default appearance, you can reset these after this method
    // 默认的外观，你可以在这个方法后重置
    self.oKButtonTitleColorNormal   = [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:1.0];
    self.oKButtonTitleColorDisabled = [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:0.5];
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.needShowStatusBar) [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)setNaviBgColor:(UIColor *)naviBgColor {
    _naviBgColor = naviBgColor;
    self.navigationBar.barTintColor = naviBgColor;
}

- (void)setNaviTitleColor:(UIColor *)naviTitleColor {
    _naviTitleColor = naviTitleColor;
    [self configNaviTitleAppearance];
}

- (void)setNaviTitleFont:(UIFont *)naviTitleFont {
    _naviTitleFont = naviTitleFont;
    [self configNaviTitleAppearance];
}

- (void)configNaviTitleAppearance {
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    if (self.naviTitleColor) {
        textAttrs[NSForegroundColorAttributeName] = self.naviTitleColor;
    }
    if (self.naviTitleFont) {
        textAttrs[NSFontAttributeName] = self.naviTitleFont;
    }
    self.navigationBar.titleTextAttributes = textAttrs;
}

- (void)setBarItemTextFont:(UIFont *)barItemTextFont {
    _barItemTextFont = barItemTextFont;
    [self configBarButtonItemAppearance];
}

- (void)setBarItemTextColor:(UIColor *)barItemTextColor {
    _barItemTextColor = barItemTextColor;
    [self configBarButtonItemAppearance];
}

- (void)setIsStatusBarDefault:(BOOL)isStatusBarDefault {
    _isStatusBarDefault = isStatusBarDefault;
    
    if (isStatusBarDefault) {
        self.statusBarStyle = UIStatusBarStyleDefault;
    } else {
        self.statusBarStyle = UIStatusBarStyleLightContent;
    }
}

- (void)configBarButtonItemAppearance {
    UIBarButtonItem *barItem;
    if (@available(iOS 9, *)) {
        barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
    } else {
        barItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
    }
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = self.barItemTextColor;
    textAttrs[NSFontAttributeName] = self.barItemTextFont;
    [barItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _originStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    [UIApplication sharedApplication].statusBarStyle = self.statusBarStyle;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = _originStatusBarStyle;
    [[TZImagePickerConfig sharedInstance] hideProgressHUD];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<TZImagePickerControllerDelegate>)delegate {
    return [self initWithMaxImagesCount:maxImagesCount columnNumber:4 delegate:delegate pushPhotoPickerVc:YES];
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<TZImagePickerControllerDelegate>)delegate {
    return [self initWithMaxImagesCount:maxImagesCount columnNumber:columnNumber delegate:delegate pushPhotoPickerVc:YES];
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<TZImagePickerControllerDelegate>)delegate pushPhotoPickerVc:(BOOL)pushPhotoPickerVc {
    _pushPhotoPickerVc = pushPhotoPickerVc;
    TZPhotoPickerController *photoPickerVc = [[TZPhotoPickerController alloc] init];
    photoPickerVc.isFirstAppear = YES;
    photoPickerVc.columnNumber = columnNumber;
    self = [super initWithRootViewController:photoPickerVc];
    if (self) {
        self.maxImagesCount = maxImagesCount > 0 ? maxImagesCount : 9; // Default is 9 / 默认最大可选9张图片
        self.pickerDelegate = delegate;
        self.selectedAssets = [NSMutableArray array];
        
        // Allow user picking original photo and video, you also can set No after this method
        // 默认准许用户选择原图和视频, 你也可以在这个方法后置为NO
        self.allowPickingOriginalPhoto = YES;
        self.allowPickingVideo = NO;
        self.allowPickingImage = YES;
        self.allowTakePicture = YES;
        self.allowTakeVideo = NO;
        self.videoMaximumDuration = 10 * 60;
        self.sortAscendingByModificationDate = NO;
        self.autoDismiss = YES;
        self.columnNumber = columnNumber;
        [self configDefaultSetting];
        
        if (![[TZImageManager manager] authorizationStatusAuthorized]) {
            _tipLabel = [[UILabel alloc] init];
            _tipLabel.frame = CGRectMake(8, 120, self.view.tz_width - 16, 60);
            _tipLabel.textAlignment = NSTextAlignmentCenter;
            _tipLabel.numberOfLines = 0;
            _tipLabel.font = [UIFont systemFontOfSize:16];
            _tipLabel.textColor = [UIColor blackColor];
            
            NSDictionary *infoDict = [TZCommonTools tz_getInfoDictionary];
            NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
            if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
            if (!appName) appName = [infoDict valueForKey:@"CFBundleExecutable"];
            if (!(appName && [appName isKindOfClass:NSString.class] && appName.length > 0)) appName = [NSBundle tz_localizedStringForKey:@"AppName"];
            NSString *tipText = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Allow %@ to access your album in \"Settings -> Privacy -> Photos\""],appName];
            _tipLabel.text = tipText;
            [self.view addSubview:_tipLabel];
            
            _settingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [_settingBtn setTitle:self.settingBtnTitleStr forState:UIControlStateNormal];
            _settingBtn.frame = CGRectMake(0, 180, self.view.tz_width, 44);
            _settingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            [_settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_settingBtn];

            photoPickerVc.showAlbumButton.hidden = YES;
            
            if ([PHPhotoLibrary authorizationStatus] == 0) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(observeAuthrizationStatusChange) userInfo:nil repeats:NO];
            }
        } else {
            [[TZImageManager manager] getCameraRollAlbum:self.allowPickingVideo allowPickingImage:self.allowPickingImage needFetchAssets:NO completion:^(TZAlbumModel *model) {
                photoPickerVc.model = model;
            }];
        }
    }
    return self;
}

/// This init method just for previewing photos / 用这个初始化方法以预览图片
- (instancetype)initWithSelectedAssets:(NSMutableArray *)selectedAssets selectedPhotos:(NSMutableArray *)selectedPhotos index:(NSInteger)index{
    TZPhotoPreviewController *previewVc = [[TZPhotoPreviewController alloc] init];
    self = [super initWithRootViewController:previewVc];
    if (self) {
        self.selectedAssets = [NSMutableArray arrayWithArray:selectedAssets];
        self.allowPickingOriginalPhoto = self.allowPickingOriginalPhoto;
        [self configDefaultSetting];
        
        previewVc.photos = [NSMutableArray arrayWithArray:selectedPhotos];
        previewVc.currentIndex = index;
        __weak typeof(self) weakSelf = self;
        [previewVc setDoneButtonClickBlockWithPreviewType:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf dismissViewControllerAnimated:YES completion:^{
                if (!strongSelf) return;
                if (strongSelf.didFinishPickingPhotosHandle) {
                    strongSelf.didFinishPickingPhotosHandle(photos,assets,isSelectOriginalPhoto);
                }
            }];
        }];
    }
    return self;
}

/// This init method for crop photo / 用这个初始化方法以裁剪图片
- (instancetype)initCropTypeWithAsset:(PHAsset *)asset photo:(UIImage *)photo completion:(void (^)(UIImage *cropImage,PHAsset *asset))completion {
    TZPhotoPreviewController *previewVc = [[TZPhotoPreviewController alloc] init];
    self = [super initWithRootViewController:previewVc];
    if (self) {
        self.maxImagesCount = 1;
        self.allowPickingImage = YES;
        self.allowCrop = YES;
        self.selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
        [self configDefaultSetting];
        
        previewVc.photos = [NSMutableArray arrayWithArray:@[photo]];
        previewVc.isCropImage = YES;
        previewVc.currentIndex = 0;
        __weak typeof(self) weakSelf = self;
        [previewVc setDoneButtonClickBlockCropMode:^(UIImage *cropImage, id asset) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf dismissViewControllerAnimated:YES completion:^{
                if (completion) {
                    completion(cropImage,asset);
                }
            }];
        }];
    }
    return self;
}

- (void)configDefaultSetting {
    self.timeout = 15;
    self.photoWidth = 828.0;
    self.photoPreviewMaxWidth = 600;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.naviBgColor = [UIColor whiteColor];
    self.naviTitleColor = [UIColor whiteColor];
    self.naviTitleFont = [UIFont sourceHanSerifWithFontSize:18];
    self.barItemTextFont = [UIFont sourceHanSerifWithFontSize:14];
    self.barItemTextColor = [UIColor colorWithRed:55.0/255.0 green:120.0/255.0 blue:255.0/255.0 alpha:1];
    self.oKButtonTitleColorNormal = [UIColor colorWithRed:55.0/255.0 green:120.0/255.0 blue:255.0/255.0 alpha:1];
    self.oKButtonTitleColorDisabled = [UIColor colorWithRed:195.0/255.0 green:206.0/255.0 blue:217.0/255.0 alpha:1];
    self.showPhotoCannotSelectLayer = YES;
    /// Default is white color with 0.8 alpha;
    self.cannotSelectLayerColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    self.allowPreview = YES;
    // 2.2.26版本，不主动缩放图片，降低内存占用
    self.notScaleImage = YES;
    self.needFixComposition = NO;
    self.statusBarStyle = UIStatusBarStyleDefault;
    self.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.allowCameraLocation = NO;
    
    self.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    [self configDefaultBtnTitle];
    
    CGFloat cropViewWH = MIN(self.view.tz_width, self.view.tz_height) / 3 * 2;
    self.cropRect = CGRectMake((self.view.tz_width - cropViewWH) / 2, (self.view.tz_height - cropViewWH) / 2, cropViewWH, cropViewWH);
}

- (void)configDefaultImageName {
    self.takePictureImageName = @"takePicture";
    self.photoSelImageName = @"photo_sel_photoPickerVc";
    self.photoDefImageName = @"photo_def_photoPickerVc";
    self.photoNumberIconImage = [self createImageWithColor:nil size:CGSizeMake(24, 24) radius:12]; // @"photo_number_icon";
    self.photoPreviewOriginDefImageName = @"preview_original_def";
    self.photoOriginDefImageName = @"photo_original_def";
    self.photoOriginSelImageName = @"photo_original_sel";
}

- (void)setTakePictureImageName:(NSString *)takePictureImageName {
    _takePictureImageName = takePictureImageName;
    _takePictureImage = [UIImage tz_imageNamedFromMyBundle:takePictureImageName];
}

- (void)setPhotoSelImageName:(NSString *)photoSelImageName {
    _photoSelImageName = photoSelImageName;
    _photoSelImage = [UIImage tz_imageNamedFromMyBundle:photoSelImageName];
}

- (void)setPhotoDefImageName:(NSString *)photoDefImageName {
    _photoDefImageName = photoDefImageName;
    _photoDefImage = [UIImage tz_imageNamedFromMyBundle:photoDefImageName];
}

- (void)setPhotoNumberIconImageName:(NSString *)photoNumberIconImageName {
    _photoNumberIconImageName = photoNumberIconImageName;
    _photoNumberIconImage = [UIImage tz_imageNamedFromMyBundle:photoNumberIconImageName];
}

- (void)setPhotoPreviewOriginDefImageName:(NSString *)photoPreviewOriginDefImageName {
    _photoPreviewOriginDefImageName = photoPreviewOriginDefImageName;
    _photoPreviewOriginDefImage = [UIImage tz_imageNamedFromMyBundle:photoPreviewOriginDefImageName];
}

- (void)setPhotoOriginDefImageName:(NSString *)photoOriginDefImageName {
    _photoOriginDefImageName = photoOriginDefImageName;
    _photoOriginDefImage = [UIImage tz_imageNamedFromMyBundle:photoOriginDefImageName];
}

- (void)setPhotoOriginSelImageName:(NSString *)photoOriginSelImageName {
    _photoOriginSelImageName = photoOriginSelImageName;
    _photoOriginSelImage = [UIImage tz_imageNamedFromMyBundle:photoOriginSelImageName];
}

- (void)setIconThemeColor:(UIColor *)iconThemeColor {
    _iconThemeColor = iconThemeColor;
    [self configDefaultImageName];
}

- (void)configDefaultBtnTitle {
    self.doneBtnTitleStr = [NSBundle tz_localizedStringForKey:@"Done"];
    self.cancelBtnTitleStr = [NSBundle tz_localizedStringForKey:@"Cancel"];
    self.previewBtnTitleStr = [NSBundle tz_localizedStringForKey:@"Preview"];
    self.fullImageBtnTitleStr = [NSBundle tz_localizedStringForKey:@"Full image"];
    self.settingBtnTitleStr = [NSBundle tz_localizedStringForKey:@"Setting"];
    self.processHintStr = [NSBundle tz_localizedStringForKey:@"Processing..."];
}

- (void)setShowSelectedIndex:(BOOL)showSelectedIndex {
    _showSelectedIndex = showSelectedIndex;
    if (showSelectedIndex) {
        self.photoSelImage = [self createImageWithColor:nil size:CGSizeMake(24, 24) radius:12];
    }
    [TZImagePickerConfig sharedInstance].showSelectedIndex = showSelectedIndex;
}

- (void)setShowPhotoCannotSelectLayer:(BOOL)showPhotoCannotSelectLayer {
    _showPhotoCannotSelectLayer = showPhotoCannotSelectLayer;
    [TZImagePickerConfig sharedInstance].showPhotoCannotSelectLayer = showPhotoCannotSelectLayer;
}

- (void)setNotScaleImage:(BOOL)notScaleImage {
    _notScaleImage = notScaleImage;
    [TZImagePickerConfig sharedInstance].notScaleImage = notScaleImage;
}

- (void)setNeedFixComposition:(BOOL)needFixComposition {
    _needFixComposition = needFixComposition;
    [TZImagePickerConfig sharedInstance].needFixComposition = needFixComposition;
}

- (void)observeAuthrizationStatusChange {
    [_timer invalidate];
    _timer = nil;
    if ([PHPhotoLibrary authorizationStatus] == 0) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(observeAuthrizationStatusChange) userInfo:nil repeats:NO];
    }
    
    if ([[TZImageManager manager] authorizationStatusAuthorized]) {
        [_tipLabel removeFromSuperview];
        [_settingBtn removeFromSuperview];

        [[TZImageManager manager] getCameraRollAlbum:self.allowPickingVideo allowPickingImage:self.allowPickingImage needFetchAssets:NO completion:^(TZAlbumModel *model) {
            TZPhotoPickerController *photoPickerVc =  self.childViewControllers.firstObject;
            [photoPickerVc reloadPhotoCollectionWith:model];
        }];
    }
}

- (void)pushPhotoPickerVc {
    _didPushPhotoPickerVc = NO;
    // 1.6.8 判断是否需要push到照片选择页，如果_pushPhotoPickerVc为NO,则不push
    if (!_didPushPhotoPickerVc && _pushPhotoPickerVc) {
        TZPhotoPickerController *photoPickerVc = [[TZPhotoPickerController alloc] init];
        photoPickerVc.isFirstAppear = YES;
        photoPickerVc.columnNumber = self.columnNumber;
        [[TZImageManager manager] getCameraRollAlbum:self.allowPickingVideo allowPickingImage:self.allowPickingImage needFetchAssets:NO completion:^(TZAlbumModel *model) {
            photoPickerVc.model = model;
            [self pushViewController:photoPickerVc animated:YES];
            self->_didPushPhotoPickerVc = YES;
        }];
    }
}

- (UIAlertController *)showAlertWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:[NSBundle tz_localizedStringForKey:@"OK"] style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

- (void)hideAlertView:(UIAlertController *)alertView {
    [alertView dismissViewControllerAnimated:YES completion:nil];
    alertView = nil;
}

- (void)setMaxImagesCount:(NSInteger)maxImagesCount {
    _maxImagesCount = maxImagesCount;
    if (maxImagesCount > 1) {
        _showSelectBtn = YES;
        _allowCrop = NO;
    }
}

- (void)setShowSelectBtn:(BOOL)showSelectBtn {
    _showSelectBtn = showSelectBtn;
    // 多选模式下，不允许让showSelectBtn为NO
    if (!showSelectBtn && _maxImagesCount > 1) {
        _showSelectBtn = YES;
    }
}

- (void)setAllowCrop:(BOOL)allowCrop {
    _allowCrop = _maxImagesCount > 1 ? NO : allowCrop;
    if (allowCrop) { // 允许裁剪的时候，不能选原图和GIF
        self.allowPickingOriginalPhoto = NO;
        self.allowPickingGif = NO;
    }
}

- (void)setCircleCropRadius:(NSInteger)circleCropRadius {
    _circleCropRadius = circleCropRadius;
    self.cropRect = CGRectMake(self.view.tz_width / 2 - circleCropRadius, self.view.tz_height / 2 - _circleCropRadius, _circleCropRadius * 2, _circleCropRadius * 2);
}

- (void)setCropRect:(CGRect)cropRect {
    _cropRect = cropRect;
    _cropRectPortrait = cropRect;
    CGFloat widthHeight = cropRect.size.width;
    _cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, cropRect.origin.x, widthHeight, widthHeight);
}

- (CGRect)cropRect {
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    BOOL isFullScreen = self.view.tz_height == screenHeight;
    if (isFullScreen) {
        return _cropRect;
    } else {
        CGRect newCropRect = _cropRect;
        newCropRect.origin.y -= ((screenHeight - self.view.tz_height) / 2);
        return newCropRect;
    }
}

- (void)setTimeout:(NSInteger)timeout {
    _timeout = timeout;
    if (timeout < 5) {
        _timeout = 5;
    } else if (_timeout > 60) {
        _timeout = 60;
    }
}

- (void)setPickerDelegate:(id<TZImagePickerControllerDelegate>)pickerDelegate {
    _pickerDelegate = pickerDelegate;
    [TZImageManager manager].pickerDelegate = pickerDelegate;
}

- (void)setColumnNumber:(NSInteger)columnNumber {
    _columnNumber = columnNumber;
    if (columnNumber <= 2) {
        _columnNumber = 2;
    } else if (columnNumber >= 6) {
        _columnNumber = 6;
    }
    [TZImageManager manager].columnNumber = _columnNumber;
}

- (void)setMinPhotoWidthSelectable:(NSInteger)minPhotoWidthSelectable {
    _minPhotoWidthSelectable = minPhotoWidthSelectable;
    [TZImageManager manager].minPhotoWidthSelectable = minPhotoWidthSelectable;
}

- (void)setMinPhotoHeightSelectable:(NSInteger)minPhotoHeightSelectable {
    _minPhotoHeightSelectable = minPhotoHeightSelectable;
    [TZImageManager manager].minPhotoHeightSelectable = minPhotoHeightSelectable;
}

- (void)setHideWhenCanNotSelect:(BOOL)hideWhenCanNotSelect {
    _hideWhenCanNotSelect = hideWhenCanNotSelect;
    [TZImageManager manager].hideWhenCanNotSelect = hideWhenCanNotSelect;
}

- (void)setPhotoPreviewMaxWidth:(CGFloat)photoPreviewMaxWidth {
    _photoPreviewMaxWidth = photoPreviewMaxWidth;
    if (photoPreviewMaxWidth > 800) {
        _photoPreviewMaxWidth = 800;
    } else if (photoPreviewMaxWidth < 500) {
        _photoPreviewMaxWidth = 500;
    }
    [TZImageManager manager].photoPreviewMaxWidth = _photoPreviewMaxWidth;
}

- (void)setPhotoWidth:(CGFloat)photoWidth {
    _photoWidth = photoWidth;
    [TZImageManager manager].photoWidth = photoWidth;
}

- (void)setSelectedAssets:(NSMutableArray *)selectedAssets {
    _selectedAssets = selectedAssets;
    _selectedModels = [NSMutableArray array];
    _selectedAssetIds = [NSMutableArray array];
    for (PHAsset *asset in selectedAssets) {
        TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:[[TZImageManager manager] getAssetType:asset]];
        model.isSelected = YES;
        [[TZImageManager manager] asynGetOriginalPhotoDataWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info) {
            NSData *imageData = UIImagePNGRepresentation(photo);
            if (model.type != TZAssetModelMediaTypeVideo) {
                model.photoByte = imageData.length;
            }
        }];
        [self addSelectedModel:model];
    }
}

- (void)setAllowPickingImage:(BOOL)allowPickingImage {
    _allowPickingImage = allowPickingImage;
    [TZImagePickerConfig sharedInstance].allowPickingImage = allowPickingImage;
    if (!allowPickingImage) {
        _allowTakePicture = NO;
    }
}

- (void)setAllowPickingVideo:(BOOL)allowPickingVideo {
    _allowPickingVideo = allowPickingVideo;
    [TZImagePickerConfig sharedInstance].allowPickingVideo = allowPickingVideo;
    if (!allowPickingVideo) {
        _allowTakeVideo = NO;
    }
}

- (void)setPreferredLanguage:(NSString *)preferredLanguage {
    _preferredLanguage = preferredLanguage;
    [TZImagePickerConfig sharedInstance].preferredLanguage = preferredLanguage;
    [self configDefaultBtnTitle];
}

- (void)setLanguageBundle:(NSBundle *)languageBundle {
    _languageBundle = languageBundle;
    [TZImagePickerConfig sharedInstance].languageBundle = languageBundle;
    [self configDefaultBtnTitle];
}

- (void)setSortAscendingByModificationDate:(BOOL)sortAscendingByModificationDate {
    _sortAscendingByModificationDate = sortAscendingByModificationDate;
    [TZImageManager manager].sortAscendingByModificationDate = sortAscendingByModificationDate;
}

- (void)settingBtnClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.automaticallyAdjustsScrollViewInsets = NO;
    [super pushViewController:viewController animated:animated];
}

- (void)dealloc {
    // NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

- (void)addSelectedModel:(TZAssetModel *)model {
    [_selectedModels addObject:model];
    [_selectedAssetIds addObject:model.asset.localIdentifier];
}

- (void)removeSelectedModel:(TZAssetModel *)model {
    [_selectedModels removeObject:model];
    [_selectedAssetIds removeObject:model.asset.localIdentifier];
}

- (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius {
    if (!color) {
        color = self.iconThemeColor;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    CGContextAddPath(context, path.CGPath);
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - UIContentContainer

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![UIApplication sharedApplication].statusBarHidden) {
            if (self.needShowStatusBar) [UIApplication sharedApplication].statusBarHidden = NO;
        }
    });
    if (size.width > size.height) {
        _cropRect = _cropRectLandscape;
    } else {
        _cropRect = _cropRectPortrait;
    }
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat progressHUDY = CGRectGetMaxY(self.navigationBar.frame);
    _progressHUD.frame = CGRectMake(0, progressHUDY, self.view.tz_width, self.view.tz_height - progressHUDY);
    _HUDContainer.frame = CGRectMake((self.view.tz_width - 120) / 2, (_progressHUD.tz_height - 90 - progressHUDY) / 2, 120, 90);
    _HUDIndicatorView.frame = CGRectMake(45, 15, 30, 30);
    _HUDLabel.frame = CGRectMake(0,40, 120, 50);
}

#pragma mark - Public

- (void)cancelButtonClick {
    if (self.autoDismiss) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self callDelegateMethod];
        }];
    } else {
        [self callDelegateMethod];
    }
}

- (void)callDelegateMethod {
    if ([self.pickerDelegate respondsToSelector:@selector(tz_imagePickerControllerDidCancel:)]) {
        [self.pickerDelegate tz_imagePickerControllerDidCancel:self];
    }
    if (self.imagePickerControllerDidCancelHandle) {
        self.imagePickerControllerDidCancelHandle();
    }
}

@end



@interface TZAlbumPickerView ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
}
/// navigation的最大Y值
@property (nonatomic, assign) CGFloat navigationBarMaxY;
/// 灰色透明按钮
@property (nonatomic, strong) UIButton *greyTransparentButton;
/// 相册表格背景view
@property (nonatomic, strong) UIView *tableViewBackgroundView;
@property (nonatomic, strong) NSMutableArray *albumArr;
@end

@implementation TZAlbumPickerView
/// 显示的方法
+(void)showAlbumViewWithImagePickerVc:(TZImagePickerController *)imagePickerVc complete:(void (^)(TZAlbumModel *))complete hidenAlbumViewBlock:(void (^)(BOOL))hidenAlbumViewBlock {
    TZAlbumPickerView *albumView = [[TZAlbumPickerView alloc] init];
    albumView.selectAction = complete;
    albumView.endAnimateBlock = hidenAlbumViewBlock;
    albumView.imagePickerVc = imagePickerVc;
}

-(instancetype)init {
    if (self = [super init]) {
        [self setupAlbumView];
    }
    return self;
}

-(UIButton *)greyTransparentButton {
    if (!_greyTransparentButton) {
        _greyTransparentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _greyTransparentButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [_greyTransparentButton addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
        _greyTransparentButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    return _greyTransparentButton;
}
-(UIView *)tableViewBackgroundView {
    if (!_tableViewBackgroundView) {
        _tableViewBackgroundView = [[UIView alloc] init];
        _tableViewBackgroundView.backgroundColor = [UIColor whiteColor];
        _tableViewBackgroundView.layer.masksToBounds = YES;
    }
    return _tableViewBackgroundView;
}

- (void)configTableView {

    [[TZImagePickerConfig sharedInstance] showProgressHUD];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[TZImageManager manager] getAllAlbums:self->_imagePickerVc.allowPickingVideo allowPickingImage:self->_imagePickerVc.allowPickingImage needFetchAssets:NO completion:^(NSArray<TZAlbumModel *> *models) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[TZImagePickerConfig sharedInstance] hideProgressHUD];
                self->_albumArr = [NSMutableArray arrayWithArray:models];
                for (TZAlbumModel *albumModel in self->_albumArr) {
                    albumModel.selectedModels = self->_imagePickerVc.selectedModels;
                }
                if (!self->_tableView) {
                    
                    self->_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
                    self->_tableView.frame = self->_tableViewBackgroundView.bounds;
                    self->_tableView.rowHeight = 60;
                    self->_tableView.tableFooterView = [[UIView alloc] init];
                    self->_tableView.dataSource = self;
                    self->_tableView.delegate = self;
                    self->_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                    [self->_tableView registerClass:[TZAlbumCell class] forCellReuseIdentifier:@"TZAlbumCell"];
                    [self->_tableViewBackgroundView addSubview:self->_tableView];
                } else {
                    [self->_tableView reloadData];
                }
            });
        }];
    });
}
/// 设置相册页面
-(void)setupAlbumView {
    self.frame = [UIScreen mainScreen].bounds;
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    [[TZImagePickerConfig sharedInstance] hideProgressHUD];
    [self addSubview:self.greyTransparentButton];
    [self addSubview:self.tableViewBackgroundView];
    [self configTableView];
}
-(void)setImagePickerVc:(TZImagePickerController *)imagePickerVc{
    _imagePickerVc = imagePickerVc;
    _navigationBarMaxY = CGRectGetMaxY(_imagePickerVc.navigationBar.frame);
    self.tableViewBackgroundView.frame = CGRectMake(0,_navigationBarMaxY , [UIScreen mainScreen].bounds.size.width, 0.0001);
    [self showAnimate];
}

#pragma mark - 点击事件
-(void)clickCancel:(UIButton *)button {
    [self endAnimate];
    if (self.endAnimateBlock) {
        self.endAnimateBlock(YES);
    }
}

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albumArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TZAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TZAlbumCell"];
    cell.selectedCountButton.backgroundColor = _imagePickerVc.oKButtonTitleColorNormal;
    cell.model = _albumArr[indexPath.row];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectAction) {
        self.selectAction(_albumArr[indexPath.row]);
    }
    if (self.endAnimateBlock) {
        self.endAnimateBlock(YES);
    }
    [self endAnimate];
}
#pragma clang diagnostic pop

#pragma mark - 显示动画
-(void)showAnimate {
    [self layoutIfNeeded];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.greyTransparentButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        weakSelf.tableViewBackgroundView.frame = CGRectMake(0, self.navigationBarMaxY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationBarMaxY);
    } completion:^(BOOL finished) {}];
}

#pragma mark - 隐藏动画
-(void)endAnimate {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.greyTransparentButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        weakSelf.tableViewBackgroundView.frame = CGRectMake(0, self.navigationBarMaxY, [UIScreen mainScreen].bounds.size.width, 0.00001);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}
@end


@implementation UIImage (MyBundle)

+ (UIImage *)tz_imageNamedFromMyBundle:(NSString *)name {
    NSBundle *imageBundle = [NSBundle tz_imagePickerBundle];
    name = [name stringByAppendingString:@"@2x"];
    NSString *imagePath = [imageBundle pathForResource:name ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) {
        // 兼容业务方自己设置图片的方式
        name = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
        image = [UIImage imageNamed:name];
    }
    return image;
}

@end


@implementation TZCommonTools

+ (BOOL)tz_isIPhoneX {
    return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
            CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)) ||
            CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896)) ||
            CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(896, 414)));
}

+ (CGFloat)tz_statusBarHeight {
    return [self tz_isIPhoneX] ? 44 : 20;
}

// 获得Info.plist数据字典
+ (NSDictionary *)tz_getInfoDictionary {
    NSDictionary *infoDict = [NSBundle mainBundle].localizedInfoDictionary;
    if (!infoDict || !infoDict.count) {
        infoDict = [NSBundle mainBundle].infoDictionary;
    }
    if (!infoDict || !infoDict.count) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return infoDict ? infoDict : @{};
}

+ (BOOL)tz_isRightToLeftLayout {
    if (@available(iOS 9.0, *)) {
        if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:UISemanticContentAttributeUnspecified] == UIUserInterfaceLayoutDirectionRightToLeft) {
            return YES;
        }
    } else {
        NSString *preferredLanguage = [NSLocale preferredLanguages].firstObject;
        if ([preferredLanguage hasPrefix:@"ar-"]) {
            return YES;
        }
    }
    return NO;
}

+ (void)configBarButtonItem:(UIBarButtonItem *)item tzImagePickerVc:(TZImagePickerController *)tzImagePickerVc {
    item.tintColor = tzImagePickerVc.barItemTextColor;
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = tzImagePickerVc.barItemTextColor;
    textAttrs[NSFontAttributeName] = tzImagePickerVc.barItemTextFont;
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

@end


@implementation TZImagePickerConfig

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static TZImagePickerConfig *config = nil;
    dispatch_once(&onceToken, ^{
        if (config == nil) {
            config = [[TZImagePickerConfig alloc] init];
            config.preferredLanguage = nil;
            config.gifPreviewMaxImagesCount = 50;
        }
    });
    return config;
}

- (void)setPreferredLanguage:(NSString *)preferredLanguage {
    _preferredLanguage = preferredLanguage;
    
    if (!preferredLanguage || !preferredLanguage.length) {
        preferredLanguage = [NSLocale preferredLanguages].firstObject;
    }
    if ([preferredLanguage rangeOfString:@"zh-Hans"].location != NSNotFound) {
        preferredLanguage = @"zh-Hans";
    } else if ([preferredLanguage rangeOfString:@"zh-Hant"].location != NSNotFound) {
        preferredLanguage = @"zh-Hant";
    } else if ([preferredLanguage rangeOfString:@"vi"].location != NSNotFound) {
        preferredLanguage = @"vi";
    } else {
        preferredLanguage = @"en";
    }
    _languageBundle = [NSBundle bundleWithPath:[[NSBundle tz_imagePickerBundle] pathForResource:preferredLanguage ofType:@"lproj"]];
}

- (void)showProgressHUD {
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    // if over time, dismiss HUD automatic
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf hideProgressHUD];
    });
}

- (void)hideProgressHUD {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
