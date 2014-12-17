//
//  YCLStatusRetweetedFrame.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusRetweetedFrame.h"
#import "YCLStatus.h"
#import "YCLUser.h"
#import "NSString+YCLTextSize.h"
#import "YCLStatusStyle.h"


@implementation YCLStatusRetweetedFrame
- (void)setStatus:(YCLStatus *)status {
    _status = status;
    
    // 计算 frame
    
    // 昵称
    CGFloat nameX = kCellMargin;
    CGFloat nameY = kCellMargin;
    CGSize nameSize = [_status.user.name sizeWithFont:kStatusNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 正文
    CGFloat textX = kCellMargin;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + kCellMargin;
    CGSize textSize = [_status.text sizeWithFont:kStatusTextFont maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * kCellMargin, MAXFLOAT)];
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    // 总体
    CGFloat frameX = 0;
    CGFloat frameY = 0;
    CGFloat frameW = [UIScreen mainScreen].bounds.size.width;
    CGFloat frameH = CGRectGetMaxY(self.textFrame) + kCellMargin;
    self.frame = CGRectMake(frameX, frameY, frameW, frameH);
 
}

@end
