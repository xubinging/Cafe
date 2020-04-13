//
//  AvalonsoftSheetView.m
//  Cafe
//
//  Created by leo on 2019/12/28.
//  Copyright © 2019 leo. All rights reserved.
//

#import "AvalonsoftSheetView.h"

#import "Header.h"
#import "AvalonsoftSheetTableViewCell.h"

@interface AvalonsoftSheetView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AvalonsoftSheetView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableDivLine];
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const AvalonsoftSheetCellID = @"AvalonsoftSheetTableViewCell";
    AvalonsoftSheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AvalonsoftSheetCellID];
    
    if (cell == nil)
    {
        cell = [[AvalonsoftSheetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AvalonsoftSheetCellID];
        
        if (_cellTextColor)
        {
            cell.myLabel.textColor = _cellTextColor;
        }
    }
    
    //cell 文字
    cell.myLabel.text = self.dataSource[indexPath.row];
    
    //cell 文本大小
    if (_cellTextFont)
    {
        cell.myLabel.font = _cellTextFont;
    }
    
    //cell 文本居中状态
    if (_cellTextStyle == NSTextStyleLeft)
    {
        cell.myLabel.textAlignment = NSTextAlignmentLeft;
    }
    else if (_cellTextStyle == NSTextStyleRight)
    {
        cell.myLabel.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        cell.myLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    //分割线
    if (_showTableDivLine)
    {
        cell.divisionView.hidden = YES;
        cell.tableViewDivView.hidden = NO;
    }
    else
    {
        cell.divisionView.hidden = NO;
        cell.tableViewDivView.hidden = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger index = indexPath.row;
    AvalonsoftSheetTableViewCell * cell = (AvalonsoftSheetTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *cellTitle = cell.myLabel.text;
    
    if ([self.delegate respondsToSelector:@selector(sheetViewDidSelectIndex:selectTitle:)])
    {
        [self.delegate sheetViewDidSelectIndex:index selectTitle:cellTitle];
    }
}

#pragma mark - getter or setter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kCellH*self.dataSource.count)];//Plain
        _tableView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _tableView;
}

-(UIView *)tableDivLine
{
    if (!_tableDivLine)
    {
        _tableDivLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        _tableDivLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _tableDivLine;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

@end
