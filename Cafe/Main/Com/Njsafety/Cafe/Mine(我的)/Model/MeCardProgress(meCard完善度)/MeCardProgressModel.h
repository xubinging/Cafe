//
//  MeCardProgressModel.h
//  Cafe
//
//  Created by leo on 2020/1/6.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeCardProgressModel : NSObject

//定义属性
@property (nonatomic, copy) NSString *title;            //标题
@property (nonatomic, copy) NSString *isCompleteFlg;    //是否完成标志位

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
