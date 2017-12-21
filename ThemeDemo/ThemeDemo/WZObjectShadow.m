//
//  WZObjectShadow.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "WZObjectShadow.h"
#import <objc/runtime.h>

@interface WZObjectShadow ()

@property (weak, nonatomic) id obShadow;
@property (assign, nonatomic) Class shadowClass;
@property (assign, nonatomic) SEL shadowSel;

// FIXME: 这里不应该用nsarray类型，应该用pointarray，需要支持可存nil数据
@property (strong, nonatomic) NSArray *values;

@end

@implementation WZObjectShadow

+ (instancetype)shadowWithId:(id)obj class:(Class)ob_class sel:(SEL)sel values:(NSArray *)values
{
    WZObjectShadow *shadow = [[WZObjectShadow alloc] init];
    shadow.obShadow = obj;
    shadow.shadowClass = ob_class;
    shadow.shadowSel = sel;
    shadow.values = values;
    return shadow;
}

- (void) doShadowOpreation
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
                    func(_obShadow, _shadowSel, _values[0]);
                }
                break;
                case 2:
                {
                    void (*func)(id, SEL, id, id) = (void *) imp;
                    func(_obShadow, _shadowSel, _values[0], _values[1]);
                }
                break;

                default:
                    break;
                    // TODO:这里目前就对3个参数以下的方法做了处理，如果有参数超过可以对这里进行更改添加条件
            }
            
        }
    }
}
@end
