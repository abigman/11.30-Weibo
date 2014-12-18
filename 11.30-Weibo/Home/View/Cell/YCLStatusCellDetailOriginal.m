//
//  YCLStatusOriginal.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusCellDetailOriginal.h"
#import "YCLStatusOriginalFrame.h"
#import "YCLStatus.h"
#import "YCLUser.h"
#import "UIImageView+WebCache.h"
#import "YCLStatusStyle.h"

@interface YCLStatusCellDetailOriginal ()
/** 头像视图 */
@property (weak, nonatomic) UIImageView *avatarView;
/** 昵称视图 */
@property (weak, nonatomic) UILabel *nameLabel;
/** 时间视图 */
@property (weak, nonatomic) UILabel *timeLabel;
/** 来源视图 */
@property (weak, nonatomic) UILabel *sourceLabel;
/** 正文视图 */
@property (weak, nonatomic) UILabel *textLabel;
@end

@implementation YCLStatusCellDetailOriginal

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        // 头像
        UIImageView *avatarView = [[UIImageView alloc] init];
        [self addSubview:avatarView];
        self.avatarView = avatarView;
        
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor greenColor];
        nameLabel.font = kStatusNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.backgroundColor = [UIColor greenColor];
        timeLabel.font = kStatusTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.backgroundColor = [UIColor greenColor];
        sourceLabel.font = kStatusSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 正文
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor greenColor];
        textLabel.numberOfLines = 0;
        textLabel.font = kStatusTextFont;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
    }
    return self;
}

- (void)setOriginalFrame:(YCLStatusOriginalFrame *)originalFrame {
    _originalFrame = originalFrame;
    
    YCLStatus *status = _originalFrame.status;

    // 设置内容
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_compose_music"]];
    self.nameLabel.text = status.user.name;
    self.timeLabel.text = status.created_at;
    self.sourceLabel.text = status.source;
    self.textLabel.text = status.text;
    
    // 设置frame
    self.frame = _originalFrame.frame;
    self.avatarView.frame = _originalFrame.avatarFrame;
    self.nameLabel.frame = _originalFrame.nameFrame;
    self.timeLabel.frame = _originalFrame.timeFrame;
    self.sourceLabel.frame = _originalFrame.sourceFrame;
    self.textLabel.frame = _originalFrame.textFrame;
}

@end
