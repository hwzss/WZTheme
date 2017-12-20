//
//  QW_TokenUnit.m
//  QW_Http
//
//  Created by qwkj on 2017/11/9.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "QW_TokenUnit.h"
#import "NSDate+Net.h"

//网络请求token中的盐
#define Token @"qwkj5@6!7#8%9"

@interface NSString (QW_Md5)

- (NSString *)QW_md5String;
@end

@implementation QW_TokenUnit

+(instancetype)tokenNow{
    QW_TokenUnit *token = [[QW_TokenUnit alloc] init];
    token.timeStramp = [self getTimeStramp];
    token.token = [self getTokenWithTime:token.timeStramp];
    return token;
}

/**
 *  获取时间戳
 *
 *  @return 时间戳
 */
+(NSString *)getTimeStramp{
    NSDate *nowDate=[NSDate QW_NetDate];
    NSString *timeStamp=[NSString stringWithFormat:@"%.f",([nowDate timeIntervalSince1970]*1000)];
    
    return timeStamp;
}

/**
 *  获取touken
 *
 *  @param timeStramp 时间戳
 *
 *  @return 获取touken
 */
+(NSString *)getTokenWithTime:(NSString *)timeStramp{
    NSString *tokenStr=[NSString stringWithFormat:@"%@%@",Token,timeStramp];
    return [tokenStr QW_md5String];
}


@end


#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (QW_Md5)

- (NSString *)QW_md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}


@end


