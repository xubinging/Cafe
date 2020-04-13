//
//  AvalonsoftAddressModel.m
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//

#import "AvalonsoftAddressModel.h"

@implementation AvalonsoftAddressModel

@end

@implementation AvalonsoftProvinceModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{
//             @"name": @"v",
//             @"city": @"n"
//             };
//}
//
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{
//             @"city": [AvalonsoftCityModel class]
//             };
//}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end


@implementation AvalonsoftCityModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{
//             @"name": @"v",
//             @"town": @"n"
//             };
//}
//
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{
//             @"town": [AvalonsoftTownModel class]
//             };
//}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end


@implementation AvalonsoftTownModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{
//             @"name": @"v"
//             };
//}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
