//
//  YCLUserRequestTool.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLUserRequestTool.h"
#import "YCLUserRequestParameter.h"
#import "YCLUserResponseResult.h"
#import "YCLHttpTool.h"
#import "MJExtension.h"

#define kUser_show @"https://api.weibo.com/2/users/show.json"

@implementation YCLUserRequestTool
+ (void)userWithParameters:(YCLUserRequestParameter *)param success:(void (^)(YCLUserResponseResult *))success failure:(void (^)(NSError *))failure {
    [YCLHttpTool GET:kUser_show parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            YCLUserResponseResult *result = [YCLUserResponseResult objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
