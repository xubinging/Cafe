//
//  _F.m
//  Cafe
//
//  Created by leo on 2019/12/11.
//  Copyright © 2019 leo. All rights reserved.
//

#import "_F.h"

@implementation _F

/**
 创建连接
 @param NSMutableDictionary
 @return
 */
#pragma mark - createRequestDicWithEventAction -
+ (NSMutableDictionary *)createRequestDicWithEventAction:(NSString *)eventAction
                                               eventType:(NSString *)eventType
{
    @try {
        
        NSMutableDictionary *root = [NSMutableDictionary dictionary];
        [root setValue:eventAction forKey:@"eventAction"];
        [root setValue:eventType forKey:@"eventType"];
        [root setObject:[NSMutableDictionary dictionary] forKey:@"params"];
        
        //设置一个可能存放多余变量的数组
        NSMutableArray *extObjs = [NSMutableArray array];
        [root setObject:extObjs forKey:@"extObjs"];
        
        return root;
        
    } @catch (NSException *exception) {
        //抛出异常，程序崩溃
        @throw exception;
    } @finally {
        
    }
}

#pragma mark - 使用颜色生成图片 -
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)aSize
{
    CGRect rect = CGRectMake(0.0f, 0.0f, aSize.width, aSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 获取当前日期 -
+ (NSString *)getCurrentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *datenow = [NSDate date];
    //将nsdate按formatter格式转成nsstring
    NSString *datenowString = [formatter stringFromDate:datenow];
    
    return datenowString;
}

#pragma mark - 获取当前时间：时分格式 -
+ (NSString *)getCurrentDatetimeHHmm
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSDate *datenow = [NSDate date];
    //将nsdate按formatter格式转成nsstring
    NSString *datenowString = [formatter stringFromDate:datenow];
    
    return datenowString;
}

#pragma mark - 获取当前时间：时分秒格式 -
+ (NSString *)getCurrentDatetimeHHmmss
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *datenow = [NSDate date];
    //将nsdate按formatter格式转成nsstring
    NSString *datenowString = [formatter stringFromDate:datenow];
    
    return datenowString;
}

#pragma mark - 计算某个时间距现在之间的秒数 -
+ (NSInteger)getTimeIntervalSecondSince:(int64_t)timeStart
{
    NSDate *d = [[NSDate alloc] initWithTimeIntervalSince1970:timeStart/1000.0];
    NSDate *datenow = [NSDate date];
    
    NSTimeInterval interval = [datenow timeIntervalSinceDate:d];
    return labs((NSInteger)interval);
}

#pragma mark - 获取所有字体 -
+ (void)getFontNames
{
    NSArray *familyNames = [UIFont familyNames];
    
    for (NSString *familyName in familyNames) {
        printf("familyNames = %s\n",[familyName UTF8String]);
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        
        for (NSString *fontName in fontNames) {
            printf("\tfontName = %s\n",[fontName UTF8String]);
        }
    }
}

#pragma mark - 统一设置标题label格式 -
+ (void)setLabelStyle:(UILabel *)titleLabel
            withName:(NSString *)labelName
       textAlignment:(NSTextAlignment)textAlignment
            textFont:(UIFont *)textFont
           textColor:(UIColor *)textColor
{
    titleLabel.numberOfLines = 0;
    titleLabel.alpha = 1.0;
    titleLabel.textAlignment = textAlignment;
    
    NSMutableAttributedString *titleLabelString = [[NSMutableAttributedString alloc] initWithString:labelName attributes: @{NSFontAttributeName: textFont, NSForegroundColorAttributeName: textColor}];
    titleLabel.attributedText = titleLabelString;
}

/**
 * lineView:       需要绘制成虚线的view
 * lineLength:     虚线的宽度
 * lineSpacing:    虚线的间距
 * lineColor:      虚线的颜色
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

/// 将按钮设置为图片在上，文字在
/// 这个方法应当在图片以及文字内容设置好，并且按钮尺寸已知的情况下才能正常使用
/// 如果使用 Masonry 进行布局，这个方法也不能完成图片在上，文字在下的需求。
/// @param button 按钮
/// @param spacing 图片和文字间距
+ (void)SetButtonPictureUpTextDownWithButton:(UIButton*)button andSpacing:(CGFloat)spacing{
    //使图片和文字居左上角
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    CGFloat buttonHeight = CGRectGetHeight(button.frame);
    CGFloat buttonWidth = CGRectGetWidth(button.frame);
    
    CGFloat ivHeight = CGRectGetHeight(button.imageView.frame);
    CGFloat ivWidth = CGRectGetWidth(button.imageView.frame);
    
    CGFloat titleHeight = CGRectGetHeight(button.titleLabel.frame);
    CGFloat titleWidth = CGRectGetWidth(button.titleLabel.frame);
    //调整图片
    float iVOffsetY = buttonHeight / 2.0 - (ivHeight + titleHeight) / 2.0;
    float iVOffsetX = buttonWidth / 2.0 - ivWidth / 2.0;
    [button setImageEdgeInsets:UIEdgeInsetsMake(iVOffsetY, iVOffsetX, 0, 0)];
    
    //调整文字
    float titleOffsetY = iVOffsetY + CGRectGetHeight(button.imageView.frame) + 10;
    float titleOffsetX = 0;
    if (CGRectGetWidth(button.imageView.frame) >= (CGRectGetWidth(button.frame) / 2.0)) {
        //如果图片的宽度超过或等于button宽度的一半
        titleOffsetX = -(ivWidth + titleWidth - buttonWidth / 2.0 - titleWidth / 2.0);
    }else {
        titleOffsetX = buttonWidth / 2.0 - ivWidth - titleWidth / 2.0;
    }
    [button setTitleEdgeInsets:UIEdgeInsetsMake(titleOffsetY , titleOffsetX, 0, 0)];
}

#pragma mark - 去掉小数点后多余的0 -
+ (NSString *)deleteFloatAllZero:(NSString *)string
{
    NSArray *arrStr = [string componentsSeparatedByString:@"."];
    
    NSString *str = arrStr.firstObject;
    NSString *str1 = arrStr.lastObject;
    
    while ([str1 hasSuffix:@"0"]) {
        str1 = [str1 substringToIndex:(str1.length - 1)];
    }
    
    return (str1.length>0)?[NSString stringWithFormat:@"%@.%@",str,str1]:str;
}

#pragma mark - 传文件名称读取json文件 -
//+ (NSArray *)readJsonFileWithFileName:(NSString *)filename
//{
//    NSMutableArray *arr = [NSMutableArray new];
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSArray *jsonArray = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions|NSJSONWritingPrettyPrinted error:nil] mutableCopy];
//    [jsonArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        
//    }];
//    
//    return arr;
//}

#pragma mark - 判断字符串不为空且不为nil -
+ (BOOL)isStringNotEmptyOrNil:(NSString *)string
{
    if(![string isEqualToString:@""] && string != nil)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - 给视图添加虚线边框 -
+ (void)addDottedBorderWithView:(UIView*)view borderColor:(UIColor *)color
{
    CGFloat viewWidth = view.frame.size.width;
    CGFloat viewHeight = view.frame.size.height;
    view.layer.cornerRadius = 8;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    borderLayer.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:8].CGPath;
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
    borderLayer.lineDashPattern = @[@4, @4];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = color.CGColor;
    [view.layer insertSublayer:borderLayer atIndex:0];
}

#pragma mark - 设置按钮图片在上文字在下 -
+ (void)adjustButtonImageViewUpTitleDownWithButton:(UIButton *)button
                                titleBottomSpacing:(CGFloat)titleBottomSpacing
                                imageBottomSpacing:(CGFloat)imageBottomSpacing{
    
    CGFloat imageWidth = CGRectGetWidth(button.imageView.frame);
    CGFloat imageHeight = CGRectGetHeight(button.imageView.frame);
    
    CGFloat titleWidth = CGRectGetWidth(button.titleLabel.frame);
    CGFloat titleHeight = CGRectGetHeight(button.titleLabel.frame);
    
    //UIEdgeInsetsMake: CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
    //使图片和文字水平居中显示
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageHeight, -imageWidth, titleBottomSpacing, 0)];
    
    //图片距离右边框距离减少图片的宽度，其它不边
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, imageBottomSpacing, -titleWidth)];
    
}

#pragma mark - 设置按钮文字在左图片在右 -
+ (void)adjustButtonTitleLeftImageViewRithtWithButton:(UIButton *)button
                                     imageLeftSpacing:(CGFloat)imageLeftSpacing;

{
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, - button.imageView.image.size.width, 0, button.imageView.image.size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width + imageLeftSpacing, 0, -button.titleLabel.bounds.size.width)];
}

#pragma mark - 设置内容格式 -
+ (void)setContentLabelStyle:(UILabel *)label
           withTextAlignment:(NSTextAlignment)textAlignment
                        font:(UIFont *)font
                       Color:(UIColor *)color
{
    label.alpha = 1.0;
    label.numberOfLines = 0;
    [label setTextAlignment:textAlignment];
    [label setFont:font];
    [label setTextColor:color];
}

// 校验手机号码
+(BOOL)validateMobile:(NSString *)mobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183,184,178
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181,177
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|70|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183,184,178
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[2-478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,176
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|76|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189,177
     22         */
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestct evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 校验密码 6-64位数字、字母组合密码 -
+ (BOOL)checkPassword:(NSString *)password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,64}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

#pragma mark - 毫秒转日期 -
+ (NSString *)ConvertStrToTime:(NSString *)timeStr
{
    long long time = [timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *timeString = [formatter stringFromDate:d];
    
    return timeString;
}

#pragma mark - 毫秒转日期 -
+ (NSString *)ConvertStrToDate:(NSString *)timeStr
{
    long long time = [timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *timeString = [formatter stringFromDate:d];
    
    return timeString;
}

#pragma mark - 去除数据中的 html 标签 -
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        //去除空格 &nbsp;
        html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    }
    
    return html;
}

#pragma mark - 创建文件url -
+(NSString *)createFileLoadUrl:(NSString *)fileAddress
{
    return [NSString stringWithFormat:@"%@%@",FILE_SERVER_URL,fileAddress];
}

#pragma mark - 判断值是不是 NSNull -
+(BOOL)isNull:(id)value
{
    BOOL isNull = [value isEqual:[NSNull null]];
    return isNull;
}

@end
