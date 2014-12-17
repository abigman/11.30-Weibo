//
//  YCLStatusDetailFrame.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusDetailFrame.h"
#import "YCLStatusOriginalFrame.h"
#import "YCLStatusRetweetedFrame.h"
#import "YCLStatus.h"
#import "YCLStatusStyle.h"

@implementation YCLStatusDetailFrame
- (void)setStatus:(YCLStatus *)status {
    _status = status;
    
    // 原创微博部分
    [self setupOriginalFrame];
    
    // 转发微博部分
    [self setupRetweetedFrame];
    
    // 总体
    CGFloat frameX = 0;
    CGFloat frameY = kCellMargin;
    CGFloat frameW = [UIScreen mainScreen].bounds.size.width;
    CGFloat frameH = 0;
    if (status.retweeted_status) {
        // 有转发微博
        frameH = CGRectGetMaxY(self.retweetedFrame.frame);
    } else {
        // 没有转发微博
        frameH = CGRectGetMaxY(self.originalFrame.frame);
    }
    self.frame = CGRectMake(frameX, frameY, frameW, frameH);
}

/**
 *    设置原创微博frame
 */
- (void)setupOriginalFrame {
    YCLStatusOriginalFrame *originalFrame = [[YCLStatusOriginalFrame alloc] init];
    originalFrame.status = self.status;
    self.originalFrame = originalFrame;
}

/**
 *    设置转发微博frame
 */
- (void)setupRetweetedFrame {
    // 如果没有转发微博，无需计算
    if (self.status.retweeted_status) {
        YCLStatusRetweetedFrame *retweetedFrame = [[YCLStatusRetweetedFrame alloc] init];
        retweetedFrame.status = self.status.retweeted_status;
        
        // 修改 转发微博frame
        CGRect oldFrame = retweetedFrame.frame;
        oldFrame.origin.y = CGRectGetMaxY(self.originalFrame.frame);
        retweetedFrame.frame = oldFrame;
        self.retweetedFrame = retweetedFrame;
    }
}
@end
