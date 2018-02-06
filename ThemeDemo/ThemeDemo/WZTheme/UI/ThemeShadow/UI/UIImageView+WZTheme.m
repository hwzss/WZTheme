//
//  UIImageView+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/21.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UIImageView+WZTheme.h"
#import "UIImage+WZTheme.h"
#import "WZShadowManger.h"

@implementation UIImageView (WZTheme)

- (void)wz_setImageWithName:(NSString *)imageName
{
    Snapshoot(imageName);
    [self setImage:[UIImage imageThemeName:imageName]];
}
@end


