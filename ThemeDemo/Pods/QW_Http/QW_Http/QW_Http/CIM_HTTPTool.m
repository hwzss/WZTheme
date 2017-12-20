//
//  CIM_HTTPTool.m
//  CloudIM
//
//  Created by qwkj on 16/3/2.
//  Copyright © 2016年 qwkj. All rights reserved.
//

#import "CIM_HTTPTool.h"
#import "AFNetworking.h"
#import "QW_TokenUnit.h"
#import "QW_ApiResponseParser.h"

#define HTTPTimeout 20.0

static id _instance;

@implementation QW_fileData

+(instancetype )fileData:(NSData *)data Name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType{
    QW_fileData *fileData = [[QW_fileData alloc]init];
    fileData.fileData = data;
    fileData.fileName = fileName;
    fileData.name = name;
    fileData.mimiType = mimeType;
    return  fileData;
}

@end

@implementation CIM_HTTPTool

+(instancetype )Afn_manger{
    if (!_instance) {
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        if (mgr.responseSerializer.acceptableContentTypes) {
            NSMutableSet *acceptableContentTypes = [NSMutableSet setWithSet:mgr.responseSerializer.acceptableContentTypes];
            !acceptableContentTypes?:[acceptableContentTypes addObjectsFromArray:@[@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html"]];
        }else{
            mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
        }
        _instance = mgr;
    }
    return _instance;
}
/**
 *  GET请求
 *
 *  @param URLString 用于创建请求url的urlstring
 *  @param params    请求参数
 *  @param success   请求成功时的回调
 *  @param failure   请求失败时的回调
 */
+(void)Cim_GET:(NSString *)URLString Parameters:(id)params Success:(successBlock)success Failure:(failureBlock)failure{
    AFHTTPSessionManager *magr=[self Afn_manger];
    magr.requestSerializer.timeoutInterval=HTTPTimeout;
    [magr GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


#pragma -mark 新版

+(void)CIM_UploadFileV3:(NSString *)URLString
                   parameters: (void(^)(NSMutableDictionary *params))setParameters
    constructingBodyWithBlock:(void(^)(NSMutableArray<QW_fileData *> *fileModels))block
                      success:(void (^)(id jsonData))success
                      failure:(void (^)(NSString *errorStr))failure
               connectfailure:(void (^)(BOOL *isShowErrorAlert))connectfailure{
    
    NSMutableArray *fileDatas = [NSMutableArray new];
    !block?:block(fileDatas);
    [self CIM_UploadImagesFile:URLString parameters:setParameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [fileDatas enumerateObjectsUsingBlock:^(QW_fileData *fileData, NSUInteger idx, BOOL * _Nonnull stop) {
            [formData appendPartWithFileData:fileData.fileData name:fileData.name fileName:fileData.fileName mimeType:fileData.mimiType];
        }];
        
    } success:success failure:failure connectfailure:connectfailure];
}

/**
 带图片上传的请求

 @param URLString 接口地址
 @param setParameters 参数
 @param images 图片数组
 @param success 成功
 @param failure 失败
 @param connectfailure 链接失败
 */
+(void)CIM_UploadImagesFileV2:(NSString *)URLString
                   parameters: (void(^)(NSMutableDictionary *params))setParameters
                       ImageS:(NSMutableArray *)images
                      success:(void (^)(id jsonData))success
                      failure:(void (^)(NSString *errorStr))failure
               connectfailure:(void (^)(BOOL *isShowErrorAlert))connectfailure{
    [self CIM_UploadImagesFile:URLString parameters:setParameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < images.count; i++) {
            UIImage *aImage=images[i];
            NSData *data=UIImageJPEGRepresentation(aImage, 0.6);
            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"photos"] fileName:[NSString stringWithFormat:@"image%d",i] mimeType:@"image/png"];
        }
        
    } success:success failure:failure connectfailure:connectfailure];
}

/**
 上传图片接口

 @param URLString urlStr
 @param setParameters 设置参数
 @param block 设置data
 @param success 成功
 @param failure 失败
 @param connectfailure 链接失败
 */
+(void)CIM_UploadImagesFile:(NSString *)URLString
         parameters: (void(^)(NSMutableDictionary *params))setParameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                    success:(void (^)(id jsonData))success
                    failure:(void (^)(NSString *errorStr))failure
             connectfailure:(void (^)(BOOL *isShowErrorAlert))connectfailure{
    

   [self CIM_UploadFile:URLString RequestSerializer:nil parameters:setParameters constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
       
       QW_ApiResponseParser *parser = [QW_ApiResponseParser QW_Parser:responseObject];
       if (parser) {
           if (parser.resp_success) {
               !success?:success(parser.resp_jsonData);
           }else{
               !failure?:failure(parser.resp_erroStr);
           }
       }else{
           !failure?:failure(@"本地解析失败");
       }
       
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
       
       BOOL isShowAlert=NO;
       
       if(connectfailure){
           connectfailure(&isShowAlert);
       }
       if (isShowAlert) {
           
       }
       
   }];
    
}
+(void)CIM_UploadFile:(NSString *)URLString
 RequestSerializer:(void(^)(AFHTTPRequestSerializer *aRequestSerializer,AFHTTPSessionManager *magr))requestSerializer
        parameters: (void(^)(NSMutableDictionary *params))setParameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
             progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    AFHTTPSessionManager *mgr=[self Afn_manger];
    if (requestSerializer) {
        requestSerializer(mgr.requestSerializer,mgr);
    }
    //设置请求参数
    NSMutableDictionary *parametersDic=[NSMutableDictionary dictionary];
    //对请求体参数进行额外添加
    if(setParameters){
        setParameters(parametersDic);
    }
    //获取时间戳与token
    QW_TokenUnit *aToken = [QW_TokenUnit tokenNow];
    NSString *timeStamp=aToken.timeStramp;
    NSString *token=aToken.token;
    //添加时间戳以及token到请求体参数中
    parametersDic[@"token"]=token;
    parametersDic[@"timestamp"]=timeStamp;
    
    NSLog(@"AFN_Upload_URL:%@",URLString);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [mgr POST:URLString parameters:parametersDic constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(task,error);
        }
    }];
}
#pragma -mark 发送请求接口2.0
/**
 *  发送post请求，带安全机制,超时时间为默认时间
 *
 *  @param URLString     url
 *  @param setParameters 设置请求参数回调
 *  @param success       成功回调
 *  @param failure       失败回调
 */
+(void)CIM_POST_2:(NSString *)URLString
 parameters: (void(^)(NSMutableDictionary *params))setParameters
    success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    
    [self CIM_POST_21:URLString Timeout:HTTPTimeout parameters:setParameters success:success failure:failure];
    
}
#pragma -mark 发送请求接口2.1,带超时参数
/**
 *  发送post请求，带安全机制，需要自己指定超时时间
 *
 *  @param URLString     url
 *  @param timeout       超时时间
 *  @param setParameters 设置请求参数回调
 *  @param success       成功回调
 *  @param failure       失败回调
 */
+(void)CIM_POST_21:(NSString *)URLString
           Timeout:(NSTimeInterval )timeout
       parameters: (void (^)(NSMutableDictionary *params))setParameters
          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    [self CIM_POST_22:URLString RequestSerializer:^(AFHTTPRequestSerializer *aRequestSerializer,AFHTTPSessionManager *magr) {
        aRequestSerializer.timeoutInterval=timeout;
    } parameters:setParameters success:success failure:failure];
}
/**
 *  发送post请求，带安全机制，可自定义请求体参数如超时时间等
 *
 *  @param URLString         url
 *  @param requestSerializer 请求体管理对象
 *  @param setParameters     设置请求参数回调
 *  @param success            成功回调
 *  @param failure           失败回调
 */
+(void)CIM_POST_22:(NSString *)URLString
RequestSerializer:(void(^)(AFHTTPRequestSerializer *aRequestSerializer,AFHTTPSessionManager *magr))requestSerializer
        parameters: (void(^)(NSMutableDictionary *params))setParameters
           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    
    
    AFHTTPSessionManager *magr=[self Afn_manger];
    
    //设置请求的 特殊设置
    if(requestSerializer){
        requestSerializer(magr.requestSerializer,magr);
    }
  
    //设置请求参数
    NSMutableDictionary *parametersDic=[NSMutableDictionary dictionary];
    //对请求体参数进行额外添加
    if(setParameters){
        setParameters(parametersDic);
    }
    //获取时间戳与token
    QW_TokenUnit *aToken = [QW_TokenUnit tokenNow];
    NSString *timeStamp=aToken.timeStramp;
    NSString *token=aToken.token;
    //添加时间戳以及token到请求体参数中
    parametersDic[@"token"]=token;
    parametersDic[@"timestamp"]=timeStamp;
    
    NSLog(@"AFN_URL:%@",URLString);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [magr POST:URLString parameters:parametersDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(task,error);
        }
    }];
    
}

#pragma -mark 发送请求3.0
/**
 *  调用接口
 *
 *  @param URLString      接口地址
 *  @param setParameters  设置接口参数，如params[@"token"]=token;
 *  @param success        接口请求成功回调，对于数据部分的json
 *  @param failure        接口请求成功，但返回失败时回调
 *  @param connectfailure 接口调用失败，连接错误时回调，isShowErrorAlert是
 */
+(void)CIM_POST_3:(NSString *)URLString
       parameters: (void(^)(NSMutableDictionary *params))setParameters
          success:(void (^)(id jsonData))success
          failure:(void (^)(NSString *errorStr))failure
   connectfailure:(void (^)(BOOL *isShowErrorAlert))connectfailure
{
    [self CIM_POST_31:URLString Timeout:HTTPTimeout parameters:setParameters success:success failure:failure connectfailure:connectfailure];
}
/**
 *  调用接口,需要自己指定超时时间
 *
 *  @param URLString      接口地址
 *  @param timeout       超时时间
 *  @param setParameters  设置接口参数，如params[@"token"]=token;
 *  @param success        接口请求成功回调，对于数据部分的json
 *  @param failure        接口请求成功，但返回失败时回调
 *  @param connectfailure 接口调用失败，连接错误时回调，isShowErrorAlert是
 */
+(void)CIM_POST_31:(NSString *)URLString
           Timeout:(NSTimeInterval)timeout
       parameters: (void(^)(NSMutableDictionary *params))setParameters
          success:(void (^)(id jsonData))success
          failure:(void (^)(NSString *errorStr))failure
   connectfailure:(void (^)(BOOL *isShowErrorAlert))connectfailure
{
    [self CIM_POST_32:URLString RequestSerializer:^(AFHTTPRequestSerializer *aRequestSerializer,AFHTTPSessionManager *magr) {
        aRequestSerializer.timeoutInterval=timeout;
    } parameters:setParameters success:success failure:failure connectfailure:connectfailure];
    

}
/**
 *  发送post请求，带安全机制，可自定义请求体参数如超时时间等
 *
 *  @param URLString         url
 *  @param requestSerializer 请求体管理对象
 *  @param setParameters     设置请求参数回调
 *  @param success           成功回调
 *  @param failure           失败回调
 *  @param connectfailure    链接失败回调
 */
+(void)CIM_POST_32:(NSString *)URLString
          RequestSerializer:(void(^)(AFHTTPRequestSerializer *aRequestSerializer,AFHTTPSessionManager *magr))requestSerializer
        parameters: (void(^)(NSMutableDictionary *params))setParameters
           success:(void (^)(id jsonData))success
           failure:(void (^)(NSString *errorStr))failure
    connectfailure:(void (^)(BOOL *isShowErrorAlert))connectfailure
{
    
    [self CIM_POST_22:URLString RequestSerializer:requestSerializer parameters:setParameters success:^(NSURLSessionDataTask *task, id responseObject) {

        
        QW_ApiResponseParser *parser = [QW_ApiResponseParser QW_Parser:responseObject];
        if (parser) {
            if (parser.resp_success) {
                !success?:success(parser.resp_jsonData);
            }else{
                !failure?:failure(parser.resp_erroStr);
            }
        }else{
            !failure?:failure(@"本地解析失败");
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        BOOL isShowAlert=NO;
        
        if(connectfailure){
            connectfailure(&isShowAlert);
        }
        if (isShowAlert) {
            //弹框显示网络错误
            
        }

    }];
  }


@end



