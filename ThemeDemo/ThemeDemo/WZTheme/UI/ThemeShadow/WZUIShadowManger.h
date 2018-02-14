//
//  WZShadowManger.h
//  ThemeDemo
//
//  Created by qwkj on 2018/2/5.
//  Copyright © 2018年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZObjectShadow.h"

#define Snapshoot(...)                                                                                                                      \
    WZObjectShadow *shadow_of_self = [WZObjectShadow shadow:self class:self.class sel:_cmd args:wz_args_begin, ##__VA_ARGS__, wz_args_end]; \
    [[WZUIShadowManger manger] wz_cacheShadow:shadow_of_self forKey:self]

@interface WZUIShadowManger : NSObject
/**
 默认为YES,更新UI的操作放在RunLoop的kCFRunLoopDefaultMode模式上的，如果设置为NO的话将NSRunLoopCommonModes下工作
 */
@property (assign) BOOL delay;

- (void)wz_cacheShadow:(WZObjectShadow *)shadow forKey:(id)key;
+ (instancetype)manger;

@end
