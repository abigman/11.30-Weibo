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
#import "NSString+YCLTextSize.h"

@interface YCLStatusCellDetailOriginal ()
/** 头像视图 */
@property (weak, nonatomic) UIImageView *avatarView;
/** 昵称视图 */
@property (weak, nonatomic) UILabel *nameLabel;
/** 会员等级 */
@property (weak, nonatomic) UIImageView *vipImageView;
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
        nameLabel.font = kStatusNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // VIP
        UIImageView *vipImageView = [[UIImageView alloc] init];
        vipImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipImageView];
        self.vipImageView = vipImageView;
        
        
        // 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor orangeColor];
        timeLabel.font = kStatusTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = kStatusSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 正文
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.font = kStatusTextFont;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
    }
    return self;
}

- (void)setOriginalFrame:(YCLStatusOriginalFrame *)originalFrame {
    _originalFrame = originalFrame;
//    NSLog(@"%s", __func__);
    
    YCLStatus *status = _originalFrame.status;

    // 设置内容
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_compose_music"]];
    self.nameLabel.text = status.user.name;
    if (status.user.mbtype  > 2) {
        // 是会员
        self.nameLabel.textColor = [UIColor redColor];
        self.vipImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank]];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
    }
    self.timeLabel.text = status.created_at;
    self.sourceLabel.text = status.source;
    self.textLabel.text = status.text;
    
    
    // 设置frame
    self.frame = _originalFrame.frame;
    self.avatarView.frame = _originalFrame.avatarFrame;
    self.nameLabel.frame = _originalFrame.nameFrame;
    if (status.user.mbtype > 2) {
        self.vipImageView.hidden = NO;
        self.vipImageView.frame = _originalFrame.vipImageViewFrame;
    } else {
        self.vipImageView.hidden = YES;
        
    }
    
    // 时间 （时间会变化，变化后需要重写计算）
    CGFloat timeX = CGRectGetMaxX(self.avatarView.frame) + kCellMargin;
    CGSize timeSize = [_originalFrame.status.created_at sizeWithFont:kStatusTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat timeW = timeSize.width;
    CGFloat timeH = timeSize.height;
    CGFloat timeY = CGRectGetMaxY(self.avatarView.frame) - timeH;
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 来源 （来源虽然不会变，但是位置依赖于时间标签，所以应该放在这个位置）
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + kCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_originalFrame.status.source sizeWithFont:kStatusSourceFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat sourceW = sourceSize.width;
    CGFloat sourceH = sourceSize.height;
    self.sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceW, sourceH);

    self.textLabel.frame = _originalFrame.textFrame;
}

@end
