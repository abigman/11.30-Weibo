//
//  YCLToolBar.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/13.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YCLComposeToolBarButtonTypeCamera,
    YCLComposeToolBarButtonTypeEmotion,
    YCLComposeToolBarButtonTypePicture,
    YCLComposeToolBarButtonTypeLocate,
    YCLComposeToolBarButtonTypeMention,
    YCLComposeToolBarButtonTypeTrend
} YCLComposeToolBarButtonType;

@class YCLToolBar;

@protocol YCLToolBarDelegate <NSObject>

@optional
- (void)toolBar:(YCLToolBar *)toolBar didClickedButtonWithType:(YCLComposeToolBarButtonType)type;

@end

@interface YCLToolBar : UIView

/** 代理 */
@property (weak, nonatomic) id<YCLToolBarDelegate> delegate;
+ (instancetype)toolBar;
@end
