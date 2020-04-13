//
//  PersonalDataTableViewCell.m
//  Cafe
//
//  Created by leo on 2020/1/3.
//  Copyright © 2020 leo. All rights reserved.
//

#import "PersonalDataTableViewCell.h"

@implementation PersonalDataTableViewCell

//纯代码创建 tableviewcell，重写该方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        CGFloat cellHeight = 48;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        //cell标题
        _cellTitleLabel = [UILabel new];
        [self.contentView addSubview:_cellTitleLabel];
        [_cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.contentView.mas_top).offset((cellHeight - 22)/2);
            make.size.mas_equalTo(CGSizeMake(100, 22));
        }];
        _cellTitleLabel.numberOfLines = 0;
        _cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        _cellTitleLabel.alpha = 1.0;
        
        //向右图标
        UIImageView *nextStep = [UIImageView new];
        [self.contentView addSubview:nextStep];
        [nextStep mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.contentView).offset((cellHeight - 13)/2);
            make.right.equalTo(self.contentView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(7, 13));
        }];
        [nextStep setImage:[UIImage imageNamed:@"mine_nextstep"]];
        
        //显示文字
        _cellContentLabel = [UILabel new];
        [self.contentView addSubview:_cellContentLabel];
        [_cellContentLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_cellTitleLabel.mas_right).offset(15);
            make.right.equalTo(nextStep.mas_left).offset(-10);
            make.top.equalTo(self.contentView).offset((cellHeight - 20)/2);
            make.height.mas_equalTo(@20);
        }];
        _cellContentLabel.numberOfLines = 0;
        _cellContentLabel.textAlignment = NSTextAlignmentRight;
        _cellContentLabel.alpha = 1.0;
        
        //显示图片
        _cellContentImageView = [UIImageView new];
        [self.contentView addSubview:_cellContentImageView];
        [_cellContentImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(nextStep.mas_left).offset(-10);
            make.top.equalTo(self.contentView).offset((cellHeight - 40)/2);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        _cellContentImageView.layer.masksToBounds = YES;
        _cellContentImageView.layer.cornerRadius = 20;
        
        //下分割线
        UIView *splitView = [UIView new];
        [self.contentView addSubview:splitView];
        [splitView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        }];
        [splitView setBackgroundColor:RGBA_GGCOLOR(241, 241, 241, 1)];
        
    }
    
    return self;
}

- (void)updateCellWithModel:(PersonalDataModel *)model
{

    NSString *cellType = model.cellType;
    NSString *sectionType = model.sectionType;
    NSString *cellTitle = model.cellTitle;
    NSString *cellContent = model.cellContent;
    UIImage *cellImage = model.cellImage;
    
    //cell标题，顺便更新一下cellTitle的宽度
    CGFloat cellTitleWidth = [UILabel getWidthWithText:cellTitle font:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    [_cellTitleLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(cellTitleWidth, 22));
    }];
    NSMutableAttributedString *cellTitleString = [[NSMutableAttributedString alloc] initWithString:cellTitle attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]}];
    _cellTitleLabel.attributedText = cellTitleString;
    
    //根据cellType判断显示的是图片还是文字
    if([cellType isEqualToString:@"image"]){
        //显示图片，隐藏文字标签
        _cellContentLabel.hidden = YES;
        [_cellContentLabel mas_updateConstraints:^(MASConstraintMaker *make){
            make.height.mas_equalTo(@0);
        }];
        
        _cellContentImageView.hidden = NO;
        [_cellContentImageView mas_updateConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [_cellContentImageView setImage:cellImage];
        
    }else{
        //显示文字，隐藏图片标签
        _cellContentImageView.hidden = YES;
        [_cellContentImageView mas_updateConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(40, 0));
        }];
        
        _cellContentLabel.hidden = NO;
        [_cellContentLabel mas_updateConstraints:^(MASConstraintMaker *make){
            make.height.mas_equalTo(@20);
        }];

        if(![cellContent isEqualToString:@""]){
            //内容不为空
            NSMutableAttributedString *cellContentLabelString = [[NSMutableAttributedString alloc] initWithString:cellContent attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
            _cellContentLabel.attributedText = cellContentLabelString;
            
        }else{
            //内容为空
            NSMutableAttributedString *cellContentLabelString = [[NSMutableAttributedString alloc] initWithString:@"未设置" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]}];
            _cellContentLabel.attributedText = cellContentLabelString;
            
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
