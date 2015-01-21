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
    
    // VIP
    CGFloat vipImageViewW = 14;
    CGFloat vipImageViewH = 14;
    CGFloat vipImageViewX = CGRectGetMaxX(self.nameFrame) + kCellMargin;
    CGFloat vipImageViewY = CGRectGetMaxY(self.nameFrame) - vipImageViewH - 2;
    
    self.vipImageViewFrame = CGRectMake(vipImageViewX, vipImageViewY, vipImageViewW, vipImageViewH);
    
    // 正文
    CGFloat textX = kCellMargin;
    CGFloat textY = CGRectGetMaxY(self.avatarFrame) + kCellMargin;
    CGSize textSize = [_status.text sizeWithFont:kStatusTextFont maxSize:CGSizeMake(kScreenWidth - 2 * kCellMargin, MAXFLOAT)];
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    
    // 配图 九宫格
    if (status.pic_urls.count > 0) {
        // 显示几行
        int showColumns = 3;
        CGFloat viewWH = 80;
        
        // 需要显示的行数
        NSUInteger picCount = status.pic_urls.count;
        NSUInteger maxRow = (picCount + showColumns - 1) / showColumns;
        NSUInteger maxColumn = picCount < showColumns ? picCount : showColumns;
        CGFloat maxWidth = (kCellMargin + viewWH) * maxColumn - kCellMargin;
        CGFloat maxHeight = (kCellMargin + viewWH) * maxRow - kCellMargin;
        
        CGFloat pictureViewX = kCellMargin;
        CGFloat pictureViewY = CGRectGetMaxY(self.textFrame) + kCellMargin;
        CGFloat pictureViewW = maxWidth;
        CGFloat pictureViewH = maxHeight;
        self.pictureViewFrame = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);

    }
    
    
    // 总体
    CGFloat frameX = 0;
    CGFloat frameY = 0;
    CGFloat frameW = kScreenWidth;
    CGFloat frameH = 0;
    if (status.pic_urls.count > 0) {
        frameH = CGRectGetMaxY(self.pictureViewFrame) + kCellMargin;
    } else {
        frameH = CGRectGetMaxY(self.textFrame) + kCellMargin;
    }
    self.frame = CGRectMake(frameX, frameY, frameW, frameH);
}

@end
