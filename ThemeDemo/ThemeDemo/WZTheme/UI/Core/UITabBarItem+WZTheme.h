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
 @param selectImageName 选择状态下的图片，可传nil
 */
- (void)wz_setImageWithName:(NSString *)imageName selectImageName:(NSString *)selectImageName;
@end
