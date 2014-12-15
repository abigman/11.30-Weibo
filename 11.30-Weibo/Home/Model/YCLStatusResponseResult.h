//
//  YCLStatusResponseResult.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

/**
 *    请求结果是一个数组，装着 YCLStatus 对象
 */

#import <Foundation/Foundation.h>

@interface YCLStatusResponseResult : NSObject

/** 模型数组 */
@property (strong, nonatomic) NSArray *statuses;

@end
