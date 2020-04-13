//
//  AvalonsoftMenuPageControl.m
//  Cafe
//
//  Created by leo on 2019/12/31.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftMenuPageControl.h"

@implementation AvalonsoftMenuPageControl

//重写setCurrentPage方法，可设置圆点大小
- (void) setCurrentPage:(NSInteger)page {
    
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 4;
        size.width = 14;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y, size.width, size.height)];
    }
    
}

@end
