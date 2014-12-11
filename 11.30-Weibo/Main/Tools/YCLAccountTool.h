//
//  YCLAccountTool.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YCLAccount;

@interface YCLAccountTool : NSObject
+ (void)saveAccount:(YCLAccount *)account;
+ (YCLAccount *)readAccount;
@end
