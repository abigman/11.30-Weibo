//
//  YCLUserRequestParameter.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *    ccess_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *    uid	false	int64	需要查询的用户ID。
 *    screen_name	false	string	需要查询的用户昵称。
 */
@interface YCLUserRequestParameter : NSObject
/** access_token */
@property (copy, nonatomic) NSString *access_token;
/** id */
@property (strong, nonatomic) NSNumber *uid;
/** screen_name */
@property (copy, nonatomic) NSString *screen_name;
@end
