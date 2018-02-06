//
//  UIView+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/22.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UIView+WZTheme.h"
#import "WZShadowManger.h"
#import "UIColor+WZTheme.h"

@implementation UIView (WZTheme)

- (void)wz_setBackgroundColorWithName:(NSString *)colorName
{
    Snapshoot(colorName);
    [self setBackgroundColor:[UIColor theme_colorName:colorName]];
}
@end
