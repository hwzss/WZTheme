//
//  UITabBarItem+WZTheme.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/23.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (WZTheme)

/**
 设置tabbarItem的图片

 @param imageName normal状态下的图片
 @param selectedImageName 选择状态下的图片，可传nil
 */
- (void)wz_setImageWithName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;

/**
 设置tabbarItem.image

 @param imageName 主题图片名称
 @param renderingMode 渲染模式
 */
- (void)wz_setNormalImageWithName:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode;

/**
 设置tabbarItem.selectedImage
 
 @param imageName 主题图片名称
 @param renderingMode 渲染模式
 */
- (void)wz_setSelectedImageWithName:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode;

@end
