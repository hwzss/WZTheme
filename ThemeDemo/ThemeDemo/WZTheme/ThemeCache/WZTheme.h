//
//  WZTheme.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZTheme : NSObject

@property (copy, nonatomic) NSString *themeName;
@property (strong, nonatomic) NSURL *themeLoaction;

/**
 主题的资源文件缓存的目录
 */
@property (copy, nonatomic) NSString *themeResourcePath;

/**
 主题的bundle文件的完整路径
 */
@property (copy, nonatomic) NSString *themeBundlePath;

/**
 是否可用
 */
@property (assign, nonatomic, getter=isAvailable) BOOL available;


+ (instancetype)themeName:(NSString *)themeName loaction:(NSURL *)loaction;

/**
  将主题保存到cache路径下属于自己的目录下

 @return 失败则返回error
 */
- (NSError *)resourceWriteToFile;
@end
