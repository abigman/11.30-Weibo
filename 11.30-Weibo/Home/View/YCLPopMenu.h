//
//  YCLPopMenu.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/2.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCLPopMenu;
@protocol YCLPopMenuDelegate <NSObject>
@optional
- (void)popMenuDidDismiss:(YCLPopMenu *)popMenu;

@end

@interface YCLPopMenu : UIView
/** 代理 */
@property (weak, nonatomic) id<YCLPopMenuDelegate> delegate;

- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;
- (void)showInRect:(CGRect)rect;
- (void)dismiss;
@end
