//
//  AvalonsoftMenuButton.m
//  Cafe
//
//  Created by leo on 2019/12/31.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftMenuButton.h"

@implementation AvalonsoftMenuButton

- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
              withImageString:(NSString *)imageString
{
    if (self = [super initWithFrame:frame]) {
        self.titleString = title;
        self.imageString = imageString;
        self.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        self.titleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    self.btnTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.btnTitleLabel.textColor = self.titleColor;
    self.btnTitleLabel.font = self.titleFont;
    self.btnTitleLabel.numberOfLines = 0;
    self.btnTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.btnTitleLabel.text = self.titleString;
    [self addSubview:self.btnTitleLabel];
    
    self.btnImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.btnImageView setImage:[UIImage imageNamed:self.imageString]];
    [self addSubview:self.btnImageView];
}


- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.btnImageView.frame = CGRectMake((self.frame.size.width - 22)/2, 0, 22, 22);
    self.btnTitleLabel.frame = CGRectMake(0,CGRectGetMaxY(self.btnImageView.frame) + 10, self.frame.size.width, 18);
   
}

@end
