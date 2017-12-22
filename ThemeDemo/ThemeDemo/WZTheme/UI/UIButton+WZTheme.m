//
//  UIButton+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/22.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UIButton+WZTheme.h"
#import "WZThemeManger.h"
#import "UIImage+WZTheme.h"
@implementation UIButton (WZTheme)

-(void)wz_setImageWithName:(NSString *)imageName forState:(UIControlState)state{
    WZObjectShadow *shadow_of_self = [WZObjectShadow shadowWithId:self class:self.class sel:_cmd args:imageName,state, wz_args_end];
    [[WZThemeManger manger].shadowCahces setObject:shadow_of_self forKey:self];
    
    [self setImage:[UIImage wz_themeImageName:imageName] forState:state];
}

-(void)wz_setBackgroundImageWithName:(NSString *)imageName forState:(UIControlState)state{
    
    WZObjectShadow *shadow_of_self = [WZObjectShadow shadowWithId:self class:self.class sel:_cmd args:imageName,state, wz_args_end];
    [[WZThemeManger manger].shadowCahces setObject:shadow_of_self forKey:self];
    
    [self setBackgroundImage:[UIImage wz_themeImageName:imageName] forState:state];
    
}

@end
