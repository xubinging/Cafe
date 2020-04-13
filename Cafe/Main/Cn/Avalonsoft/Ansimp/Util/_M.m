//
//  _M.m
//  simp
//
//  Created by leo on 2019/6/24.
//  Copyright © 2019 leo. All rights reserved.
//

#import "_M.h"

@implementation _M

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

//KVC赋值
+ (instancetype)createResponseJsonObj:(NSDictionary *)dic
{
    _M *m = [[_M alloc] init];
    
    [m setValuesForKeysWithDictionary:dic];
    
    return m;
}

//通过字符串生成
+ (instancetype)createResponseJsonObjWithString:(NSString *)str
{
    //字符串转字典
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    //kvc赋值
    _M *m = [[_M alloc] init];
    [m setValuesForKeysWithDictionary:dic];
    return m;
    
}

@end
