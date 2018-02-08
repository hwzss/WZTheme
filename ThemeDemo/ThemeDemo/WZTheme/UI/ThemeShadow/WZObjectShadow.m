//
//  WZObjectShadow.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "WZObjectShadow.h"
#import <objc/runtime.h>

static id WZ_VA_BEGIN;
static id WZ_VA_END;//可变参数方法时，多参数的最后一个结束标示

@implementation WZObjectShadow

+ (id)args_begin_flag
{
    if (!WZ_VA_BEGIN)
    {
        WZ_VA_BEGIN = [[NSObject alloc] init];
    }
    return WZ_VA_BEGIN;
}
+ (id)args_end_flag
{
    if (!WZ_VA_END)
    {
        WZ_VA_END = [[NSObject alloc] init];
    }
    return WZ_VA_END;
}
+ (instancetype)shadow:(id)obj class:(Class)ob_class sel:(SEL)sel args:(id)arg0, ...
{
    WZObjectShadow *shadow = [[WZObjectShadow alloc] initWithOb:obj class:ob_class sel:sel];
    
    va_list list;
    va_start(list, arg0);
    while (YES)
    {
        id next_arg = va_arg(list, id);
        if (next_arg == WZ_VA_BEGIN){
            continue;
        }
        if (next_arg == WZ_VA_END)
        {
            break;
        }
        [shadow.values addPointer:(__bridge void *_Nullable)(next_arg)];
    }
    va_end(list);
    return shadow;
}
- (instancetype)initWithOb:(id )obj class:(Class)ob_class sel:(SEL)sel
{
    self = [super init];
    if (self) {
        _obShadow = obj;
        _shadowClass = ob_class;
        _shadowSel = sel;
    }
    return self;
}

- (NSPointerArray *) values
{
    if (!_values)
    {
        _values = [NSPointerArray strongObjectsPointerArray];
    }
    return _values;
}

- (void)doShadowOpreation
{
    if (!_obShadow || !_shadowSel)
    {
        return;
    }

    Method aMethod = class_getInstanceMethod(_shadowClass, _shadowSel);
    if (aMethod)
    {
        unsigned argsNum = method_getNumberOfArguments(aMethod) - 2; //方法参数一般都默认有id,sel两个参数，所以求自己的参数数量时应该减去2
        if (_values.count == argsNum)
        {
            // REVIEW: 这里可以加上参数类型比较
            IMP imp = method_getImplementation(aMethod);
            switch (_values.count)
            {
                case 0:
                {
                    void (*func)(id, SEL) = (void *) imp;
                    func(_obShadow, _shadowSel);
                }

                break;
                case 1:
                {
                    void (*func)(id, SEL, id) = (void *) imp;
                    func(_obShadow, _shadowSel, [_values pointerAtIndex:0]);
                }
                break;
                case 2:
                {
                    void (*func)(id, SEL, id, id) = (void *) imp;
                    func(_obShadow, _shadowSel, [_values pointerAtIndex:0], [_values pointerAtIndex:1]);
                }
                break;
                case 3:
                {
                    void (*func)(id, SEL, id, id, id) = (void *) imp;
                    func(_obShadow, _shadowSel, [_values pointerAtIndex:0], [_values pointerAtIndex:1], [_values pointerAtIndex:2]);
                }
                break;
                case 4:
                {
                    void (*func)(id, SEL, id, id, id, id) = (void *) imp;
                    func(_obShadow, _shadowSel, [_values pointerAtIndex:0], [_values pointerAtIndex:1], [_values pointerAtIndex:2], [_values pointerAtIndex:3]);
                }
                break;

                default:
                    break;
                    
            }
            
        }
    }
}
@end
