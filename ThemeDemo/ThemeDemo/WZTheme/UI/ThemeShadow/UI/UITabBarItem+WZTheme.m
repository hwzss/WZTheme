//
//  UITabBarItem+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/23.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UITabBarItem+WZTheme.h"
#import "WZUIShadowManger.h"
#import "UIImage+WZTheme.h"

@implementation UITabBarItem (WZTheme)

- (void)wz_setImageWithName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    Snapshoot(imageName, selectedImageName);
    if (imageName)
    {
        self.image = [[UIImage imageThemeName:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if (selectedImageName)
    {
        self.selectedImage = [[UIImage imageThemeName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

- (void)wz_setNormalImageWithName:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode
{
    [self setNormalImageWithName:imageName renderingMode:@(renderingMode)];
}

- (void)setNormalImageWithName:(NSString *)imageName renderingMode:(NSNumber *)renderingModeBox
{
    Snapshoot(imageName, renderingModeBox);
    self.image = [[UIImage imageThemeName:imageName] imageWithRenderingMode:renderingModeBox.integerValue];
}

- (void)wz_setSelectedImageWithName:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode
{
    [self setSelectedImageWithName:imageName renderingMode:@(renderingMode)];
}
- (void)setSelectedImageWithName:(NSString *)imageName renderingMode:(NSNumber *)renderingModeBox
{
    Snapshoot(imageName, renderingModeBox);
    self.selectedImage = [[UIImage imageThemeName:imageName] imageWithRenderingMode:renderingModeBox.integerValue];
}


@end
