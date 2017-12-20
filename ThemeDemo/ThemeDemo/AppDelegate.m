//
//  AppDelegate.m
//  ThemeDemo
//
//  Created by qwkj on 2017/12/20.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "AppDelegate.h"
#import "WZThemeManger.h"
#import <CIM_HTTPTool.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[WZThemeManger manger] defaultThemeWithBunldeName:@"main" themeName:@"默认主题"];
    
//    [[WZThemeManger manger] downloadThemeFrom:@"http://182.105.146.245:8890/EstateService/uploadFile/image/APPtheme/year4.zip" themeName:@"新的主题"];
    [CIM_HTTPTool CIM_POST_3:@"http://182.105.146.245:8890/EstateService/httpInterface/apptheme/getAppTheme" parameters:^(NSMutableDictionary *params) {
        params[@"appType"]=@"IOS";
    } success:^(id jsonData) {
        NSDictionary *dict = (NSDictionary *)jsonData;
        NSString *url = [dict objectForKey:@"url"];
        NSString *themeName = [dict objectForKey:@"themeName"];
        [[WZThemeManger manger] downloadThemeFrom:url themeName:themeName];
    } failure:^(NSString *errorStr) {
 
        
    } connectfailure:^(BOOL *isShowErrorAlert) {
    
    }];
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
