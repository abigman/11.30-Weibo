//
//  YCLControllerTools.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLControllerTools.h"
#import "YCLMainTabBarController.h"
#import "YCLNewfeatureController.h"

@implementation YCLControllerTools
+ (void)choseController {
    /* 判断是否展示新特性 */
    
    // 从沙盒取出上一次保存的版本号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [userDefaults objectForKey:@"lastVersion"];
    // 获取当前版本号
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    // 当前主窗口 (前提是已经设置了 keyWindws)
    UIWindow *theKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    if ([currentVersion isEqualToString:lastVersion]) {
        // 版本号相同， 进入微博
        theKeyWindow.rootViewController = [[YCLMainTabBarController alloc] init];
        
    } else {
        // 版本号不同，展示新特性
        theKeyWindow.rootViewController = [[YCLNewfeatureController alloc] init];
        // 存储版本号
        [userDefaults setValue:currentVersion forKey:@"lastVersion"];
        [userDefaults synchronize];
    }
}
@end
