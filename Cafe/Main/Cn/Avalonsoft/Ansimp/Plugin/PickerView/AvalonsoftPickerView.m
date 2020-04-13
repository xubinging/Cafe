//
//  AvalonsoftPickerView.m
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftPickerView.h"

#import "AvalonsoftAddressPcikerView.h" //地址选择器
#import "AvalonsoftStringPickerView.h"  //字符串选择器
#import "AvalonsoftDatePickerView.h"    //日期选择器

@implementation AvalonsoftPickerView

+ (void)showStringPickerWithTitle:(NSString *)title
                         FileName:(NSString *)fileName
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock
{
    [AvalonsoftStringPickerView showStringPickerWithTitle:title
                                                 FileName:fileName
                                          DefaultSelValue:defaultSelValue
                                             IsAutoSelect:isAutoSelect
                                              ResultBlock:^(id selectValue, id selectRow) {
        if (resultBlock) {
            resultBlock(selectValue,selectRow);
        } ;
    }];
    

}

+ (void)showStringPickerWithTitle:(NSString *)title
                       DataSource:(NSArray *)dataSource
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock
{
    [AvalonsoftStringPickerView showStringPickerWithTitle:title
                                               DataSource:dataSource
                                          DefaultSelValue:defaultSelValue
                                             IsAutoSelect:isAutoSelect
                                              ResultBlock:^(id selectValue, id selectRow) {
        if (resultBlock) {
            resultBlock(selectValue,selectRow);
        } ;
    }];
}

+ (void)showStringPickerWithTitle:(NSString *)title
                  DefaultSelValue:(id)defaultSelValue
                     IsAutoSelect:(BOOL)isAutoSelect
                      ResultBlock:(AvalonsoftStringResultBlock)resultBlock
                            Style:(AvalonsoftStringPickerViewStyle)style
{
    [AvalonsoftStringPickerView showStringPickerWithTitle:title
                                          DefaultSelValue:defaultSelValue
                                             IsAutoSelect:isAutoSelect
                                              ResultBlock:^(id selectValue, id selectRow) {
        if (resultBlock) {
            resultBlock(selectValue,selectRow);
        } ;
    } Style:style];
}

+ (NSArray *)showStringPickerDataSourceStyle:(AvalonsoftStringPickerViewStyle)style
{
    NSArray *dataSource =[NSArray array];
    
    if (style == AvalonsoftStringPickerViewStyleEducation ||
        style == AvalonsoftStringPickerViewStyleBlood ||
        style == AvalonsoftStringPickerViewStyleAnimal ||
        style == AvalonsoftStringPickerViewStylConstellation ||
        style == AvalonsoftStringPickerViewStyleGender ||
        style == AvalonsoftStringPickerViewStylNation ||
        style == AvalonsoftStringPickerViewStylReligious ||
        style == AvalonsoftStringPickerViewStyleAge ||
        style == AvalonsoftStringPickerViewStylHeight ||
        style == AvalonsoftStringPickerViewStylWeight ||
        style == AvalonsoftStringPickerViewStylWeek) {
        
        dataSource  =[AvalonsoftStringPickerView showStringPickerDataSourceStyle:style];
        
    } else if (style == AvalonsoftStringPickerViewStyleAgeScope ||
               style == AvalonsoftStringPickerViewStylHeightScope ||
               style == AvalonsoftStringPickerViewStylWeightScope){
        
        dataSource  =[[AvalonsoftStringPickerView showStringPickerDataSourceStyle:style] firstObject];
        
    }
    
    return dataSource;
}

+ (void)showDatePickerWithTitle:(NSString *)title
                       DateType:(UIDatePickerMode)type
                DefaultSelValue:(NSString *)defaultSelValue
                     MinDateStr:(NSString *)minDateStr
                     MaxDateStr:(NSString *)maxDateStr
                   IsAutoSelect:(BOOL)isAutoSelect
                        Manager:(AvalonsoftPickerViewManager *)manager
                    ResultBlock:(AvalonsoftDateResultBlock)resultBlock
{
    if (manager) {
        [AvalonsoftDatePickerView showDatePickerWithTitle:title
                                          DateType:type
                                   DefaultSelValue:defaultSelValue
                                        MinDateStr:minDateStr
                                        MaxDateStr:maxDateStr
                                      IsAutoSelect:isAutoSelect
                                       ResultBlock:^(NSString *selectValue) {
            if (resultBlock) {
                resultBlock(selectValue);
            }
        } Manager:manager];
    } else{
        [AvalonsoftDatePickerView showDatePickerWithTitle:title
                                          DateType:type
                                   DefaultSelValue:defaultSelValue
                                        MinDateStr:minDateStr
                                        MaxDateStr:maxDateStr
                                      IsAutoSelect:isAutoSelect
                                       ResultBlock:^(NSString *selectValue) {
            if (resultBlock) {
                resultBlock(selectValue);
            }
        }];
    }

}

+ (void)showAddressPickerWithTitle:(NSString *)title
                   DefaultSelected:(NSArray *)defaultSelectedArr
                      IsAutoSelect:(BOOL)isAutoSelect
                           Manager:(AvalonsoftPickerViewManager *)manager
                       ResultBlock:(AvalonsoftAddressResultBlock)resultBlock
{
    [AvalonsoftAddressPcikerView showAddressPickerWithTitle:title DefaultSelected:defaultSelectedArr IsAutoSelect:isAutoSelect Manager:manager ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
        if (resultBlock) {
            resultBlock(selectAddressArr,selectAddressRow);
        }; ;
    }];
}

+ (void)showAddressPickerWithTitle:(NSString *)title
                   DefaultSelected:(NSArray *)defaultSelectedArr
                          FileName:(NSString *)fileName
                      IsAutoSelect:(BOOL)isAutoSelect
                           Manager:(AvalonsoftPickerViewManager *)manager
                       ResultBlock:(AvalonsoftAddressResultBlock)resultBlock
{
    [AvalonsoftAddressPcikerView showAddressPickerWithTitle:title DefaultSelected:defaultSelectedArr FileName:fileName IsAutoSelect:isAutoSelect Manager:manager ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
        if (resultBlock) {
            resultBlock(selectAddressArr,selectAddressRow);
        }; ;
    }];
}

@end
