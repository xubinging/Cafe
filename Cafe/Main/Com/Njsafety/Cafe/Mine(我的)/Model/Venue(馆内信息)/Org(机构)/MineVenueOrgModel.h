//
//  MineVenueOrgModel.h
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineVenueOrgModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger companyIndex;
@property (nonatomic, copy) UIImage *companyIcon;
@property (nonatomic, copy) NSString *companyName;

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
