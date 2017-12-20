//
//  WZThemeManger.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZTheme.h"

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
 通过给定主题资源链接前往下载主题

 @param urlStr 主题链接
 @param themeName 主题名称
 */
-(void)downloadThemeFrom:(NSString *)urlStr themeName:(NSString *)themeName;
@end
