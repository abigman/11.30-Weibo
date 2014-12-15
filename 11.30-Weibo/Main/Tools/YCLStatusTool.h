//
//  YCLStatusTool.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCLStatusRequestParameter, YCLStatusResponseResult;

@interface YCLStatusTool : NSObject
/**
 *    请求微博数据
 *
 *    @param param   参数模型
 *    @param success 请求成功时回调
 *    @param failure 请求失败时回调
 */
+ (void)statusWithParameters:(YCLStatusRequestParameter *)param success:(void(^)(YCLStatusResponseResult *responseResult))success failure:(void(^)(NSError *error))failure;
@end
