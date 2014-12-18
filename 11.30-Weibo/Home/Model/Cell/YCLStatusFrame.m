//
//  YCLStatusFrame.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusFrame.h"
#import "YCLStatus.h"
#import "YCLStatusDetailFrame.h"
#import "YCLStatusStyle.h"

@implementation YCLStatusFrame
- (void)setStatus:(YCLStatus *)status {
    _status = status;
    
     // 计算微博详情 frame
    [self setupDetailFrame];
    
    // 计算工具栏 frame
    [self setupToolBarFrame];
    
    // 总体
    CGFloat frameX = 0;
    CGFloat frameY = 0;
    CGFloat frameW = [UIScreen mainScreen].bounds.size.width;
    CGFloat frameH = CGRectGetMaxY(self.toolBarFrame);
    self.frame = CGRectMake(frameX, frameY, frameW, frameH);
    
    self.cellHeight = CGRectGetMaxY(self.frame);
}

/**
 *    设置微博详情frame
 */
- (void)setupDetailFrame {
    YCLStatusDetailFrame *detailFrame = [[YCLStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    self.detailFrame = detailFrame;
}

/**
 *    设置工具条frame
 */
- (void)setupToolBarFrame {

    CGFloat toolBarX = 0;
    CGFloat toolBarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolBarW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolBarH = 35;
    self.toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
}


@end
