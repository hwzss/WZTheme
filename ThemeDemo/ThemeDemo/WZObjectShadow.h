//
//  WZObjectShadow.h
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZObjectShadow : NSObject

+(instancetype)shadowWithId:(id )obj class:(Class )ob_class sel:(SEL )sel values:(NSArray *)values;

-(void)doShadowOpreation;
@end
