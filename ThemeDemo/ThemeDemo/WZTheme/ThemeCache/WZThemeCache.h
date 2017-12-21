//
//  WZThemeCache.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZThemeCache : NSObject

+(NSError *)cacheThemeZipFileFrom:(NSString *)path toPath:(NSString *)destinationPath;
@end
