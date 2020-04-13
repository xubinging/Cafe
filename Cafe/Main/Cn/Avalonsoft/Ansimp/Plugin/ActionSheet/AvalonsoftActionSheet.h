//
//  AvalonsoftActionSheet.h
//  Cafe
//
//  Created by leo on 2019/12/28.
//  Copyright © 2019 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//Block 回调
typedef void(^SelectIndexBlock)(NSInteger index,NSString *title);

typedef NS_ENUM(NSInteger, AvalonsoftSheetStyle)
{
    /**默认的样式*/
    AvalonsoftSheetStyleDefault = 0,
    /**微博,微信样式*/
    AvalonsoftSheetStyleWeiChat,
    /**tableView 样式 (无取消按钮)*/
    AvalonsoftSheetStyleTable,
};

@protocol AvalonsoftActionSheetDelegate <NSObject>

//传递 index 和 title, 以及 sender 即 SJActionSheet, 可用 tag 等属性区别不同的 AvalonsoftActionSheet
- (void)sheetViewDidSelectIndex:(NSInteger)index
                          title:(NSString *)title
                         sender:(id)sender;

//简单传递出 index 和 title
- (void)sheetViewDidSelectIndex:(NSInteger)index
                          title:(NSString *)title;


@end

@interface AvalonsoftActionSheet : UIView

//标题颜色,默认是 darkGaryColor
@property (nonatomic,strong)UIColor *titleTextColor;
//item 字体颜色,默认是 blueColor
@property (nonatomic,strong)UIColor *itemTextColor;
//取消字体颜色,默认是 blueColor
@property (nonatomic,strong)UIColor *cancleTextColor;
//标题文字字体
@property (nonatomic,strong)UIFont *titleTextFont;
//item 文字字体
@property (nonatomic,strong)UIFont *itemTextFont;
//取消按钮字体
@property (nonatomic,strong)UIFont *cancelTextFont;
//取消按钮文字设置,默认是"取消"
@property (nonatomic,copy)NSString *cancelTitle;
//是否统一处理取消按钮事件
@property (nonatomic,assign)BOOL isUnifyCancelAction;

// 设置代理,有两个代理方法可供选择
@property (nonatomic,weak) id delegate;

//初始化方法, title不传则不显示, tableView 当 item 显示不完的时候可以滑动, style 默认是 UIActionSheet 样式
- (id)initSheetWithTitle:(NSString *)title
                   style:(AvalonsoftSheetStyle)style
              itemTitles:(NSArray *)itemTitles;

//回调 block 中包含选中的 index 和 title -- 也可实现代理方法获取选中的数据
- (void)didFinishSelectIndex:(SelectIndexBlock)block;

//显示
- (void)show;

@end

NS_ASSUME_NONNULL_END
