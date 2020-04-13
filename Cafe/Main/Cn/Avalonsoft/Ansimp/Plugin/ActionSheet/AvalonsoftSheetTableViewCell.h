//
//  AvalonsoftSheetTableViewCell.h
//  Cafe
//
//  Created by leo on 2019/12/28.
//  Copyright © 2019 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvalonsoftSheetTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *myLabel;
@property (nonatomic,strong) UIView *divisionView;      //分割线,顶左右的
@property (nonatomic,strong) UIView *tableViewDivView;  //距边界15px分割线

@end

NS_ASSUME_NONNULL_END
