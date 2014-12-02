//
//  YCLPopMenu.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/2.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLPopMenu.h"
#import "UIImage+YCLImage.h"
#import "UIView+YCLGeometry.h"

@interface YCLPopMenu ()
/** contentView */
@property (strong, nonatomic) UIView *contentView;

/** 遮盖 */
@property (weak, nonatomic) UIButton *cover;
/** 容器 */
@property (weak, nonatomic) UIImageView *container;
@end

@implementation YCLPopMenu

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 遮盖按钮
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(coverOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        // 添加容器
        UIImageView *container = [[UIImageView alloc] init];
        container.userInteractionEnabled = YES;
        container.image = [UIImage resizableImageNamed:@"popover_background"];
        [self addSubview:container];
        self.container = container;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.cover.frame = self.bounds;
}

- (void)coverOnClicked:(UIButton *)sender {
    NSLog(@"点击了 cover");
    [self dismiss];
}

- (instancetype)initWithContentView:(UIView *)contentView {
    if (self = [super init]) {
        self.contentView = contentView;
    }
    return self;
}

+ (instancetype)popMenuWithContentView:(UIView *)contentView {
    return [[self alloc] initWithContentView:contentView];
}

- (void)showInRect:(CGRect)rect {
    // 菜单添加到窗口上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    // 外加指定的 rect 设置给容器
    self.container.frame = rect;
    
    // 容器是显示 contentView 的
    [self.container addSubview:self.contentView];
}

- (void)dismiss {
    if ([self.delegate respondsToSelector:@selector(popMenuDidDismiss:)]) {
        [self.delegate popMenuDidDismiss:self];
    }
    
    [self removeFromSuperview];
}

- (void)setDimBackground:(BOOL)dimBackground {
    _dimBackground = dimBackground;
    
    if (_dimBackground) {
        self.cover.backgroundColor = [UIColor blackColor];
        self.cover.alpha = 0.4;
    } else {
        self.cover.backgroundColor = [UIColor clearColor];
        self.cover.alpha = 1.0;
    }
}

- (void)setPopMenuType:(YCLPopMenuType)popMenuType {
    _popMenuType = popMenuType;
    
    switch (_popMenuType) {
        case YCLPopMenuTypeLeft:
            self.container.image = [UIImage resizableImageNamed:@"popover_background_left"];
            break;
        case YCLPopMenuTypeRight:
            self.container.image = [UIImage resizableImageNamed:@"popover_background_right"];
            break;
        default:
            self.container.image = [UIImage resizableImageNamed:@"popover_background"];
            break;
    }
}

@end
