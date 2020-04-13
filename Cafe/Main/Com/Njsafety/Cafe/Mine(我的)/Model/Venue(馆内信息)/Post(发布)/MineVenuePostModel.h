//
//  MineVenuePostModel.h
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineVenuePostModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *title;        //标题
@property (nonatomic, copy) NSString *content;      //内容
@property (nonatomic, copy) NSString *likeNum;      //点赞量
@property (nonatomic, copy) NSString *commentNum;   //评论量
@property (nonatomic, copy) NSString *seeNum;       //浏览量
@property (nonatomic, copy) NSString *time;         //时间

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
