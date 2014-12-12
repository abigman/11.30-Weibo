//
//  YCLRefreshView.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/12.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCLRefreshView : UIView
@property (weak, nonatomic) IBOutlet UITextField *textLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
+ (UIView *)refreshView;
@end
