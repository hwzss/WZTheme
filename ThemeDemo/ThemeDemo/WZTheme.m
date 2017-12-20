//
//  WZTheme.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "WZTheme.h"
#import "WZThemeCache.h"

@interface WZTheme ()
@property (copy, nonatomic) NSString *bundleName;
@end

@implementation WZTheme

+ (instancetype)themeName:(NSString *)themeName loaction:(NSURL *)loaction
{
    WZTheme *theme = [[WZTheme alloc] init];
    theme.themeName = themeName;
    theme.themeLoaction = loaction;
    return theme;
}
// TODO: 目前bundle的文件名称为固定值，后期可以尝试修改成任意值
-(NSString *)bundleName{
    if (!_bundleName) {
        _bundleName = @"main";
    }
    return _bundleName;
}
-(NSString *)themeBundlePath{
    if (!_themeBundlePath) {
        if (self.themeResourcePath) {
            _themeBundlePath = [NSString stringWithFormat:@"%@/%@.bundle",self.themeResourcePath,self.bundleName];
        }
    }
    return _themeBundlePath;
}
- (NSString *)themeResourcePath
{
    if (!_themeResourcePath) {
        _themeResourcePath = [[WZTheme themeCacheDir] stringByAppendingPathComponent:self.themeName];
    }
    return _themeResourcePath;
}

-(BOOL)isAvailable{
    NSBundle *bundle =  [NSBundle bundleWithPath:self.themeBundlePath];
    return bundle?YES:NO;
}

- (NSError *)resourceWriteToFile
{
    return [WZThemeCache cacheThemeZipFileFrom:self.themeLoaction.path toPath:self.themeResourcePath];
}

+ (NSString *)themeCacheDir
{
    NSString *systemCacheDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *themeCacheDir = [systemCacheDir stringByAppendingPathComponent:@"Caches/wz_theme_cahches"];
    return themeCacheDir;
}
@end
