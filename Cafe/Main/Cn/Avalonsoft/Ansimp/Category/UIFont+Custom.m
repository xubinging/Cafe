//
//  UIFont+Custom.m
//  CMBase-d7afa43e
//
//  Created by zhangrui on 2019/9/5.
//

#import "UIFont+Custom.h"

@implementation UIFont (Custom)
+ (UIFont *)pingFangSCWithWeight:(FontWeightStyle)fontWeight size:(CGFloat)fontSize {
    if (fontWeight < FontWeightStyleMedium || fontWeight > FontWeightStyleThin) {
        fontWeight = FontWeightStyleRegular;
    }
    
    NSString *fontName = @"PingFangSC-Regular";
    switch (fontWeight) {
        case FontWeightStyleMedium:
            fontName = @"PingFangSC-Medium";
            break;
        case FontWeightStyleSemibold:
            fontName = @"PingFangSC-Semibold";
            break;
        case FontWeightStyleLight:
            fontName = @"PingFangSC-Light";
            break;
        case FontWeightStyleUltralight:
            fontName = @"PingFangSC-Ultralight";
            break;
        case FontWeightStyleRegular:
            fontName = @"PingFangSC-Regular";
            break;
        case FontWeightStyleThin:
            fontName = @"PingFangSC-Thin";
            break;
    }
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    
    return font ?: [UIFont systemFontOfSize:fontSize];
}

//系统字体
+ (UIFont *)customSystemFontOfSize:(CGFloat)fontSize weight:(CM_FontWeight)weight {
    UIFont *font;
    if (@available(iOS 8.2, *)) {
        UIFontWeight fontWeight;
        switch (weight) {
            case CM_FontWeightUltraLight:
                fontWeight = UIFontWeightBold;
                break;
                case CM_FontWeightThin:
                fontWeight = UIFontWeightThin;
                break;
                case CM_FontWeightLight:
                fontWeight = UIFontWeightLight;
                break;
                case CM_FontWeightRegular:
                fontWeight = UIFontWeightRegular;
                break;
                case CM_FontWeightMedium:
                fontWeight = UIFontWeightMedium;
                break;
                case CM_FontWeightSemibold:
                fontWeight = UIFontWeightSemibold;
                break;
                case CM_FontWeightBold:
                fontWeight = UIFontWeightBold;
                break;
                case CM_FontWeightHeavy:
                fontWeight = UIFontWeightHeavy;
                break;
                case CM_FontWeightBlack:
                fontWeight = UIFontWeightBlack;
                break;
        }
        font = [UIFont systemFontOfSize:fontSize weight:fontWeight];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    return font;
}

+ (UIFont *)dinCondensedBoldWithFontSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"DINCondensed-Bold" size:fontSize]?:[UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)sourceHanSerifWithFontSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Source Han Serif CN" size:fontSize]?:[UIFont systemFontOfSize:fontSize];
}
@end
