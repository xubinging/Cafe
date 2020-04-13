//
//  PlatformMenuXIBCell.m
//  Cafe
//
//  Created by leo on 2020/1/1.
//  Copyright © 2020 leo. All rights reserved.
//

#import "PlatformMenuXIBCell.h"

@implementation PlatformMenuXIBCell

+ (instancetype)PlatformMenuXIBCell
{
    //通过xib文件来进行cell的创建的
    //loadNibNamed方法可以加载多个视图，返回的是个array
    PlatformMenuXIBCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PlatformMenuXIBCell" owner:self options:nil] lastObject];
    
    return cell;
}

- (void)updateCellWithModel:(PlatformMenuModel *)model
{
    [self.menuTitleLabel setText:model.menuTitleName];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 重新绘制分割线 -
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);

    CGContextFillRect(context, rect);

    //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor);
//    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 1));

    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height-0.5, rect.size.width, 0));
}

@end
