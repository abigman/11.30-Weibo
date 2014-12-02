//
//  YCLPopMenu.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/2.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YCLPopMenuTypeLeft = 0,
    YCLPopMenuTypeMiddle,
    YCLPopMenuTypeRight,
} YCLPopMenuType;

@class YCLPopMenu;
@protocol YCLPopMenuDelegate <NSObject>
@optional
- (void)popMenuDidDismiss:(YCLPopMenu *)popMenu;

@end

@interface YCLPopMenu : UIView
/** 代理 */
@property (weak, nonatomic) id<YCLPopMenuDelegate> delegate;
/** 是否遮盖 */
@property (assign, getter=isDimBackground, nonatomic) BOOL dimBackground;
/** 背景样式 */
@property (assign, nonatomic) YCLPopMenuType popMenuType;

- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;
- (void)showInRect:(CGRect)rect;
- (void)dismiss;
@end
