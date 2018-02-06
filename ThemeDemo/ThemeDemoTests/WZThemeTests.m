//
//  WZThemeTests.m
//  ThemeDemo
//
//  Created by qwkj on 2018/2/5.
//  Copyright © 2018年 qwkj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WZTheme.h"

@interface WZThemeTests : XCTestCase

@end

@implementation WZThemeTests

- (void)testThemeAvailable
{

    WZTheme *theme = [[WZTheme alloc] init];
    theme.themeName = @"测试";
    NSString *resourcePath = [NSBundle mainBundle].resourcePath;
    theme.themeResourcePath = resourcePath;

    XCTAssertTrue(theme.isAvailable, "测试失败,应该是可用的");

    theme.themeBundlePath = @"wrong path";
    XCTAssertFalse(theme.isAvailable, "测试失败,应该是不可用的");
}

@end
