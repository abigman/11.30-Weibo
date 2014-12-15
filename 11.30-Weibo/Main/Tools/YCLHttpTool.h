//
//  YCLHttpTool.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface YCLHttpTool : NSObject
/**
 *    发送GET请求
 *
 *    @param URLString  请求路径
 *    @param parameters 请求参数
 *    @param success    请求成功回调
 *    @param failure    请求失败回调
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *    发送POST请求
 *
 *    @param URLString  请求路径
 *    @param parameters 请求参数
 *    @param success    请求成功回调
 *    @param failure    请求失败回调
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *    发送POST请求
 *
 *    @param URLString  请求路径
 *    @param parameters 请求参数
 *    @param block      数据拼接
 *    @param success    请求成功回调
 *    @param failure    请求失败回调
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *    监控网络访问状态
 *
 *    @param block 回调代码块
 */
+ (void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block;
@end
