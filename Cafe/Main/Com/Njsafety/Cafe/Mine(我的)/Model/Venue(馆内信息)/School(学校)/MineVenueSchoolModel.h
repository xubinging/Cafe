//
//  MineVenueSchoolModel.h
//  Cafe
//
//  Created by leo on 2020/1/8.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineVenueSchoolModel : NSObject

//定义属性
@property (nonatomic, assign) NSInteger schoolIndex;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *instnamecn;
@property (nonatomic, copy) NSString *instnameen;

//工厂方法，需要传入字典。可以完成model的创建和属性的b批量赋值。
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END


//accountId = 1264;
//addTime = 1582958284000;
//cconcernOfficeList = "<null>";
//displayName = "<null>";
//eduUserCCollectPoList = "<null>";
//id = 37ED8E2FCC4B48A08452B1BADCAB5F66;
//insId = 2636;
//insType = 1;
//instnamecn = "\U827a\U672f\U5b66\U9662\U65e5\U671f\Uff1a9-16";
//instnameen = "art school when date";
//logo = "<null>";
//officeId = "<null>";
//type = 8;
