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
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *instnamecn;

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END


//accountId = 1264;
//addTime = 1582955199000;
//cconcernOfficeList = "<null>";
//displayName = "1126\U5408\U4f5c\U529e\U5b66\U65b0\U8fd0\U8425\U540d";
//eduUserCCollectPoList = "<null>";
//id = 7AB82B8CE3984227890ABB6DD51CA940;
//insId = 2839;
//insType = 4;
//instnamecn = "1126\U5408\U4f5c\U529e\U5b66\U65b0\U5168\U79f0";
//instnameen = "1126\U5408\U4f5c\U529e\U5b66\U65b0\U82f1\U6587\U5168\U79f0";
//logo = "<null>";
//officeId = "<null>";
//type = hzbx;
