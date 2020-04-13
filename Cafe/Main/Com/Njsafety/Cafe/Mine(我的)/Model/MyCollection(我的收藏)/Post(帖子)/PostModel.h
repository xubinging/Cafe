//
//  PostModel.h
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger postIndex;  
@property (nonatomic, copy) NSString *title;        //标题
@property (nonatomic, copy) UIImage *image;         //用户头像
@property (nonatomic, copy) NSString *name;          //用户名称
@property (nonatomic, copy) NSString *school;        //用户学校
@property (nonatomic, copy) NSString *time;          //时间
@property (nonatomic, copy) NSString *content;      //内容

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
