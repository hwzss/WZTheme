//
//  WZThemeDownloader.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WZDownloaderSuccessBlock)(NSURL * location, NSError *error);

@interface WZThemeDownloader : NSObject

+(void)downloadThemePachForm:(NSString *)downlaodLink completionHandler:(WZDownloaderSuccessBlock )completionHandler;
@end
