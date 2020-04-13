//
//  AvalonsoftCountryCodeController.h
//  Cafe
//
//  Created by leo on 2020/1/2.
//  Copyright © 2020 leo. All rights reserved.
//
//  国家代码选择界面

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^returnCountryCodeBlock) (NSString *countryName, NSString *code);

@protocol AvalonsoftCountryCodeControllerDelegate <NSObject>

@optional

/**
 Delegate 回调所选国家代码

 @param countryName 所选国家
 @param code 所选国家代码
 */
-(void)returnCountryName:(NSString *)countryName code:(NSString *)code;

@end

@interface AvalonsoftCountryCodeController : UIViewController

@property (nonatomic, weak) id<AvalonsoftCountryCodeControllerDelegate> deleagete;

@property (nonatomic, copy) returnCountryCodeBlock returnCountryCodeBlock;

@end

NS_ASSUME_NONNULL_END
