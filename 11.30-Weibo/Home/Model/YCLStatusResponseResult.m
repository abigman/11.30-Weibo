//
//  YCLStatusResponseResult.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusResponseResult.h"
#import "MJExtension.h"
#import "YCLStatus.h"

@implementation YCLStatusResponseResult
- (NSDictionary *)objectClassInArray {
    return @{@"statuses" : [YCLStatus class]};
}
@end
