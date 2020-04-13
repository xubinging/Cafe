//
//  PlatformMenuXIBCell.h
//  Cafe
//
//  Created by leo on 2020/1/1.
//  Copyright © 2020 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlatformMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlatformMenuXIBCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *menuTitleLabel;

//工厂方法
+(instancetype)PlatformMenuXIBCell;

//根据类去填充cell
-(void)updateCellWithModel:(PlatformMenuModel *)model;

@end

NS_ASSUME_NONNULL_END
