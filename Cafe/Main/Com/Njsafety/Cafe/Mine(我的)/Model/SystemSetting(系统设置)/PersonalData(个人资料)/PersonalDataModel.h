//
//  PersonalDataModel.h
//  Cafe
//
//  Created by leo on 2020/1/3.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalDataModel : NSObject

//定义属性
@property (nonatomic, copy) NSString *cellType;     //cell的类型：图片或者文字，决定了cell的高度
@property (nonatomic, copy) NSString *sectionType;  //section的类型：个人信息或者我想要，决定了未选择时的提示文字

@property (nonatomic, copy) NSString *cellTitle;    //cell的标题
@property (nonatomic, copy) NSString *cellContent;  //cell的内容
@property (nonatomic, copy) UIImage *cellImage;     //头像

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
