//
//  YCLRefreshView.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/12.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLRefreshView.h"

@implementation YCLRefreshView

+ (UIView *)refreshView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YCLRefreshView" owner:nil options:nil] firstObject];
}

@end
