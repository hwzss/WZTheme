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


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[WZThemeManger manger] defaultThemeWithBunldeName:@"main" themeName:@"默认主题"];
    
    UITabBarController *tabVc = [[UITabBarController alloc]init];
    
    ViewController *aVc = ({
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ViewController *aVc = [mainSB instantiateViewControllerWithIdentifier:@"viewController"];
        aVc.tabBarItem.title = @"主题界面";
        [aVc.tabBarItem wz_setImageWithName:@"主题云钥匙选中状态@3x" selectImageName:@"主题云钥匙选中状态@3x"];
        aVc;
    });
   
    UIViewController  *aVC1 = ({
        UIViewController  *aVC1 = [[UIViewController alloc]init];
        aVC1.view.backgroundColor = [UIColor whiteColor];
        aVC1.title = @"界面";
        aVC1;
    });
    
    [tabVc addChildViewController:aVc];
    [tabVc addChildViewController:aVC1];
    
    self.window.rootViewController = tabVc;

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
