//
//  UDUserDefaultsModel.h
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//
//  该类是一个单例，可以实现App内部各个类之间的数据共享。

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UDUserDefaultsModel : NSObject

// Value types
typedef NS_ENUM(NSInteger, UDUserDefaultsValueType) {
    UDUserDefaultsValueTypeInteger,         // NSInteger
    UDUserDefaultsValueTypeLong,            // Include:long,long long,short and unsigned
    UDUserDefaultsValueTypeFloat,
    UDUserDefaultsValueTypeDouble,
    UDUserDefaultsValueTypeBool,
    UDUserDefaultsValueTypeObject,
    UDUserDefaultsValueTypeUnknown
};

// Init
+ (instancetype)userDefaultsModel;

// Set default values
/**
 * Override this method,you can setup default values
 * Description: If the object has two properties such as 'name' and 'gender',you should return @{@"name": @"defaultName", @"gender": @defaultGender}
 */
- (NSDictionary *)setupDefaultValues;

/**
 * Override this method,you can setup NSUserDefaults‘ suiteName.
 */
- (NSString *)_suiteName;

@end

NS_ASSUME_NONNULL_END
