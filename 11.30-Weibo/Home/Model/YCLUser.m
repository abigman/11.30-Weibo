//
//  YCLUser.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLUser.h"

@implementation YCLUser
+ (instancetype)userWithDictionary:(NSDictionary *)dict {
    YCLUser *user = [[YCLUser alloc] init];
//    [user setValuesForKeysWithDictionary:dict];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}
@end
