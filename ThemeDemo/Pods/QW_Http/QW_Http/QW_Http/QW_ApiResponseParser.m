//
//  QW_ApiResponsParser.m
//  QW_Http
//
//  Created by qwkj on 2017/11/10.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "QW_ApiResponseParser.h"

@implementation QW_ApiResponseParser

+(instancetype)QW_Parser:(id)responseObj{
    if (![responseObj isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    QW_ApiResponseParser *parser = [[QW_ApiResponseParser alloc]init];
    
    if ([[responseObj objectForKey:@"status"]isEqualToString:@"SUCCESS"]) {
        //请求成功
        parser.resp_success = YES;
        parser.resp_jsonData = [responseObj objectForKey:@"data"];
    }else{
        //请求到了，但是返回错误
        if([[responseObj objectForKey:@"status"] isEqualToString:@"err"]){
            parser.resp_success = NO;
            parser.resp_erroStr = [responseObj objectForKey:@"errInfo"];
        }else{
            NSLog(@"返回结果格式,本地解析失败");
        }
    }
    
    return parser;
}
@end
