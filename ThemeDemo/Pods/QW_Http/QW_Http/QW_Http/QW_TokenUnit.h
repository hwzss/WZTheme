//
//  QW_TokenUnit.h
//  QW_Http
//
//  Created by qwkj on 2017/11/9.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QW_TokenUnit : NSObject

@property (copy, nonatomic) NSString *timeStramp;
@property (copy, nonatomic) NSString *token;

+ (instancetype)tokenNow;

@end
