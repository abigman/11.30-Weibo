//
//  YCLStatusRetweeted.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusCellDetailRetweeted.h"
#import "YCLStatusRetweetedFrame.h"
#import "YCLStatus.h"
#import "YCLUser.h"
#import "YCLStatusStyle.h"

@interface YCLStatusCellDetailRetweeted ()
/** 昵称视图 */
@property (weak, nonatomic) UILabel *nameLabel;
/** 正文视图 */
@property (weak, nonatomic) UILabel *textLabel;
@end

@implementation YCLStatusCellDetailRetweeted

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kStatusNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;

        // 正文
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = kStatusTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
    }
    return self;
}

- (void)setRetweetedFrame:(YCLStatusRetweetedFrame *)retweetedFrame {
    _retweetedFrame = retweetedFrame;
    
    // 设置内容
    YCLStatus *status = _retweetedFrame.status;
    
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", status.user.name];
    self.textLabel.text = status.text;
    
    // 设置frame
    self.frame = _retweetedFrame.frame;
    self.nameLabel.frame = _retweetedFrame.nameFrame;
    self.textLabel.frame = _retweetedFrame.textFrame;
}
@end
