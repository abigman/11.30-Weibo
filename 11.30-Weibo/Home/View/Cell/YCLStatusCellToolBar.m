//
//  YCLStatusCellToolBar.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusCellToolBar.h"
#import "YCLStatusFrame.h"



@implementation YCLStatusCellToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        // 添加 转发、评论、赞 三个按钮
    }
    return self;
}

- (UIButton *)addButtoWithTitle:(NSString *)title image:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self addSubview:button];
    return button;
}

@end