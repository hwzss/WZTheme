//
//  WZObjectShadowTests.m
//  ThemeDemo
//
//  Created by qwkj on 2018/2/5.
//  Copyright © 2018年 qwkj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WZObjectShadow.h"

@interface WZObjectShadowTests : XCTestCase

@property (assign, nonatomic, getter=didAccpetedNil) BOOL accpetNil;

@end

@implementation WZObjectShadowTests

//ob3:(id )ob3 ob4:(id )ob4
- (void)doneIfNil:(id)ob ob2:(id)ob2 ob3:(id)ob3 ob4:(id)ob4
{
    //ob与ob2需为空
    self.accpetNil = (!ob && !ob3) ? YES : NO;
}
#pragma - mark 测试创建shadow时args传nil是否有效
- (void)testArgsNil
{
    WZObjectShadow *aShadow = [WZObjectShadow shadow:self class:self.class sel:@selector(doneIfNil:ob2:ob3:ob4:) args:wz_args_begin, nil, @"哈哈", nil, @"哈哈2", wz_args_end];
    self.accpetNil = NO;
    [aShadow doShadowOpreation];
    
    XCTAssertTrue(self.accpetNil, @"不为空说明没有接收nil");
}

- (void)testDoShadowOpreation
{
    UIView *aView = [[UIView alloc] init];
    UIColor *color = [UIColor redColor];

    WZObjectShadow *viewShadow = [WZObjectShadow shadow:aView class:aView.class sel:@selector(setBackgroundColor:) args:wz_args_begin, color, wz_args_end];
    [viewShadow doShadowOpreation];
    
    XCTAssertNotNil(aView.backgroundColor, @"不应该为空");
    XCTAssertEqual(color, aView.backgroundColor, @"颜色应该相等");
}

#pragma - mark 测试是否支持弱持有主对象，即主对象释放，shadow里面的obshadow应该为空
- (void)testWeakRefrence
{
    __weak UIView *weakView;
    WZObjectShadow *viewShadow;
    
    {
        UIView *tempView = [[UIView alloc] init];
        viewShadow = [WZObjectShadow shadow:tempView class:[tempView class] sel:@selector(setBackgroundColor:) args:[UIColor whiteColor], wz_args_end];
        weakView = tempView;
        
        [viewShadow doShadowOpreation];
    }
    
    XCTAssertNil(weakView, @"weakView应该为nil");
}

@end
