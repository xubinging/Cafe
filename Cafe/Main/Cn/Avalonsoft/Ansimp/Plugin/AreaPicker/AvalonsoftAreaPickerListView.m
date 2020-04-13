//
//  AvalonsoftAreaPickerListView.m
//  Cafe
//
//  Created by leo on 2020/2/12.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftAreaPickerListView.h"
#import "AvalonsoftAreaPickerModel.h"

@interface AvalonsoftAreaPickerListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@end

@implementation AvalonsoftAreaPickerListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"avalonsoftAreaPicker"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"avalonsoftAreaPicker"];
    }
    
    AvalonsoftAreaPickerModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    if ([model.name isEqualToString:self.selectText]) {
        //被选中的
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        
    }else{
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(AvalonsoftAreaPickerListView:didSelcetedValue:)]) {
        AvalonsoftAreaPickerModel *model = self.dataArray[indexPath.row];
        self.selectText = model.name;
        [self.delegate AvalonsoftAreaPickerListView:self didSelcetedValue:model];
    }
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (void)setSelectText:(NSString *)selectText
{
    _selectText = selectText;
    if (_dataArray) {
        [self.tableView reloadData];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView setTableFooterView:[UIView new]];
    }
    return _tableView;
}

@end
