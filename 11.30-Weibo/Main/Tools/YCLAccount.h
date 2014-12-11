//
//  YCLAccount.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 返回数据
 {
     "access_token": "ACCESS_TOKEN",
     "expires_in": 1234,
     "remind_in":"798114",
     "uid":"12341234"
 }
 
 返回值字段       字段类型     字段说明
 access_token	string      用于调用access_token，接口获取授权后的access token。
 expires_in     string      access_token的生命周期，单位是秒数。
 remind_in      string      access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid            string      当前授权用户的UID。
 
 */

@interface YCLAccount : NSObject <NSCoding>

/** 用于调用access_token */
@property (copy, nonatomic) NSString *access_token;
/** access_token的生命周期，单位是秒数 */
@property (copy, nonatomic) NSString *expires_in;
/** 当前授权用户的UID */
@property (copy, nonatomic) NSString *uid;

/** access_token的过期时间 */
@property (strong, nonatomic) NSDate *expires_at;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)accountWithDictionary:(NSDictionary *)dict;
+ (instancetype)account;

@end
