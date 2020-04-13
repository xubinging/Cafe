//
//  PrepareCourseAbroadModel.h
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrepareCourseAbroadModel : NSObject

//定义属性
@property (nonatomic, copy) NSString *icon;        //标题
@property (nonatomic, copy) NSString *title;        //标题
@property (nonatomic, copy) NSString *time;        //标题
@property (nonatomic, copy) NSString *content;      //内容

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
