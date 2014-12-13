//
//  YCLToolBar.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/13.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLToolBar.h"


@implementation YCLToolBar



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        // 添加四个按钮
        [self addButtonWithImage:@"compose_toolbar_picture"
                highlightedImage:@"compose_toolbar_picture_highlighted"
                            type:YCLComposeToolBarButtonTypePicture];
        [self addButtonWithImage:@"compose_mentionbutton_background"
                highlightedImage:@"compose_mentionbutton_background_highlighted"
                            type:YCLComposeToolBarButtonTypeMention];
        [self addButtonWithImage:@"compose_trendbutton_background"
                highlightedImage:@"compose_trendbutton_background_highlighted"
                            type:YCLComposeToolBarButtonTypeTrend];
        [self addButtonWithImage:@"compose_emoticonbutton_background"
                highlightedImage:@"compose_emoticonbutton_background_highlighted"
                            type:YCLComposeToolBarButtonTypeEmotion];
        [self addButtonWithImage:@"compose_camerabutton_background"
                highlightedImage:@"compose_camerabutton_background_highlighted"
                            type:YCLComposeToolBarButtonTypeCamera];
    }
    return self;
}

- (void)addButtonWithImage:(NSString *)normalName highlightedImage:(NSString *)highlightedName type:(YCLComposeToolBarButtonType)type {
    UIButton *button = [[UIButton alloc] init];
    button.tag = type;
    [button setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedName] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(toolBarButtonOnClieked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)toolBarButtonOnClieked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(toolBar:didClickedButtonWithType:)]) {
        [self.delegate toolBar:self didClickedButtonWithType:(YCLComposeToolBarButtonType)button.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    int count = (int)self.subviews.count;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i<count; i++) {
        CGFloat buttonW = width / count;
        CGFloat buttonH = height;
        CGFloat buttonX = i * buttonW;
        CGFloat buttonY = 0;
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

+ (instancetype)toolBar {
    return [[self alloc] init];
}


@end
