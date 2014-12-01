//
//  MainTabBarController.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/11/30.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLMainTabBarController.h"
#import "YCLHomeController.h"
#import "YCLMessageCenterController.h"
#import "YCLDiscoverController.h"
#import "ProfileController.h"
#import "YCLMainNavigationController.h"

@interface YCLMainTabBarController ()

@end

@implementation YCLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所需控制器
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  一次性添加所需子控制器
 */
- (void)addChildViewControllers {
    YCLHomeController *homeVC = [[YCLHomeController alloc] init];
    [self addChildController:homeVC title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    YCLMessageCenterController *messageCenterVC = [[YCLMessageCenterController alloc] init];
    [self addChildController:messageCenterVC title:@"消息" normalImage:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    YCLDiscoverController *discoverVC = [[YCLDiscoverController alloc] init];
    [self addChildController:discoverVC title:@"发现" normalImage:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    ProfileController *profileFileVC = [[ProfileController alloc] init];
    [self addChildController:profileFileVC title:@"我" normalImage:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}

/** 
 *  添加一个子控制器
 */
- (void)addChildController:(UIViewController *)childVC title:(NSString *)title normalImage:(NSString *)normal selectedImage:(NSString *)selected {
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:normal];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selected];
    childVC.title = title;
    
    YCLMainNavigationController *mainNC = [[YCLMainNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:mainNC];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
