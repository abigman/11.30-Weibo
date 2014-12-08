//
//  YCLTabBar.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/8.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLTabBar.h"
#import "UIImage+YCLImage.h"
#import "UIView+YCLGeometry.h"

@interface YCLTabBar ()
/** addButton */
@property (weak, nonatomic) UIButton *addButton;
@end

@implementation YCLTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加 + button
        UIButton *addButton = [[UIButton alloc] init];
        [addButton setImage:[UIImage imageWithName:@"tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageWithName:@"tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        self.addButton = addButton;
    }
    return self;
}

- (void)addButtonOnClicked {
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedAddButton:)]) {
        [self.delegate tabBarDidClickedAddButton:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat tabBarButtonX = 0;
    CGFloat tabBarButtonY = 0;
    CGFloat tabBarButtonW = self.bounds.size.width / (self.items.count + 1);
    CGFloat tabBarButtonH = self.bounds.size.height;
    
    self.addButton.frameX = 2 * tabBarButtonW;
    self.addButton.frameY = 0;
    self.addButton.frameW = tabBarButtonW;
    self.addButton.frameH = tabBarButtonH;
    
    int index = 0;
    
    for (UIView *childView in self.subviews) {
        // 不是 UITabBarButton ，跳过
        if (![childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }

        if (index > 1) {
            tabBarButtonX = (index + 1) * tabBarButtonW;
        } else {
            tabBarButtonX = index * tabBarButtonW;
        }
        childView.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        index ++;
    }
}

+ (instancetype)tabBar {
    return [[self alloc] init];
}
@end
