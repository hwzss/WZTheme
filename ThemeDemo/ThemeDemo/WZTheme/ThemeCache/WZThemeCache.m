//
//  WZThemeCache.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "WZThemeCache.h"
#import <SSZipArchive/SSZipArchive.h>

@implementation WZThemeCache

+ (NSError *)cacheThemeZipFileFrom:(NSString *)path toPath:(NSString *)destinationPath
{
    NSError *error = nil;
    [SSZipArchive unzipFileAtPath:path toDestination:destinationPath overwrite:YES password:nil error:&error];
    return error;
}

@end

