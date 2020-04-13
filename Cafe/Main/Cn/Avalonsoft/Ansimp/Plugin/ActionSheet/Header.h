//
//  Header.h
//  Cafe
//
//  Created by leo on 2019/12/28.
//  Copyright © 2019 leo. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kCellH (kScreenHeight<500?45:(kScreenHeight<600?47:(kScreenHeight<700?49:50)))
#define kPushTime 0.3
#define kDismissTime 0.3
#define kScreenWW (kScreenWidth-2*kMargin)
#define kCornerRadius 13
#define kMargin 6

#endif /* Header_h */
