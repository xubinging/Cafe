//
//  AvalonsoftSheetTableViewCell.m
//  Cafe
//
//  Created by leo on 2019/12/28.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftSheetTableViewCell.h"

#import "Header.h"

@implementation AvalonsoftSheetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self addSubview:self.myLabel];
    [self addSubview:self.divisionView];
    [self addSubview:self.tableViewDivView];
    
    return self;
}

- (UILabel *)myLabel
{
    if (!_myLabel)
    {
        _myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kCellH-1)];
        _myLabel.backgroundColor = [UIColor whiteColor];
        _myLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];//这个可以定义,看需求
        _myLabel.font = [UIFont systemFontOfSize:18];
        //三目运算也可以 kScreenWidth>667?21:(kScreenWidth ==667?20:18)
        
//        if (kScreenHeight == 667)
//        {
//            _myLabel.font = [UIFont systemFontOfSize:20];
//        }
//        else if (kScreenHeight >667)
//        {
//            _myLabel.font = [UIFont systemFontOfSize:21];
//        }
        
    }
    
    return _myLabel;
}

-(UIView *)divisionView
{
    if (!_divisionView)
    {
        _divisionView = [[UIView alloc] initWithFrame:CGRectMake(10, kCellH-1, kScreenWidth-35, 0.5)];
        _divisionView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    }
    
    return _divisionView;
}

-(UIView *)tableViewDivView
{
    if (!_tableViewDivView)
    {
        _tableViewDivView =[[UIView alloc] initWithFrame:CGRectMake(15, kCellH-1, kScreenWidth-30, 0.5)];
        _tableViewDivView.backgroundColor = [UIColor blackColor];
    }
    
    return _tableViewDivView;
}
@end
