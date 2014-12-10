//
//  YCLNewfeatureController.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/8.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLNewfeatureController.h"
#import "UIView+YCLGeometry.h"
#import "YCLMainTabBarController.h"

@interface YCLNewfeatureController ()

@end

@implementation YCLNewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    CGFloat imageWidth = self.view.frameW;
    CGFloat imageHeight = self.view.frameH;
    
    scrollView.contentSize = CGSizeMake(imageWidth * 4, imageHeight);
    scrollView.pagingEnabled = YES;
    
    for (int i = 0; i<4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        imageView.frameX = i * imageWidth;
        imageView.frameY = 0;
        imageView.frameW = imageWidth;
        imageView.frameH = imageHeight;
        [scrollView addSubview:imageView];
        
        if (i == 4 - 1) {
            // 添加进入微博按钮
            
            imageView.userInteractionEnabled = YES;
            
            UIButton *button = [[UIButton alloc] init];
            button.backgroundColor = [UIColor redColor];
            [button setTitle:@"开始体验" forState:UIControlStateNormal];
            button.frameS = CGSizeMake(100, 20);
            button.centerX = self.view.centerX;
            button.centerY = self.view.frameH * 0.7;
            [button addTarget:self action:@selector(gotoWeibo) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            
            
        }
    }
}

- (void)gotoWeibo {
    NSLog(@"----- 进入主页-----");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[YCLMainTabBarController alloc] init];
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
