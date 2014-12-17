//
//  YCLStatusFrame.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YCLStatus, YCLStatusDetailFrame;

@interface YCLStatusFrame : NSObject
/** 指定微博数据，计算frame */
@property (strong, nonatomic) YCLStatus *status;

/** 微博详情frame */
@property (strong, nonatomic) YCLStatusDetailFrame *detailFrame;

/** 工具条frame */
@property (assign, nonatomic) CGRect toolBarFrame;

/** 总体frame */
@property (assign, nonatomic) CGRect frame;

/** 行高 */
@property (assign, nonatomic) CGFloat cellHeight;
@end
