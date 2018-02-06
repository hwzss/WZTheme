//
//  UIColor+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/23.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UIColor+WZTheme.h"
#import "UIColor+CIM.h"
#import "WZThemeManger.h"
@implementation UIColor (WZTheme)

+ (UIColor *)theme_colorName:(NSString *)colorName
{
    WZTheme *theme = [WZThemeManger manger].appTheme;
    NSBundle *themeBundle = [NSBundle bundleWithPath:theme.themeBundlePath];
    NSString *dictPath = [themeBundle pathForResource:@"Theme" ofType:@"plist"];
    NSDictionary *customThemeInfo = [[NSDictionary alloc] initWithContentsOfFile:dictPath];
    UIColor *color = [UIColor CIM_colorWithHexString:[customThemeInfo objectForKey:colorName]];
    return color;
}

@end
