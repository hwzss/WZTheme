//
//  WZThemeManger.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "WZThemeManger.h"
#import "WZThemeDownloader.h"


static id _instacne = nil;
@interface WZThemeManger ()

/**
 默认的主题，当没有可使用的主题包使用时使用默认的主题
 */
@property (strong, nonatomic) WZTheme *defaultTheme;


@end

@implementation WZThemeManger
@synthesize appTheme = _appTheme;

#pragma -mark getter setter
- (WZTheme *)appTheme
{
    if (!_appTheme)
    {
        _appTheme = [self fetchAppThemeUsed];
        if (!_appTheme||!_appTheme.isAvailable)
        {
            _appTheme = self.defaultTheme;
        }
    }
    return _appTheme;
}
- (void)setAppTheme:(WZTheme *)appTheme
{
    _appTheme = appTheme;
    // TODO: 添加自动更新更新所有使用了主题方式的UI

    //更新缓存中正在使用的主题为当前缓存
    [self cacheTheme:appTheme];
    //刷新界面
    [self updaterAllShadowUI];
}

-(NSMapTable *)shadowCahces{
    if (!_shadowCahces) {
        _shadowCahces = [NSMapTable weakToStrongObjectsMapTable];
    }
    return _shadowCahces;
}
#pragma -mark method

+ (instancetype)manger
{
    if (!_instacne)
    {
        _instacne = [[WZThemeManger alloc] init];
    }
    return _instacne;
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
                                   //保存theme到文件
                                   NSError *error = [aTheme resourceWriteToFile];
                                   if (!error)
                                   {
                                       self.appTheme = aTheme;
                                       NSLog(@"新主题安装成功");
                                   }
                                   else
                                   {
                                       NSLog(@"主题解析失败");
                                   }
                               }
                           }];
}

#pragma -mark 下载了新主题需要，让影子对象重新执行下设置主题属性，比如重新设置图片
- (void)updaterAllShadowUI{
    [[self.shadowCahces.objectEnumerator allObjects] enumerateObjectsUsingBlock:^(WZObjectShadow *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj doShadowOpreation];
    }];
}
// FIXME: 主题信息的存取应该使用数据库的方式
#pragma - mark 保存到本地数据库
- (WZTheme *)fetchAppThemeUsed
{
    // TODO: 下面常量定义需修改成静态常量
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *cacheDict = [userDefaults objectForKey:@"current_theme"];
    WZTheme *theme;
    if (cacheDict)
    {
        theme = [[WZTheme alloc] init];
        theme.themeName = [cacheDict objectForKey:@"themeName"];
    }
    return theme;
}
-(void)cacheTheme:(WZTheme *)theme{
    NSDictionary *cacheDict = @{
                                @"themeName":theme.themeName,
                                };
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:cacheDict forKey:@"current_theme"];
}


@end
