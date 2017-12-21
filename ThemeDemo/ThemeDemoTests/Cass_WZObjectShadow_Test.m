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

@property (assign,nonatomic,getter=didAccpetedNil) BOOL accpetNil;
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
//ob3:(id )ob3 ob4:(id )ob4
- (void)doneIfNil:(id)ob ob2:(id)ob2 ob3:(id )ob3 ob4:(id )ob4{

    self.accpetNil = (!ob&&!ob3)?YES:NO;
}
#pragma -mark 测试创建shadow时args传nil是否有效
- (void)testArgsNil{
    WZObjectShadow *aShadow = [WZObjectShadow shadowWithId:self class:self.class sel:@selector(doneIfNil:ob2:ob3:ob4:) args:nil,@"哈哈",nil,@"哈哈2",wz_args_end];
    self.accpetNil = NO;
    [aShadow doShadowOpreation];
    XCTAssertTrue(self.accpetNil,@"不为空说明没有接收nil");
}
- (void)testDoShadowOpreation{
    UIView *aView = [[UIView alloc]init];
    
    UIColor *color = [UIColor redColor];
    
    WZObjectShadow *viewShadow = [WZObjectShadow shadowWithId:aView class:aView.class sel:@selector(setBackgroundColor:) args:color,wz_args_end];
    
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
    
    WZObjectShadow *viewShadow = [WZObjectShadow shadowWithId:weakView class:[weakView class] sel:@selector(setBackgroundColor:) args:[UIColor whiteColor],wz_args_end];
    
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
