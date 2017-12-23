//
//  WZObjectShadow.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>

#define wz_args_end [WZObjectShadow args_end_flag]
#define wz_args_begin [WZObjectShadow args_begin_flag]

@interface WZObjectShadow : NSObject

+ (instancetype)shadow:(id)obj class:(Class)ob_class sel:(SEL)sel args:(id)arg0, ...;

+ (id)args_end_flag;
+ (id)args_begin_flag;

- (void)doShadowOpreation;
@end
