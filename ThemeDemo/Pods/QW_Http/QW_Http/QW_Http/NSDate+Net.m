//
//  NSDate+Net.m
//  QW_Http
//
//  Created by qwkj on 2017/11/9.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "NSDate+Net.h"

@implementation NSDate (Net)

+ (NSDate *)QW_NetDate
{
    //  NSString *urlString = @"http://www.taobao.com";
    NSString *urlString = @"http://www.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    // 实例化NSMutableURLRequest，并进行参数配置

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

    [request setURL:[NSURL URLWithString:urlString]];

    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];

    [request setTimeoutInterval:0.001];

    [request setHTTPShouldHandleCookies:FALSE];

    [request setHTTPMethod:@"GET"];

    NSError *error = nil;

    NSHTTPURLResponse *response;

    [NSURLConnection sendSynchronousRequest:request

                          returningResponse:&response
                                      error:&error];
    // 处理返回的数据
    //    NSString *strReturn = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    if (error)
    {
        return [NSDate date];
    }

    NSLog(@"response is %@", response);

    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];

    date = [date substringFromIndex:5];

    date = [date substringToIndex:[date length] - 4];

    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];

    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];

    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60 * 60 * 8];

    return netDate;
    
}

@end
