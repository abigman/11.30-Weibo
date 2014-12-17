//
//  YCLStatusDetail.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusCellDetail.h"
#import "YCLStatusCellDetailOriginal.h"
#import "YCLStatusCellDetailRetweeted.h"
#import "YCLStatusDetailFrame.h"

@interface YCLStatusCellDetail ()
/** 原创微博 */
@property (weak, nonatomic) YCLStatusCellDetailOriginal *detailOriginal;
/** 转发微博 */
@property (weak, nonatomic) YCLStatusCellDetailRetweeted *detailRetweeted;
@end


@implementation YCLStatusCellDetail

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加原创微博
        YCLStatusCellDetailOriginal *detailOriginal = [[YCLStatusCellDetailOriginal alloc] init];
        detailOriginal.backgroundColor = [UIColor whiteColor];
        [self addSubview:detailOriginal];
        self.detailOriginal = detailOriginal;
        
        // 添加转发微博
        YCLStatusCellDetailRetweeted *detailRetweeted = [[YCLStatusCellDetailRetweeted alloc] init];
        detailRetweeted.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"]];
        [self addSubview:detailRetweeted];
        self.detailRetweeted = detailRetweeted;
    }
    return self;
}

- (void)setDetailFrame:(YCLStatusDetailFrame *)detailFrame {
    _detailFrame = detailFrame;
    
    self.frame = _detailFrame.frame;
    self.detailOriginal.originalFrame = _detailFrame.originalFrame;
    self.detailRetweeted.retweetedFrame = _detailFrame.retweetedFrame;
}

@end
