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
#import "YCLStatusPicturesView.h"

@interface YCLStatusCellDetailRetweeted ()
/** 昵称视图 */
@property (weak, nonatomic) UILabel *nameLabel;
/** 正文视图 */
@property (weak, nonatomic) UILabel *textLabel;
/** 配图视图 */
@property (weak, nonatomic) YCLStatusPicturesView *picturesView;

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
        
        // 配图
        YCLStatusPicturesView *picturesView = [[YCLStatusPicturesView alloc] init];
        picturesView.backgroundColor = [UIColor redColor];
        [self addSubview:picturesView];
        self.picturesView = picturesView;
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
    
    // 配图
    if (status.pic_urls.count > 0) {
        self.picturesView.hidden = NO;
        
        //  status.pic_urls 保存 YCLPicture对象（其thumbnail_pic属性 保存着图片地址）
        
        self.picturesView.pictures = status.pic_urls;  // 提供数据后 计算出了 frame
        self.picturesView.frame = retweetedFrame.pictureViewFrame;
    } else {
        
        self.picturesView.hidden = YES;
    }
}
@end
