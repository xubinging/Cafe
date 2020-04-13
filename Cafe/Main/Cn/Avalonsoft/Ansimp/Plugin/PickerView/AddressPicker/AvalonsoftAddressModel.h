//
//  AvalonsoftAddressModel.h
//  Cafe
//
//  Created by leo on 2020/1/4.
//  Copyright © 2020 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AvalonsoftAddressModel : NSObject

@end

@class AvalonsoftProvinceModel, AvalonsoftCityModel, AvalonsoftTownModel;

@interface AvalonsoftProvinceModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *city;
@property (nonatomic, copy) NSString *code;

@end


@interface AvalonsoftCityModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *town;
@property (nonatomic, copy) NSString *code;

@end


@interface AvalonsoftTownModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;

@end

