//
//  YCLStatusOriginalFrame.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusOriginalFrame.h"
#import "YCLStatus.h"
#import "YCLUser.h"
#import "NSString+YCLTextSize.h"
#import "YCLStatusStyle.h"

@implementation YCLStatusOriginalFrame

- (void)setStatus:(YCLStatus *)status {
    _status = status;
    
    // 计算 frame
    // 头像
    CGFloat avatarX = kCellMargin;
    CGFloat avatarY = kCellMargin;
    CGFloat avatarW = 35;
    CGFloat avatarH = 35;
    self.avatarFrame = CGRectMake(avatarX, avatarY, avatarW, avatarH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.avatarFrame) + kCellMargin;
    CGFloat nameY = kCellMargin;
    CGSize nameSize = [_status.user.name sizeWithFont:kStatusNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 时间
    CGFloat timeX = nameX;
    CGSize timeSize = [_status.created_at sizeWithFont:kStatusTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat timeW = timeSize.width;
    CGFloat timeH = timeSize.height;
    CGFloat timeY = CGRectGetMaxY(self.avatarFrame) - timeH;
    self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + kCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_status.source sizeWithFont:kStatusSourceFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat sourceW = sourceSize.width;
    CGFloat sourceH = sourceSize.height;
    self.sourceFrame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    // 正文
    CGFloat textX = kCellMargin;
    CGFloat textY = CGRectGetMaxY(self.avatarFrame) + kCellMargin;
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
