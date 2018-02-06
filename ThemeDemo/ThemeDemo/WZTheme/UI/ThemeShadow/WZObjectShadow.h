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

@property (weak, nonatomic) id obShadow;
@property (assign, nonatomic) Class shadowClass;
@property (assign, nonatomic) SEL shadowSel;

@property (strong, nonatomic) NSPointerArray *values;

+ (instancetype)shadow:(id)obj class:(Class)ob_class sel:(SEL)sel args:(id)arg0, ...;

/**
 多参数的结束标示

 @return 标示
 */
+ (id)args_end_flag;

/**
 多参数的开始标示

 @return 开始标示
 */
+ (id)args_begin_flag;

/**
 执行捕捉的方法操作
 */
- (void)doShadowOpreation;

@end
