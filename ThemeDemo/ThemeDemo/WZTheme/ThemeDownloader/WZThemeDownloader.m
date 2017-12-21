//
//  WZThemeDownloader.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "WZThemeDownloader.h"

@implementation WZThemeDownloader

+ (void)downloadThemePachForm:(NSString *)downlaodLink completionHandler:(WZDownloaderSuccessBlock)completionHandler
{
    NSURL *url = [NSURL URLWithString:downlaodLink];
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url
                                                        completionHandler:^(NSURL *_Nullable location, NSURLResponse *_Nullable response, NSError *_Nullable error) {
                                                            !completionHandler ?: completionHandler(location, error);
                                                        }];
    [downloadTask resume];
}
@end
