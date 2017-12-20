//
//  UIImage+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UIImage+WZTheme.h"
#import "WZThemeManger.h"

@implementation UIImage (WZTheme)

+(UIImage *)wz_themeImageName:(NSString *)imageName{
    WZTheme *theme = [WZThemeManger manger].appTheme;
    NSBundle *imageBundle = [NSBundle bundleWithPath:theme.themeBundlePath];
    NSString *imagePath = [imageBundle pathForResource:imageName ofType:@"png"];
    
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
