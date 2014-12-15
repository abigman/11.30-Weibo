//
//  YCLUserRequestTool.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCLUserRequestParameter, YCLUserResponseResult;

@interface YCLUserRequestTool : NSObject
/**
 *    请求用户信息
 *
 *    @param param   参数模型
 *    @param success 请求成功时回调
 *    @param failure 请求失败时回调
 */
+ (void)userWithParameters:(YCLUserRequestParameter *)param success:(void(^)(YCLUserResponseResult *responseResult))success failure:(void(^)(NSError *error))failure;
@end
