//
//  AppDelegate.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/11/30.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "AppDelegate.h"
#import "YCLOAuthController.h"
#import "YCLControllerTools.h"
#import "YCLAccountTool.h"
#import "YCLAccount.h"
//#import "AFNetworking.h"
#import "YCLHttpTool.h"
#import "MBProgressHUD.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 控制器选择的工具，需要获取主窗口，所以需要先设置主窗口
    [self.window makeKeyAndVisible];
    
    /* 判断是否已经授权 */
    
    // 获取授权信息
    YCLAccount *account = [YCLAccountTool readAccount];
    
    if (account) {
        // 有授权信息
        
        /* 判断是否展示新特性 */
        [YCLControllerTools choseController];
        
    } else {
        // 没有授权
        
        // 进入授权页
        self.window.rootViewController = [[YCLOAuthController alloc] init];
    }
    
    // 监控网络
    [YCLHttpTool setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.dimBackground = YES;
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络异常");
                hud.labelText = @"网络异常";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"无线网络");
                hud.labelText = @"无线网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机网络");
                hud.labelText = @"手机网络";
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                hud.labelText = @"未知网络";
                break;
        }
        [hud hide:YES afterDelay:0.8];
    }];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
