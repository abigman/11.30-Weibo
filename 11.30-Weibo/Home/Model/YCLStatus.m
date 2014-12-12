//
//  YCLStatus.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatus.h"
#import "YCLUser.h"
#import "MJExtension.h"
#import "YCLPicture.h"

@implementation YCLStatus
//+ (instancetype)statusWithDictionary:(NSDictionary *)dict {
//    YCLStatus *status = [[self alloc] init];
//    status.text = dict[@"text"];
//    
//    // 遇到字典需要处理
//    status.user = [YCLUser userWithDictionary:dict[@"user"]];
//    
//    NSDictionary *retweetedStatusDict = dict[@"retweeted_status"];
//    if (retweetedStatusDict) {
//        status.retweeted_status = [self statusWithDictionary:retweetedStatusDict];
//    }
//    
//    
//    return status;
//}

/**
 *    通知框架 pic_ids 属性保存的是 YCLPicture 类型的对象
 */
- (NSDictionary *)objectClassInArray {
    return @{@"pic_ids" : [YCLPicture class]};
}
@end