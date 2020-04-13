//
//  AvalonsoftSheetFoot.m
//  Cafe
//
//  Created by leo on 2019/12/28.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftSheetFoot.h"

#import "Header.h"

@implementation AvalonsoftSheetFoot

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.footButton];
    }
    return self;
}

-(UIButton *)footButton
{
    if (!_footButton)
    {
        _footButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, kCellH)];
        [_footButton setTitle:@"取消" forState:0];
        [_footButton setTitleColor:[UIColor colorWithRed:32/255.0 green:188/255.0 blue:255/255.0 alpha:1.0] forState:0];//按钮文字颜色,这个看需求
        _footButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _footButton.titleLabel.font = [UIFont systemFontOfSize:18];
        
//        if (kScreenHeight == 667)
//        {
//            _footButton.titleLabel.font = [UIFont systemFontOfSize:20];
//        }
//        else if (kScreenHeight >667)
//        {
//            _footButton.titleLabel.font = [UIFont systemFontOfSize:21];
//        }
        
    }
    return _footButton;
}

@end
