//
//  YCLAccountTool.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLAccountTool.h"

@implementation YCLAccountTool
+ (void)saveAccount:(YCLAccount *)account {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"account.plist"];
    
    // 使用改方法的前提是， 对象的类必须遵守 NSCoding 协议
    [NSKeyedArchiver archiveRootObject:account toFile:filePath];
}

+ (YCLAccount *)readAccount {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"account.plist"];
    YCLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return account;
}
@end
