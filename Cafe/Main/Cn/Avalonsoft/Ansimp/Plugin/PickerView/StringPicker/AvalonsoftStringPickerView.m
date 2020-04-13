//
//  AvalonsoftStringPickerView.m
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftStringPickerView.h"

@interface AvalonsoftStringPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

// 字符串选择器(默认大小: 320px × 216px)
@property (nonatomic, strong) UIPickerView *pickerView;

// 是否是单列
@property (nonatomic, assign) BOOL isSingleColumn;

// 数据源是否合法（数组的元素类型只能是字符串或数组类型）
@property (nonatomic, assign) BOOL isDataSourceValid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray  *dataSource;

// 是否开启自动选择
@property (nonatomic, assign) BOOL isAutoSelect;
@property (nonatomic, copy) AvalonsoftStringResultBlock resultBlock;

// 单列选中的项
@property (nonatomic, copy) NSString *selectedItem;

// 多列选中的项
@property (nonatomic, strong) NSMutableArray *selectedItems;

@end

@implementation AvalonsoftStringPickerView

#pragma mark - 显示自定义字符串选择器
+ (void)showStringPickerWithTitle:(NSString *)title
                       DataSource:(NSArray *)dataSource
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock
{
    if (dataSource == nil || dataSource.count == 0) {
        return;
    }
    
    AvalonsoftStringPickerView *strPickerView = [[AvalonsoftStringPickerView alloc] initWithTitle:title dataSource:dataSource defaultSelValue:defaultSelValue isAutoSelect:isAutoSelect resultBlock:resultBlock];
    [strPickerView showWithAnimation:YES];
}

+ (void)showStringPickerWithTitle:(NSString *)title
                         FileName:(NSString *)fileName
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock
 {
    if (fileName == nil || fileName.length == 0) {
        return;
    }
     
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSArray *dataSource =[[NSArray alloc] initWithContentsOfFile:path];
    
    AvalonsoftStringPickerView *strPickerView = [[AvalonsoftStringPickerView alloc] initWithTitle:title dataSource:dataSource defaultSelValue:defaultSelValue isAutoSelect:isAutoSelect resultBlock:resultBlock];
    [strPickerView showWithAnimation:YES];
}

+ (void)showStringPickerWithTitle:(NSString *)title
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock
                            Style:(NSInteger)style
{
    NSArray *dataSource = [AvalonsoftStringPickerView showStringPickerDataSourceStyle:style];
    
    AvalonsoftStringPickerView *strPickerView = [[AvalonsoftStringPickerView alloc] initWithTitle:title dataSource:dataSource defaultSelValue:defaultSelValue isAutoSelect:isAutoSelect resultBlock:resultBlock];
    [strPickerView showWithAnimation:YES];
}

// 根据style的值，从本地存储的plist文件中返回默认单行个人信息数组
// 这种方法需要确定style值的范围 + 本地存储好的plist文件
+ (NSArray *)showStringPickerDataSourceStyle:(NSInteger)style
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AvalonsoftBasicInfoPicker" ofType:@"plist"];
    NSMutableDictionary *dataSourceaa =[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSArray *dataSource = [NSArray array];
    
    switch (style) {
        case 0:
            {
                dataSource = [dataSourceaa objectForKey:@"education"];
            }
            break;
        case 1:
            {
                dataSource = [dataSourceaa objectForKey:@"blood"];
            }
            break;
        case 2:
            {
                dataSource = [dataSourceaa objectForKey:@"animal"];
            }
            break;
        case 3:
            {
                dataSource = [dataSourceaa objectForKey:@"constellation"];
            }
            break;
        case 4:
            {
                dataSource = [dataSourceaa objectForKey:@"gender"];
            }
            break;
        case 5:
            {
                dataSource = [dataSourceaa objectForKey:@"nation"];
            }
            break;
        case 6:
            {
                dataSource = [dataSourceaa objectForKey:@"religion"];
            }
            break;
        case 7:
            {
                NSArray *heightAry = [AvalonsoftStringPickerView ageArray:[dataSourceaa objectForKey:@"age"]];
                dataSource = heightAry;
            }
            break;
        case 8:
            {
                NSArray *heightAry = [AvalonsoftStringPickerView ageArray:[dataSourceaa objectForKey:@"age"]];
                dataSource = @[heightAry,heightAry];
            }
            break;
        case 9:
            {
                NSArray *heightAry = [AvalonsoftStringPickerView heightArray:[dataSourceaa objectForKey:@"height"]];
                dataSource = heightAry;
            }
            break;
        case 10:
            {
                NSArray *heightAry = [AvalonsoftStringPickerView heightArray:[dataSourceaa objectForKey:@"height"]];
                dataSource = @[heightAry,heightAry];
            }
            break;
        case 11:
            {
                NSArray *heightAry = [AvalonsoftStringPickerView weightArray:[dataSourceaa objectForKey:@"weight"]];
                dataSource = heightAry;
            }
            break;
        case 12:
            {
                NSArray *heightAry = [AvalonsoftStringPickerView weightArray:[dataSourceaa objectForKey:@"weight"]];
                dataSource = @[heightAry,heightAry];
            }
            break;
        case 13:
            {
                 dataSource = [dataSourceaa objectForKey:@"week"];
            }
            break;
        default:
            break;
    }
    
    return dataSource;
}

//身高范围
+ (NSArray *)heightArray:(NSArray *)arr
{
    NSInteger inter1 = [arr[0] integerValue];
    NSInteger inter2 = [arr[1] integerValue];
    NSMutableArray *heightarrr = [NSMutableArray array];
    [heightarrr addObject:@"不限"];
    for (NSInteger i = inter1; i<inter2+1; i++) {
        [heightarrr addObject:[NSString stringWithFormat:@"%ldcm",(long)i]];
    }
    return heightarrr;
}

//年龄范围
+ (NSArray *)ageArray:(NSArray *)arr
{
    NSInteger inter1 = [arr[0] integerValue];
    NSInteger inter2 = [arr[1] integerValue];
    NSMutableArray *ageArrr = [NSMutableArray array];
    [ageArrr addObject:@"不限"];
    for (NSInteger i = inter1; i<inter2+1; i++) {
        [ageArrr addObject:[NSString stringWithFormat:@"%ld岁",(long)i]];
    }
    return ageArrr;
}

//体重范围
+ (NSArray *)weightArray:(NSArray *)arr
{
    NSInteger inter1 = [arr[0] integerValue];
    NSInteger inter2 = [arr[1] integerValue];
    NSMutableArray *weightArray = [NSMutableArray array];
    [weightArray addObject:@"不限"];
    for (NSInteger i = inter1; i<inter2+1; i++) {
        [weightArray addObject:[NSString stringWithFormat:@"%ldkg",(long)i]];
    }
    return weightArray;
}

#pragma mark - 初始化自定义字符串选择器
- (instancetype)initWithTitle:(NSString *)title
                   dataSource:(NSArray *)dataSource
              defaultSelValue:(id)defaultSelValue
                 isAutoSelect:(BOOL)isAutoSelect
                  resultBlock:(AvalonsoftStringResultBlock)resultBlock
{
    if (self = [super init]) {
        self.title = title;
        self.dataSource = dataSource;
        self.isAutoSelect = isAutoSelect;
        self.resultBlock = resultBlock;
        
        if (defaultSelValue) {
            if ([defaultSelValue isKindOfClass:[NSString class]]) {
                self.selectedItem = defaultSelValue;
            } else if ([defaultSelValue isKindOfClass:[NSArray class]]){
                self.selectedItems = [defaultSelValue mutableCopy];
            }
        }
        [self loadData];
        [self initUI];
    }
    return self;
}

#pragma mark - 初始化子视图
- (void)initUI {
    [super initUI];
    self.titleLabel.text = self.title;
    // 添加字符串选择器
    [self.alertView addSubview:self.pickerView];
}

#pragma mark - 加载自定义字符串数据
- (void)loadData {
    if (self.dataSource == nil || self.dataSource.count == 0) {
        self.isDataSourceValid = NO;
        return;
    } else {
        self.isDataSourceValid = YES;
    }
    
    __weak typeof(self) weakSelf = self;
    // 遍历数组元素 (遍历多维数组一般用这个方法)
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        static Class itemType;
        if (idx == 0) {
            itemType = [obj class];
            // 判断数据源数组的第一个元素是什么类型
            if ([obj isKindOfClass:[NSArray class]]) {
                weakSelf.isSingleColumn = NO;       // 非单列
            } else if ([obj isKindOfClass:[NSString class]]) {
                weakSelf.isSingleColumn = YES;      // 单列
            } else {
                weakSelf.isDataSourceValid = NO;    // 数组不合法
                return;
            }
        } else {
            // 判断数组的元素类型是否相同
            if (itemType != [obj class]) {
                weakSelf.isDataSourceValid = NO; // 数组不合法
                *stop = YES;
                return;
            }
            
            if ([obj isKindOfClass:[NSArray class]]) {
                if (((NSArray *)obj).count == 0) {
                    weakSelf.isDataSourceValid = NO;
                    *stop = YES;
                    return;
                } else {
                    for (id subObj in obj) {
                        if (![subObj isKindOfClass:[NSString class]]) {
                            weakSelf.isDataSourceValid = NO;
                            *stop = YES;
                            return;
                        }
                    }
                }
            }
        }
    }];
    
    if (self.isSingleColumn) {
        if (self.selectedItem == nil) {
            // 如果是单列，默认选中数组第一个元素
            self.selectedItem = _dataSource.firstObject;
        }
    } else {
        BOOL isSelectedItemsValid = YES;
        for (id obj in self.selectedItems) {
            if (![obj isKindOfClass:[NSString class]]) {
                isSelectedItemsValid = NO;
                break;
            }
        }
        if (self.selectedItems == nil || self.selectedItems.count != self.dataSource.count || !isSelectedItemsValid) {
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (NSArray* componentItem in _dataSource) {
                [mutableArray addObject:componentItem.firstObject];
            }
            self.selectedItems = [NSMutableArray arrayWithArray:mutableArray];
        }
    }
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.alertView.frame = rect;
        
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= self.manager.kTopViewH + self.manager.kPickerViewH;
            self.alertView.frame = rect;
        }];
    }
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += self.manager.kTopViewH + self.manager.kPickerViewH;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {
    [self dismissWithAnimation:YES];
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
    [self dismissWithAnimation:YES];
    if(_resultBlock) {
        if (self.isSingleColumn) {
            NSString  *str = [NSString stringWithFormat:@"%lu",(unsigned long)[_dataSource indexOfObject:self.selectedItem]];
                _resultBlock([self.selectedItem copy],[str copy]);
        } else {
            NSMutableArray *selectRowAry = [NSMutableArray array];
            for (int i = 0; i<_dataSource.count; i++) {
                NSArray *arr = _dataSource[i];
                NSString *str = self.selectedItems[i];
                [selectRowAry addObject:[NSString stringWithFormat:@"%lu" , (unsigned long)[arr indexOfObject:str]]];
            }
            _resultBlock([self.selectedItems copy],[selectRowAry copy]);
        }
    }
}

#pragma mark - 字符串选择器
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.manager.kTopViewH + 0.5, SCREEN_WIDTH, self.manager.kPickerViewH)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        
        __weak typeof(self) weakSelf = self;
        if (self.isSingleColumn) {
            [_dataSource enumerateObjectsUsingBlock:^(NSString *rowItem, NSUInteger rowIdx, BOOL *stop) {
                if ([weakSelf.selectedItem isEqualToString:rowItem]) {
                    [weakSelf.pickerView selectRow:rowIdx inComponent:0 animated:NO];
                    *stop = YES;
                }
            }];
        } else {
            [self.selectedItems enumerateObjectsUsingBlock:^(NSString *selectedItem, NSUInteger component, BOOL *stop) {
                [_dataSource[component] enumerateObjectsUsingBlock:^(id rowItem, NSUInteger rowIdx, BOOL *stop) {
                    if ([selectedItem isEqualToString:rowItem]) {
                        [weakSelf.pickerView selectRow:rowIdx inComponent:component animated:NO];
                        *stop = YES;
                    }
                }];
            }];
        }
    }
    return _pickerView;
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.isSingleColumn) {
        return 1;
    } else {
        return _dataSource.count;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.isSingleColumn) {
        return _dataSource.count;
    } else {
        return ((NSArray*)_dataSource[component]).count;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.isSingleColumn) {
        return _dataSource[row];
    } else {
        return ((NSArray*)_dataSource[component])[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.isSingleColumn) {
        self.selectedItem = _dataSource[row];
    } else {
        self.selectedItems[component] = ((NSArray *)_dataSource[component])[row];
    }
    // 设置是否自动回调
    if (self.isAutoSelect) {
        if(_resultBlock) {
            if (self.isSingleColumn) {
                NSString  *str = [NSString stringWithFormat:@"%lu", (unsigned long)[_dataSource indexOfObject:self.selectedItem]];
                    _resultBlock([self.selectedItem copy],[str copy]);
            } else {
                NSMutableArray *selectRowAry = [NSMutableArray array];
                for (int i = 0; i<_dataSource.count; i++) {
                    NSArray *arr = _dataSource[i];
                    NSString *str = self.selectedItems[i];
                    [selectRowAry addObject:[NSString stringWithFormat:@"%lu", (unsigned long)[arr indexOfObject:str]]];
                }
                _resultBlock([self.selectedItems copy],[selectRowAry copy]);
            }
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        }
    }
    //可以通过自定义label达到自定义pickerview展示数据的方式
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        CGFloat width = 0;
        
        if(self.isSingleColumn){
            //单列
            width = SCREEN_WIDTH;
        }else{
            //多列
            width = SCREEN_WIDTH / _dataSource.count;
        }
        
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor whiteColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:self.manager.pickerTitleSize]];
        [pickerLabel setTextColor:self.manager.pickerTitleColor];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];//调用上一个委托方法，获得要展示的title
    return pickerLabel;
}

@end
