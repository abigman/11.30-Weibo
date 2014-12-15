//
//  YCLStatusParameter.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//


// 请求时，面向的是 参数对象

#import <Foundation/Foundation.h>
/**
 *      access_token    false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *      since_id        false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *      max_id          false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *      count           false	int     单页返回的记录条数，最大不超过100，默认为20。
 */
@interface YCLStatusRequestParameter : NSObject

/** 授权信息 */
@property (copy, nonatomic) NSString *access_token;
/** since_id */
@property (strong, nonatomic) NSNumber *since_id;
/** max_id */
@property (strong, nonatomic) NSNumber *max_id;
/** count */
@property (strong, nonatomic) NSNumber *count;

@end
