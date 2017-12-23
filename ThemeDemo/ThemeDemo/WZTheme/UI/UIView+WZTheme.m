//
//  UIView+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/22.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UIView+WZTheme.h"
#import "WZThemeManger.h"
#import "UIColor+CIM.h"

@implementation UIView (WZTheme)

-(void)wz_setThemeBackgroundColorWithName:(NSString *)colorName{
    
    Snapshoot(colorName);
    
    WZTheme *theme = [WZThemeManger manger].appTheme;
    NSBundle *themeBundle = [NSBundle bundleWithPath:theme.themeBundlePath];
    NSString *dictPath = [themeBundle pathForResource:@"Theme" ofType:@"plist"];
    NSDictionary *usersDic = [[NSDictionary alloc]initWithContentsOfFile:dictPath];
    
    UIColor *color = [UIColor CIM_colorWithHexString:[usersDic objectForKey:colorName]];
    [self setBackgroundColor:color];
}
@end