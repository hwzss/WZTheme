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
    
    int const TEST_NUM = 16;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < TEST_NUM; i++) {
            NSError *error;
            [SSZipArchive unzipFileAtPath:path toDestination:destinationPath overwrite:YES password:nil error:&error];
            if (!error) {
                NSLog(@"successed in global_queue");
            }
            else {
                NSLog(@"failed in global_queue,%@", [error description]);
            }
        }
    });
    for (int i = 0; i < TEST_NUM; i++) {
        NSError *error;
        [SSZipArchive unzipFileAtPath:path toDestination:destinationPath overwrite:YES password:nil error:&error];
        if (!error) {
            NSLog(@"successed in main queue");
        }
        else {
            NSLog(@"failed in main queue,%@", [error description]);
        }
    }

//    [SSZipArchive unzipFileAtPath:path toDestination:destinationPath overwrite:YES password:nil error:&error];
    return error;
}

@end
