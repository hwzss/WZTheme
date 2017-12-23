//
//  UIButton+WZTheme.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/22.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WZTheme)

- (void)wz_setImageWithName:(NSString *)imageName forState:(UIControlState)state;

- (void)wz_setBackgroundImageWithName:(NSString *)imageName forState:(UIControlState)state;
@end
