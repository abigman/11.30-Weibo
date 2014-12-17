//
//  YCLStatusDetailFrame.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YCLStatus, YCLStatusOriginalFrame, YCLStatusRetweetedFrame;

@interface YCLStatusDetailFrame : NSObject
/** 指定微博数据，计算frame */
@property (strong, nonatomic) YCLStatus *status;

/** 原创微博frame */
@property (strong, nonatomic) YCLStatusOriginalFrame *originalFrame;
/** 转发微博frame */
@property (strong, nonatomic) YCLStatusRetweetedFrame *retweetedFrame;

/** 总体frame */
@property (assign, nonatomic) CGRect frame;
@end
