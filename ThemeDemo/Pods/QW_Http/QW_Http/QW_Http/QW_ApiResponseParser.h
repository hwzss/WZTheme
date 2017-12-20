//
//  QW_ApiResponsParser.h
//  QW_Http
//
//  Created by qwkj on 2017/11/10.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 负责解析接口返回数据
 */
@interface QW_ApiResponseParser : NSObject

/**
  true：api接口返回调用成功。false：接口返回失败状态
 */
@property(assign,nonatomic) BOOL resp_success;

/**
 接口调用成功时，返回的数据。
 */
@property(copy,nonatomic)NSString *resp_jsonData;

/**
 接口返回失败时，返回的错误信息描述
 */
@property(copy,nonatomic)NSString *resp_erroStr;

+(instancetype )QW_Parser:(id )responseObj;
@end
