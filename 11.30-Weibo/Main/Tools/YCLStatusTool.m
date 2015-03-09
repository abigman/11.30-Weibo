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
#import "YCLStatus.h"

#import "FMDB.h"

// 微博数据请求连接
#define kHome_timeline @"https://api.weibo.com/2/statuses/home_timeline.json"

@implementation YCLStatusTool

static FMDatabase *_db = nil;

+ (void)initialize {
  // 1. 创建微博缓存数据库
  NSString *docPath = [NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString *dbFilePath =
      [docPath stringByAppendingPathComponent:@"status.sqlite"];
  _db = [[FMDatabase alloc] initWithPath:dbFilePath];

  // 2. 打开数据库
  if ([_db open]) {
    NSLog(@"成功打开数据库");
    // 3. 创建表
    BOOL tableState =
        [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_statuses (id "
                           @"integer PRIMARY KEY AUTOINCREMENT, access_token "
                           @"text NOT NULL, status_idstr text NOT NULL, "
                           @"status blob NOT NULL);"];
    if (tableState) {
      NSLog(@"成功创建表格");
    } else {
      NSLog(@"创建表格失败");
    }
  } else {
    NSLog(@"打开数据库失败");
  }
}

// 根据请求参数，丛数据库中查询数据，保存到数组中，返回
+ (NSArray *)cachedStatusesWithParameters:(YCLStatusRequestParameter *)param {
  NSMutableArray *statusesM = [NSMutableArray array];

  FMResultSet *statusesSet = nil;

  if (param.since_id) {
    // 指定了since_id
    statusesSet =
        [_db executeQuery:@"SELECT * FROM t_home_statuses WHERE access_token = "
                          @"? and status_idstr > ? ORDER BY status_idstr DESC "
                          @"LIMIT ?;",
                          param.access_token, param.since_id, param.count];

  } else if (param.max_id) {
    // 指定了since_id
    statusesSet =
        [_db executeQuery:@"SELECT * FROM t_home_statuses WHERE access_token = "
                          @"? and status_idstr <= ? ORDER BY status_idstr "
                          @"DESC LIMIT ?;",
                          param.access_token, param.max_id, param.count];

  } else {
    // 未指定

    statusesSet =
        [_db executeQuery:@"SELECT * FROM t_home_statuses WHERE access_token = "
                          @"? ORDER BY status_idstr DESC LIMIT ?;",
                          param.access_token, param.count];
  }

  while (statusesSet.next) {
    // 数据库保存的时候，微博字典已经归档为NSData数据，查询后需要解档
    NSData *statusDictData = [statusesSet objectForColumnName:@"status"];
    NSDictionary *statusDict =
        [NSKeyedUnarchiver unarchiveObjectWithData:statusDictData];

    //    NSLog(@"%@", status.user);
    [statusesM addObject:statusDict];
  }

  NSLog(@"");

  NSArray *statuses = [YCLStatus objectArrayWithKeyValuesArray:statusesM];

  return statuses;
}

// 保存网络请求的微博到数据库
/** 
  把请求结果中的微博字典数组转归档成NSData数据来存储
 */
+ (void)saveResponseResult:(id)result
                 parameter:(YCLStatusRequestParameter *)param {
  NSArray *statuses = result[@"statuses"];
  for (NSDictionary *statusDict in statuses) {
    // 插入数据到数据库 (把字典转换成 NSData 数据，再插入)
    NSData *statusDictData =
        [NSKeyedArchiver archivedDataWithRootObject:statusDict];
    [_db executeUpdate:@"INSERT INTO t_home_statuses (access_token, "
                       @"status_idstr, status) VALUES (?, ?, ?);",
                       param.access_token, statusDict[@"idstr"],
                       statusDictData];
  }
}

// 根据指定参数请求微博数据
+ (void)statusWithParameters:(YCLStatusRequestParameter *)param
                     success:(void (^)(YCLStatusResponseResult *))success
                     failure:(void (^)(NSError *))failure {
  /**
     先从缓存中获取数据
      -> 有 -> 缓存中请求
      -> 没有 -> 网络请求 -> 保存到数据库
   */

  if ([self cachedStatusesWithParameters:param].count > 0) {
    // 缓存中有数据
    if (success) {
      YCLStatusResponseResult *cachedResult =
          [[YCLStatusResponseResult alloc] init];

      cachedResult.statuses = [self cachedStatusesWithParameters:param];
      //      cachedResult.statuses = [YCLStatus
      //      objectArrayWithKeyValuesArray:cachedResult.statuses];

      success(cachedResult);
    }
  } else {
    // 缓存中没有数据，网络请求

    // 发送网络请求
    [YCLHttpTool GET:kHome_timeline
        parameters:param.keyValues
        success:^(id responseObject) {
          if (success) {
            // 字典转模型
            YCLStatusResponseResult *result =
                [YCLStatusResponseResult objectWithKeyValues:responseObject];
            // 模型传出
            success(result);

            // 保存到数据库
            [self saveResponseResult:responseObject parameter:param];
          }
        }
        failure:^(NSError *error) {
          if (failure) {
            failure(error);
          }
        }];
  }
}
@end
