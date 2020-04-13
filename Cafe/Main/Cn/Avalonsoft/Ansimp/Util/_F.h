//
//  _F.h
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//
//  项目方法类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface _F : NSObject

#pragma mark - 根据eventAction和eventType生成请求字典，然后在调用的地方，最后将字典转换成json字符串 -
+(NSMutableDictionary *)createRequestDicWithEventAction:(NSString *)eventAction
                                              eventType:(NSString *)eventType;

#pragma mark - 使用颜色生成图片 -
+(UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)aSize;

#pragma mark - 获取当前日期 -
+ (NSString *)getCurrentDate;

#pragma mark - 获取当前时间：时分格式 -
+ (NSString *)getCurrentDatetimeHHmm;

#pragma mark - 获取当前时间：时分秒格式 -
+ (NSString *)getCurrentDatetimeHHmmss;

#pragma mark - 计算某个时间距现在之间的秒数 -
+ (NSInteger)getTimeIntervalSecondSince:(int64_t)timeStart;

#pragma mark - 获取所有字体 -
+ (void)getFontNames;

#pragma mark - 统一设置标题label格式 -
+ (void)setLabelStyle:(UILabel *)titleLabel
            withName:(NSString *)labelName
       textAlignment:(NSTextAlignment)textAlignment
            textFont:(UIFont *)textFont
           textColor:(UIColor *)textColor;

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/// 将按钮设置为图片在上，文字在
/// 这个方法应当在图片以及文字内容设置好，并且按钮尺寸已知的情况下才能正常使用
/// 如果使用 Masonry 进行布局，这个方法也不能完成图片在上，文字在下的需求。
/// @param btn 按钮
/// @param spacing 图片和文字间距
+ (void)SetButtonPictureUpTextDownWithButton:(UIButton*)btn andSpacing:(CGFloat)spacing;
    
#pragma mark - 去掉小数点后多余的0 -
+ (NSString *)deleteFloatAllZero:(NSString *)string;

#pragma mark - 传文件名称读取json文件 -- 不提供具体的将值写入数组的步骤，因为字典中key值不确定 -
//+ (NSArray *)readJsonFileWithFileName:(NSString *)filename;

#pragma mark - 判断字符串不为空且不为nil -
+ (BOOL)isStringNotEmptyOrNil:(NSString *)string;

#pragma mark - 给视图添加虚线边框 -
+ (void)addDottedBorderWithView:(UIView*)view borderColor:(UIColor *)color;

#pragma mark - 设置按钮图片在上文字在下 -
+ (void)adjustButtonImageViewUpTitleDownWithButton:(UIButton *)button
                                titleBottomSpacing:(CGFloat)titleBottomSpacing
                                imageBottomSpacing:(CGFloat)imageBottomSpacing;

#pragma mark - 设置按钮文字在左图片在右 -
+ (void)adjustButtonTitleLeftImageViewRithtWithButton:(UIButton *)button
                                     imageLeftSpacing:(CGFloat)imageLeftSpacing;
    
#pragma mark - 设置内容格式 -
+ (void)setContentLabelStyle:(UILabel *)label
           withTextAlignment:(NSTextAlignment)textAlignment
                        font:(UIFont *)font
                       Color:(UIColor *)color;

#pragma mark - 验证手机号码 -
+ (BOOL)validateMobile:(NSString *)mobileNumber;

#pragma mark - 校验密码 -
+ (BOOL)checkPassword:(NSString *)password;

#pragma mark - 毫秒转日期yyyy-MM-dd HH:mm -
+ (NSString *)ConvertStrToTime:(NSString *)timeStr;

#pragma mark - 毫秒转日期yyyy-MM-dd -
+ (NSString *)ConvertStrToDate:(NSString *)timeStr;

#pragma mark - 去除数据中的 html 标签 -
+ (NSString *)filterHTML:(NSString *)html;

#pragma mark - 创建文件url -
+(NSString *)createFileLoadUrl:(NSString *)fileAddress;

#pragma mark - 判断值是不是 NSNull -
+(BOOL)isNull:(id)value;

@end

NS_ASSUME_NONNULL_END
