//
//  Class_WZTheme_Test.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WZTheme.h"


@interface Class_WZTheme_Test : XCTestCase

@end

@implementation Class_WZTheme_Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testThemeAvailable{
    
    WZTheme *theme = [[WZTheme alloc] init];
    theme.themeName = @"测试";
    NSString *resourcePath = [NSBundle mainBundle].resourcePath;
    theme.themeResourcePath = resourcePath;
    
    XCTAssertTrue(theme.isAvailable,"测试失败,应该是可用的");
    
    theme.themeBundlePath = @"wrong path";
    XCTAssertFalse(theme.isAvailable,"测试失败,应该是不可用的");
    
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
