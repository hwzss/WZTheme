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

#define _Lock() dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER)
#define _Unlock() dispatch_semaphore_signal(_lock)

static dispatch_queue_t _queue;
static inline dispatch_queue_t _shaow_process_queue() {
    if (!_queue) {
        _queue = dispatch_queue_create("com.wztheme.wzuishadowmanger.shadow.process", DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}
static inline void releaseQueue(){
    _queue = nil;
}

static dispatch_semaphore_t _lock;
static int _queue_hold_num = 0;

static void increaseHolder() {
    _Lock();
    _queue_hold_num++;
    _Unlock();
}
static void reduceHodler() {
    _Lock();
    --_queue_hold_num;
    if (_queue_hold_num == 0) releaseQueue();
    _Unlock();
}

@interface WZUIShadowManger ()

/**
 用于记录所有调用了主题的对象时的环境现场，已方便后面主题更新时，重新对现场进行执行，对UI进行重新赋值
 */
@property (strong, nonatomic) NSMapTable *shadowCahces;

@end

@implementation WZUIShadowManger

static id _instance;
+ (instancetype)manger {
    if (!_instance) {
        _instance = [[WZUIShadowManger alloc] init];
    }
    return _instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _lock = dispatch_semaphore_create(1);
        
        FOUNDATION_EXTERN NSNotificationName const WZThemeMangerDidSetNewAppThemeNotification;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_WZThemeMangerDidSetNewAppTheme) name:WZThemeMangerDidSetNewAppThemeNotification object:nil];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMapTable *)shadowCahces {
    if (!_shadowCahces) {
        _shadowCahces = [NSMapTable weakToStrongObjectsMapTable]; // FIXME: 可以的话需要替换weakToStrongObjectsMapTable
        /*
         Apple官方并不推荐weakToStrongObjectsMapTable，原因：The strong values for weak keys which get zeroed out continue to be maintained until the map table resizes itself. 同时自己测试多次使用key后key好像也不会立马消失
         */
    }
    return _shadowCahces;
}

#pragma - mark cache
- (void)wz_cacheShadow:(WZObjectShadow *)shadow forKey:(id)key {
    increaseHolder();
    dispatch_async(_shaow_process_queue(), ^{
        [self cacheShadow:shadow forKey:key];
        reduceHodler();
    });
}
- (void)cacheShadow:(WZObjectShadow *)shadow forKey:(id)key {
    if (shadow.shadowClass == [UIButton class]) {
        NSMutableArray *shadows = [self.shadowCahces objectForKey:key];
        if (shadows && shadows.count > 0) {
            __block BOOL didExistShadow = NO;
            [shadows enumerateObjectsUsingBlock:^(WZObjectShadow *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
                NSNumber *oldState = (NSNumber *) [[obj.values allObjects] lastObject];
                NSNumber *state = (NSNumber *) [[shadow.values allObjects] lastObject];
                if (oldState.integerValue == state.integerValue) {
                    obj = shadow;
                    didExistShadow = YES;
                    *stop = YES;
                }
            }];
            if (!didExistShadow) {
                [shadows addObject:shadow];
            }
        }
        else {
            shadows = [NSMutableArray arrayWithObject:shadow];
            [self.shadowCahces setObject:shadows forKey:key];
        }
    }
    else {
        [self.shadowCahces setObject:shadow forKey:key];
    }
}

#pragma - mark 下载了新主题需要，让影子对象重新执行下设置主题属性，比如重新设置图片
- (void)_WZThemeMangerDidSetNewAppTheme {
    dispatch_async(_shaow_process_queue(), ^{
        [[self.shadowCahces.objectEnumerator allObjects] enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            if ([obj isKindOfClass:[NSArray class]]) {
                [obj enumerateObjectsUsingBlock:^(WZObjectShadow *shadow, NSUInteger idx, BOOL *_Nonnull stop) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       [shadow doShadowOpreation];
                    });
                }];
            }
            else if ([obj isMemberOfClass:[WZObjectShadow class]]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [obj doShadowOpreation];
                });
            }
        }];
    });
}

@end
