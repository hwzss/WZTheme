//
//  AppDelegate.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "AppDelegate.h"
#import "WZThemeManger.h"
#import "ViewController.h"
#import "UITabBarItem+WZTheme.h"
#import "TableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[WZThemeManger manger] defaultThemeWithBunldeName:@"main" themeName:@"默认主题"];

    ViewController *themeVc = ({
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ViewController *aVc = [mainSB instantiateViewControllerWithIdentifier:@"viewController"];
        aVc.tabBarItem.title = @"主题界面";

        [aVc.tabBarItem wz_setNormalImageWithName:@"电费@3x" renderingMode:UIImageRenderingModeAlwaysOriginal];
        [aVc.tabBarItem wz_setSelectedImageWithName:@"主题云钥匙选中状态@3x" renderingMode:UIImageRenderingModeAlwaysOriginal];
        aVc;
    });

    TableViewController *tableVc = ({
        TableViewController *aVc = [[TableViewController alloc] init];
        aVc.view.backgroundColor = [UIColor whiteColor];
        aVc.title = @"列表";
        [aVc.tabBarItem wz_setNormalImageWithName:@"电费@3x" renderingMode:UIImageRenderingModeAlwaysOriginal];
        [aVc.tabBarItem wz_setSelectedImageWithName:@"主题云钥匙选中状态@3x" renderingMode:UIImageRenderingModeAlwaysOriginal];
        aVc;
    });
    
    UITabBarController *tabVc = [[UITabBarController alloc] init];
    [tabVc addChildViewController:[[UINavigationController alloc] initWithRootViewController:themeVc]];
    [tabVc addChildViewController:[[UINavigationController alloc] initWithRootViewController:tableVc]];

    self.window.rootViewController = tabVc;
    return YES;
}

@end
