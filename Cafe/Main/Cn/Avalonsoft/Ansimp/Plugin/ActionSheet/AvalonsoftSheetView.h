//
//  AvalonsoftSheetView.h
//  Cafe
//
//  Created by leo on 2019/12/28.
//  Copyright © 2019 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,NSCelltextStyle)
{
    NSTextStyleCenter = 0, //cell 文字默认样式居中
    NSTextStyleLeft,       //cell 文字样式居左
    NSTextStyleRight,      //cell 文字样式居右
};

@protocol AvalonsoftSheetViewDelegate <NSObject>

- (void)sheetViewDidSelectIndex:(NSInteger)index selectTitle:(NSString *)title;

@end

@interface AvalonsoftSheetView : UIView

@property (nonatomic,weak) id <AvalonsoftSheetViewDelegate> delegate;   //代理
@property (nonatomic,assign) NSCelltextStyle cellTextStyle;         //cell文字位置
@property (nonatomic,strong) NSMutableArray *dataSource;            //数据源

@property (nonatomic,strong) UITableView *tableView;    //表格
@property (nonatomic,strong) UIView *tableDivLine;      //表格和标题的分割线
@property (nonatomic,assign) BOOL showTableDivLine;     //是否显示分割线

@property (nonatomic,strong) UIColor *cellTextColor;    //cell颜色
@property (nonatomic,strong) UIFont *cellTextFont;      //cell字体
@property (nonatomic,assign) CGFloat cellHeight;        //cell高度

@end

NS_ASSUME_NONNULL_END
