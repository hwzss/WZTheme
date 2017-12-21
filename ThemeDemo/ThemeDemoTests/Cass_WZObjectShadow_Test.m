//
//  Cass_WZObjectShadow_Test.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/21.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WZObjectShadow.h"


@interface Cass_WZObjectShadow_Test : XCTestCase

@end

@implementation Cass_WZObjectShadow_Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testDoShadowOpreation{
    UIView *aView = [[UIView alloc]init];
    
    UIColor *color = [UIColor redColor];
    WZObjectShadow *viewShadow = [WZObjectShadow shadowWithId:aView class:aView.class sel:@selector(setBackgroundColor:) values:@[color]];
    
    [viewShadow doShadowOpreation];
    XCTAssertNotNil(aView.backgroundColor,@"不应该为空");
    XCTAssertEqual(color, aView.backgroundColor, @"颜色应该相等");
}
#pragma -mark 测试是否支持弱持有主对象，即主对象释放，shadow里面的obshadow应该为空
- (void)testWeakRefrence{
    
    NSMutableArray *hostArr = [NSMutableArray new];

    [hostArr addObject:[[UIView alloc]init]];
    
    __weak UIView *weakView = hostArr.firstObject;
    XCTAssertNotNil(weakView, @"aView不应该为nil");
    
    WZObjectShadow *viewShadow = [WZObjectShadow shadowWithId:weakView class:[weakView class] sel:@selector(setBackgroundColor:) values:@[[UIColor whiteColor]]];
    
    [viewShadow doShadowOpreation];
    [hostArr removeLastObject];

    XCTAssertNil(weakView, @"hostArr移除了数据，所以weakView应该为nil");
   
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
