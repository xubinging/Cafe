//
//  AvalonsoftAreaPickerHeaderView.m
//  Cafe
//
//  Created by leo on 2020/2/12.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftAreaPickerHeaderView.h"
#import "AvalonsoftAreaPickerCollectionViewCell.h"

@interface AvalonsoftAreaPickerHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UIView *animationline;

@end

@implementation AvalonsoftAreaPickerHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
        
        [self initAnimationLine];
        
    }
    return self;
}

- (void)initAnimationLine
{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 4, self.frame.size.width, 4)];
    line.backgroundColor = [UIColor clearColor];
    line.alpha = 1;
    [self addSubview:line];
    
    self.animationline = [[UIView alloc]init];
    self.animationline.backgroundColor = [UIColor clearColor];
    [line addSubview:self.animationline];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout= [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView .delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[AvalonsoftAreaPickerCollectionViewCell class] forCellWithReuseIdentifier:@"AvalonsoftAreaPickerCollectionViewCell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AvalonsoftAreaPickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AvalonsoftAreaPickerCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.tLb.text = self.dataArray[indexPath.row];
    if (self.isLastRed && (indexPath.row ==  self.dataArray.count - 1)) {
        
        CGRect cellRect = [self.collectionView convertRect:cell.frame toView:self.collectionView];
        CGRect tt = [self.collectionView convertRect:cellRect toView:self];
        tt.size.height = 4;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.animationline.frame = CGRectMake(tt.origin.x + (tt.size.width - 20)/2, 0, 20, 4);
            
            // gradient
            CAGradientLayer *gl = [CAGradientLayer layer];
            gl.frame = self.animationline.bounds;
            gl.startPoint = CGPointMake(1, -0.34);
            gl.endPoint = CGPointMake(0, 1);
            gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:154/255.0 blue:66/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0].CGColor];
            gl.locations = @[@(0), @(1.0f)];
            gl.cornerRadius = 2;
            [self.animationline.layer addSublayer:gl];
            self.animationline.layer.shadowColor = [UIColor colorWithRed:251/255.0 green:142/255.0 blue:48/255.0 alpha:0.2].CGColor;
            self.animationline.layer.shadowOffset = CGSizeMake(0,2);
            self.animationline.layer.shadowOpacity = 1;
            self.animationline.layer.shadowRadius = 4;
            
        }];
        //当前选中的表头
        cell.tLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
        
    }else{
        cell.tLb.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dalegate respondsToSelector:@selector(AvalonsoftAreaPickerHeaderView:didSelcetIndex:)]) {
        [self.dalegate AvalonsoftAreaPickerHeaderView:self didSelcetIndex:indexPath.row];
    }
    [self setAnimationLineAnimation:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = self.dataArray[indexPath.row];
    CGFloat witdh =[string boundingRectWithSize:CGSizeMake(0, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14] } context:nil].size.width;
    return CGSizeMake(witdh + 10, self.frame.size.height);
}

// 设置cell的水平间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)setindex:(NSInteger )index
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];
    [self setAnimationLineAnimation:indexpath];
}

- (void)setAnimationLineAnimation:(NSIndexPath *)indexpath
{
    AvalonsoftAreaPickerCollectionViewCell *c = (AvalonsoftAreaPickerCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpath];
    CGRect cellRect = [self.collectionView convertRect:c.frame toView:self.collectionView];
    CGRect tt = [self.collectionView convertRect:cellRect toView:self];
    tt.size.height = 4;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.animationline.frame = CGRectMake(tt.origin.x + (tt.size.width - 20)/2, 0, 20, 4);
        
        // gradient
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = self.animationline.bounds;
        gl.startPoint = CGPointMake(1, -0.34);
        gl.endPoint = CGPointMake(0, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:154/255.0 blue:66/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:238/255.0 green:111/255.0 blue:0/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        gl.cornerRadius = 2;
        [self.animationline.layer addSublayer:gl];
        self.animationline.layer.shadowColor = [UIColor colorWithRed:251/255.0 green:142/255.0 blue:48/255.0 alpha:0.2].CGColor;
        self.animationline.layer.shadowOffset = CGSizeMake(0,2);
        self.animationline.layer.shadowOpacity = 1;
        self.animationline.layer.shadowRadius = 4;
    }];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

@end
