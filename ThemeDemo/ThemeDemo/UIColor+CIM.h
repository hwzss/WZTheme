//
//  UIColor+CIM.h
//  CloudIM
//
//  Created by qwkj on 16/3/7.
//  Copyright © 2016年 qwkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CIM)
/**
 *  将16进制字符串转换成颜色
 *
 *  @param color 颜色字符串，支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 *  @return 颜色
 */
+ (UIColor *)CIM_colorWithHexString:(NSString *)color;

/**
 *  将16进制字符串转换成颜色
 *
 *  @param color 颜色字符串，支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)CIm_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
