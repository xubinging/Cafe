//
//  AvalonsoftSheetHead.m
//  Cafe
//
//  Created by leo on 2019/12/28.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftSheetHead.h"

#import "Header.h"

@implementation AvalonsoftSheetHead

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headLabel];
    }
    return self;
}

-(UILabel *)headLabel
{
    if (!_headLabel)
    {
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, kCellH)];
        _headLabel.text = @"标题";
        _headLabel.backgroundColor = [UIColor whiteColor];
        _headLabel.textColor = [UIColor darkGrayColor];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.font = [UIFont systemFontOfSize:18];
        
//        if (kScreenHeight == 667)
//        {
//            _headLabel.font = [UIFont systemFontOfSize:20];
//        }
//        else if (kScreenHeight >667)
//        {
//            _headLabel.font = [UIFont systemFontOfSize:21];
//        }
        
    }
    
    return _headLabel;
}

@end
