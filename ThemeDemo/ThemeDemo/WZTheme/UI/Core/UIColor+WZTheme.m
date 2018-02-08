//
//  UIColor+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/23.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UIColor+WZTheme.h"
#import "WZThemeManger.h"

@implementation UIColor (WZTheme)

+ (UIColor *)theme_colorName:(NSString *)colorName {
    WZTheme *theme = [WZThemeManger manger].appTheme;
    NSBundle *themeBundle = [NSBundle bundleWithPath:theme.themeBundlePath];
    NSString *dictPath = [themeBundle pathForResource:@"Theme" ofType:@"plist"];
    NSDictionary *customThemeInfo = [[NSDictionary alloc] initWithContentsOfFile:dictPath];
    UIColor *color = [UIColor theme_colorWithHexString:[customThemeInfo objectForKey:colorName] alpha:1.0f];
    return color;
}

+ (UIColor *)theme_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor clearColor];
    
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
