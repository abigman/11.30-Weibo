//
//  YCLStatusOriginalFrame.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YCLStatus;

@interface YCLStatusOriginalFrame : NSObject
/** 指定微博数据，计算frame */
@property (strong, nonatomic) YCLStatus *status;

/** 头像 */
@property (assign, nonatomic) CGRect avatarFrame;
/** 昵称 */
@property (assign, nonatomic) CGRect nameFrame;
/** 时间 */
@property (assign, nonatomic) CGRect timeFrame;
/** 来源 */
@property (assign, nonatomic) CGRect sourceFrame;
/** 正文 */
@property (assign, nonatomic) CGRect textFrame;

/** 总体frame */
@property (assign, nonatomic) CGRect frame;
@end
