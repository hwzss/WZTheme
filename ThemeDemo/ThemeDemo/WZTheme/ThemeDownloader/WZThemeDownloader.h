//
//  WZThemeDownloader.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WZDownloaderCompleteBlock)(NSURL * location, NSError *error);

@interface WZThemeDownloader : NSObject


/**
 给定链接下载文件

 @param downlaodLink 下载链接
 @param completionHandler 成功回调，返回下载文件路径，
 */
+(void)downloadThemePachForm:(NSString *)downlaodLink completionHandler:(WZDownloaderCompleteBlock )completionHandler;
@end
