//
//  YCLTabBar.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/8.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCLTabBar;

@protocol YCLTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedAddButton:(YCLTabBar *)tabBar;

@end

@interface YCLTabBar : UITabBar
/** 代理 */
@property (weak, nonatomic) id<YCLTabBarDelegate, UITabBarDelegate> delegate;

+ (instancetype)tabBar;
@end
