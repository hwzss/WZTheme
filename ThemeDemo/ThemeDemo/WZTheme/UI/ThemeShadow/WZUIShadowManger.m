//
//  WZShadowManger.m
//  ThemeDemo
//
//  Created by qwkj on 2018/2/5.
//  Copyright © 2018年 qwkj. All rights reserved.
//

#import "WZUIShadowManger.h"
#import "WZObjectShadow.h"
#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSNotificationName const WZThemeMangerDidSetNewAppThemeNotification;

@interface WZUIShadowManger ()
{
    dispatch_queue_t _queue;
}

/**
 用于记录所有调用了主题的对象时的环境现场，已方便后面主题更新时，重新对现场进行执行，对UI进行重新赋值
 */
@property (strong, nonatomic) NSMapTable *shadowCahces;

@end

@implementation WZUIShadowManger

static id _instance;
+ (instancetype)manger
{
    if (!_instance)
    {
        _instance = [[WZUIShadowManger alloc] init];
    }
    return _instance;
}
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _queue = dispatch_queue_create("com.qwkj.theme.shadowManger.enumerate.sshadowCahces", DISPATCH_QUEUE_SERIAL);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_WZThemeMangerDidSetNewAppTheme) name:WZThemeMangerDidSetNewAppThemeNotification object:nil];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMapTable *)shadowCahces
{
    if (!_shadowCahces)
    {
        _shadowCahces = [NSMapTable weakToStrongObjectsMapTable]; // FIXME: 可以的话需要替换weakToStrongObjectsMapTable

        /*
         Apple官方并不推荐weakToStrongObjectsMapTable，原因：The strong values for weak keys which get zeroed out continue to be maintained until the map table resizes itself. 同时自己测试多次使用key后key好像也不会立马消失
         */
    }
    return _shadowCahces;
}

#pragma - mark cache
- (void)wz_cacheShadow:(WZObjectShadow *)shadow forKey:(id)key
{
    dispatch_async(_queue, ^{
        [self cacheShadow:shadow forKey:key];
    });
}
- (void)cacheShadow:(WZObjectShadow *)shadow forKey:(id)key
{
    if (shadow.shadowClass == [UIButton class])
    {
        NSMutableArray *shadows = [self.shadowCahces objectForKey:key];
        if (shadows && shadows.count > 0)
        {
            __block BOOL didExistShadow = NO;
            [shadows enumerateObjectsUsingBlock:^(WZObjectShadow *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
                NSNumber *oldState = (NSNumber *) [[obj.values allObjects] lastObject];
                NSNumber *state = (NSNumber *) [[shadow.values allObjects] lastObject];
                if (oldState.integerValue == state.integerValue)
                {
                    obj = shadow;
                    didExistShadow = YES;
                    *stop = YES;
                }
            }];
            if (!didExistShadow)
            {
                [shadows addObject:shadow];
            }
        }
        else
        {
            shadows = [NSMutableArray arrayWithObject:shadow];
            [self.shadowCahces setObject:shadows forKey:key];
        }
    }
    else
    {
        [self.shadowCahces setObject:shadow forKey:key];
    }
}

#pragma - mark 下载了新主题需要，让影子对象重新执行下设置主题属性，比如重新设置图片
- (void)_WZThemeMangerDidSetNewAppTheme
{
    dispatch_async(_queue, ^{
        [[self.shadowCahces.objectEnumerator allObjects] enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            
            if ([obj isKindOfClass:[NSArray class]])
            {
                [obj enumerateObjectsUsingBlock:^(WZObjectShadow *shadow, NSUInteger idx, BOOL *_Nonnull stop) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       [shadow doShadowOpreation];
                    });
                }];
            }
            else if ([obj isMemberOfClass:[WZObjectShadow class]])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [obj doShadowOpreation];
                });
            }
        }];
       
    });
}

@end
