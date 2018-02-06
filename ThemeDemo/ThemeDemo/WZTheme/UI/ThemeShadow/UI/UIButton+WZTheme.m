//
//  UIButton+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/22.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UIButton+WZTheme.h"
#import "WZShadowManger.h"
#import "UIImage+WZTheme.h"

@implementation UIButton (WZTheme)

- (void)wz_setImageWithName:(NSString *)imageName forState:(UIControlState)state
{
    [self setImageWithName:imageName forStateBox:@(state)];
}
- (void)setImageWithName:(NSString *)imageName forStateBox:(NSNumber *)stateBox
{
    Snapshoot(imageName, stateBox);
    [self setImage:[UIImage imageThemeName:imageName] forState:stateBox.integerValue];
}

- (void)wz_setBackgroundImageWithName:(NSString *)imageName forState:(UIControlState)state
{
    [self setBackgroundImageWithName:imageName forStateBox:@(state)];
}
- (void)setBackgroundImageWithName:(NSString *)imageName forStateBox:(NSNumber *)stateBox
{
    Snapshoot(imageName, stateBox);
    [self setBackgroundImage:[UIImage imageThemeName:imageName] forState:stateBox.integerValue];
}

@end

