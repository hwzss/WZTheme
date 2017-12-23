//
//  WZThemeManger.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZTheme.h"
#import "WZObjectShadow.h"


#define Snapshoot(...) \
WZObjectShadow *shadow_of_self = [WZObjectShadow shadow:self class:self.class sel:_cmd args:wz_args_begin,##__VA_ARGS__,wz_args_end]; \
[[WZThemeManger manger].shadowCahces setObject:shadow_of_self forKey:self]




@interface WZThemeManger : NSObject

/**
 当前使用的App主题
 */
@property (strong, nonatomic) WZTheme *appTheme;

/**
 统一的管理者，程序中应该使用该方法返回的唯一WZThemeManger的实例

 @return 主题管理者
 */
+(instancetype)manger;

/**
 设置默认的主题，其中包含主题默认的bundle文件

 @param bundleName bundle文件名
 @param themeName 主题名称
 */
-(void)defaultThemeWithBunldeName:(NSString *)bundleName themeName:(NSString *)themeName;

/**
 让App使用默认的主题
 */
- (void)useDefaultTheme;

/**
 通过给定主题资源链接前往下载主题

 @param urlStr 主题链接
 @param themeName 主题名称
 */
-(void)downloadThemeFrom:(NSString *)urlStr themeName:(NSString *)themeName;

/**
 用于记录所有调用了主题的对象时的环境现场，已方便后面主题更新时，重新对现场进行执行，对UI进行重新赋值
 */
@property (strong, nonatomic) NSMapTable *shadowCahces;
@end
