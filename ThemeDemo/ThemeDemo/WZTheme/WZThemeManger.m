//
//  WZThemeManger.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "WZThemeManger.h"
#import "WZThemeDownloader.h"

NSNotificationName const WZThemeMangerDidSetNewAppThemeNotification = @"WZThemeMangerDidSetNewAppThemeNotification";

static id _instance;

@interface WZThemeManger ()

/**
 默认的主题，当没有可使用的主题包使用时使用默认的主题
 */
@property (strong, nonatomic) WZTheme *defaultTheme;

@end

@implementation WZThemeManger
@synthesize appTheme = _appTheme;

#pragma - mark getter setter
- (WZTheme *)appTheme
{
    if (!_appTheme)
    {
        _appTheme = [self fetchAppThemeUsed];
        if (!_appTheme || !_appTheme.isAvailable)
        {
            _appTheme = self.defaultTheme;
        }
    }
    return _appTheme;
}
- (void)setAppTheme:(WZTheme *)appTheme
{
    _appTheme = appTheme;

    //更新缓存中正在使用的主题为当前主题
    [self cacheTheme:appTheme];

    dispatch_async(dispatch_get_main_queue(), ^{
       [[NSNotificationCenter defaultCenter] postNotificationName:WZThemeMangerDidSetNewAppThemeNotification object:nil];
    });
}

#pragma - mark method
+ (instancetype)manger
{
    if (!_instance)
    {
        _instance = [[WZThemeManger alloc] init];
    }
    return _instance;
}

- (void)defaultThemeWithBunldeName:(NSString *)bundleName themeName:(NSString *)themeName
{
    NSString *resourcePath = [NSBundle mainBundle].resourcePath;
    //记录默认主题
    WZTheme *theme = [[WZTheme alloc] init];
    theme.themeName = themeName;
    theme.themeResourcePath = resourcePath;
    self.defaultTheme = theme;
}

- (void)useDefaultTheme
{
    self.appTheme = self.defaultTheme;
}

#pragma - mark 下载主题
- (void)downloadThemeFrom:(NSString *)urlStr themeName:(NSString *)themeName
{
    /*
     TODO: 后期应该加一个md5校验，防止同一个主题同一个文件每次都会去下载主题文件，前提也是需要先建数据库
           目前先简单的比较当前正在使用的主题和需下载的主题是否一致
     */
    if ([self.appTheme.themeName isEqualToString:themeName])
    {
        return;
    }
    [WZThemeDownloader downloadThemePachForm:urlStr
                           completionHandler:^(NSURL *location, NSError *error) {
                               if (!error)
                               {
                                   WZTheme *aTheme = [WZTheme themeName:themeName loaction:location];
                                   NSError *cacheError = [aTheme resourceWriteToFile];
                                   if (!cacheError)
                                   {
                                       self.appTheme = aTheme;
                                       NSLog(@"新主题安装成功");
                                   }
                                   else
                                   {
                                       NSLog(@"主题解析失败,%@", [cacheError description]);
                                   }
                                   
                                }
                           }];
}

// FIXME: 主题信息的存取应该使用数据库的方式
static NSString *const CURRENT_THEME = @"current_theme";
static NSString *const THEME_NAME = @"themeName";
#pragma - mark 保存到本地数据库
- (WZTheme *)fetchAppThemeUsed
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *cacheDict = [userDefaults objectForKey:CURRENT_THEME];
    WZTheme *theme;
    if (cacheDict)
    {
        theme = [[WZTheme alloc] init];
        theme.themeName = [cacheDict objectForKey:THEME_NAME];
    }
    return theme;
}
-(void)cacheTheme:(WZTheme *)theme
{
    NSDictionary *cacheDict = @{THEME_NAME:theme.themeName};
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:cacheDict forKey:CURRENT_THEME];
}


@end
