//
//  YCLAccountTool.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLAccountTool.h"
#import "YCLAccount.h"

#define kFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"]

@implementation YCLAccountTool
+ (void)saveAccount:(YCLAccount *)account {
    // 使用改方法的前提是， 对象的类必须遵守 NSCoding 协议
    [NSKeyedArchiver archiveRootObject:account toFile:kFilePath];
}

+ (YCLAccount *)readAccount {
    YCLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    
    // 授权信息有过期日期， 需要判断是否过期
    
    if (NSOrderedAscending == [[NSDate date] compare:account.expires_at]) {
        NSLog(@"很好，账户授权还没有过期哦 过期日期：%@", account.expires_at);
        return account;
    } else {
        NSLog(@"账户授权已经过期 过期日期：%@", account.expires_at);
        return nil;
    }

}
@end
