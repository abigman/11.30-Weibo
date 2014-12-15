//
//  YCLStatusTool.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusTool.h"
#import "YCLHttpTool.h"
#import "MJExtension.h"
#import "YCLStatusRequestParameter.h"
#import "YCLStatusResponseResult.h"

// 微博数据请求连接
#define kHome_timeline @"https://api.weibo.com/2/statuses/home_timeline.json"

@implementation YCLStatusTool
+ (void)statusWithParameters:(YCLStatusRequestParameter *)param success:(void (^)(YCLStatusResponseResult *))success failure:(void (^)(NSError *))failure {
    [YCLHttpTool GET:kHome_timeline parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            // 字典转模型
            YCLStatusResponseResult *result = [YCLStatusResponseResult objectWithKeyValues:responseObject];
            // 模型传出
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end


