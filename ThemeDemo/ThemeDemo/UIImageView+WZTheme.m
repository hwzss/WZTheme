//
//  UIImageView+WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/21.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "UIImageView+WZTheme.h"
#import "UIImage+WZTheme.h"
#import "WZThemeManger.h"

@implementation UIImageView (WZTheme)

-(void)wz_setImageWithName:(NSString *)imageName{
    
    WZObjectShadow *shadow_of_self = [WZObjectShadow shadowWithId:self class:self.class sel:@selector(wz_setImageWithName:) args:imageName,wz_args_end];
    [[WZThemeManger manger].shadowCahces setObject:shadow_of_self forKey:self];
    
    [self setImage:[UIImage wz_themeImageName:imageName]];
}
@end
