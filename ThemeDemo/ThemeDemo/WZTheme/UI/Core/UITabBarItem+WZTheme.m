//
//  UITabBarItem+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/23.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UITabBarItem+WZTheme.h"
#import "WZThemeManger.h"
#import "UIImage+WZTheme.h"

@implementation UITabBarItem (WZTheme)
// FIXME: 这里图片的渲染方式最好最为参数传入
- (void)wz_setImageWithName:(NSString *)imageName selectImageName:(NSString *)selectImageName
{
    Snapshoot(imageName, selectImageName);
    if (imageName)
    {
        self.image = [[UIImage imageThemeName:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if (selectImageName)
    {
        self.selectedImage = [[UIImage imageThemeName:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}
@end
