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

- (void)wz_setImageWithName:(NSString *)imageName
{
    
     if(({BOOL value; if ([@"" isEqualToString:@""]) {value = 1;}else{value = 0;}value;})){
         WZObjectShadow *shadow_of_self = [WZObjectShadow shadowWithId:self class:self.class sel:_cmd args:[WZObjectShadow args_end_flag]];
         [[WZThemeManger manger].shadowCahces setObject:shadow_of_self forKey:self];
     }else{
         WZObjectShadow *shadow_of_self = [WZObjectShadow shadowWithId:self class:self.class sel:_cmd args:, [WZObjectShadow args_end_flag]]; [[WZThemeManger manger].shadowCahces setObject:shadow_of_self forKey:self];};
    Snapshoot();
//    Snapshoot(imageName);
    [self setImage:[UIImage wz_themeImageName:imageName]];
}
@end
