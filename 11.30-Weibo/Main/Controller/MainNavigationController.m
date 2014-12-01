//
//  MainNavigationController.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/11/30.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "MainNavigationController.h"
#import "UIBarButtonItem+ItemByImage.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

// 该方法只在第一次使用该类的时候才调用
+ (void)initialize {
    
    // 设置主题，只需要调用一次就行了，如果放在 -viewDidLoad 方法总，会多次调用
    [self customizeUIBarButtonItemAppearance];
    
    [self customizeUINavigationBarAppearance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义push操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 第一次调用的时候，子控制器个数为0，调用父类控制器，添加rootViewController
    // 如果再次调用，自控制器个数大于0，会对push的控制器进行自定义
    if (self.viewControllers.count > 0) {
        // 调转后，自动隐藏底部bar
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 自动添加左右按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" hightedImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" hightedImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    NSLog(@"开始调用父类push");
    NSLog(@"%@", self.viewControllers);
    [super pushViewController:viewController animated:YES];
    NSLog(@"结束调用父类push");
    NSLog(@"%@\n\n", self.viewControllers);
}

- (void)back {
    [self popToRootViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
}

#pragma mark - 自定义 UIBarButtonItem 外观
+ (void)customizeUIBarButtonItemAppearance {
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    // normal 状态
    NSMutableDictionary *normalAttributes = [NSMutableDictionary dictionary];
    normalAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    normalAttributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [appearance setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    
    // highlighted 状态
    NSMutableDictionary *highlightedAttributes = [NSMutableDictionary dictionaryWithDictionary:normalAttributes];
    highlightedAttributes[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    // disable 状态
    NSMutableDictionary *disabledAttributes = [NSMutableDictionary dictionaryWithDictionary:normalAttributes];
    disabledAttributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disabledAttributes forState:UIControlStateDisabled];
}

#pragma mark - 自定义 UIBarButtonItem 外观
+ (void)customizeUINavigationBarAppearance {
    UINavigationBar *appearance = [UINavigationBar appearance];
//    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background_os7"] forBarMetrics:UIBarMetricsDefault];

    NSMutableDictionary *normalAttributes = [NSMutableDictionary dictionary];
    normalAttributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
    normalAttributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [appearance setTitleTextAttributes:normalAttributes];
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
