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
#import "YCLProfileController.h"
#import "YCLMainNavigationController.h"
#import "UIImage+YCLImage.h"
#import "YCLTabBar.h"
#import "YCLComposeController.h"

@interface YCLMainTabBarController ()<YCLTabBarDelegate>

@end

@implementation YCLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所需控制器
    [self addChildViewControllers];
    
    YCLTabBar *myTabBar = [YCLTabBar tabBar];
    myTabBar.delegate = self;
    [self setValue:myTabBar forKey:@"tabBar"];
   
}

#pragma mark - YCLTabBarDelegate

- (void)tabBarDidClickedAddButton:(YCLTabBar *)tabBar {
    YCLComposeController *composeVC = [[YCLComposeController alloc] init];
    composeVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    composeVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    composeVC.view.backgroundColor = [UIColor whiteColor];
    YCLMainNavigationController *nv = [[YCLMainNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:nv animated:YES completion:^{
        
    }];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)send {
    NSLog(@"发送微博");
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
    YCLProfileController *profileFileVC = [[YCLProfileController alloc] init];
    [self addChildController:profileFileVC title:@"我" normalImage:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}

/** 
 *  添加一个子控制器
 */
- (void)addChildController:(UIViewController *)childVC title:(NSString *)title normalImage:(NSString *)normal selectedImage:(NSString *)selected {
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageWithName:normal];
    childVC.tabBarItem.selectedImage = [UIImage imageWithName:selected];
    childVC.title = title;
    
    // 设置正常状态 tabBarItem 文字样式
    NSMutableDictionary *normalTitleTextAttributes = [NSMutableDictionary dictionary];
    normalTitleTextAttributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    normalTitleTextAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [childVC.tabBarItem setTitleTextAttributes:normalTitleTextAttributes forState:UIControlStateNormal];
    
    // 设置选中状态 tabBarItem 文字样式
    NSMutableDictionary *selectedTitleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:normalTitleTextAttributes];
    selectedTitleTextAttributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:selectedTitleTextAttributes forState:UIControlStateSelected];
    
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
