//
//  YCLStatusCellToolBar.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusCellToolBar.h"
#import "YCLStatusFrame.h"
#import "YCLStatus.h"

typedef NS_ENUM(NSUInteger, YCLStatusToolBarButtonType) {
  YCLStatusToolBarButtonTypeRetweeted = 1 << 0,
  YCLStatusToolBarButtonTypeComment = 1 << 1,
  YCLStatusToolBarButtonTypeLike = 1 << 2
};

@interface YCLStatusCellToolBar ()
/** 按钮数组 */
@property(copy, nonatomic) NSMutableArray *buttons;

@end
@implementation YCLStatusCellToolBar

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];

    // 添加 转发、评论、赞 三个按钮
    [self.buttons
        addObject:[self buttoWithTitle:@"转发"
                                 image:@"timeline_icon_retweet"
                                  type:YCLStatusToolBarButtonTypeRetweeted]];
    [self.buttons
        addObject:[self buttoWithTitle:@"评论"
                                 image:@"timeline_icon_comment"
                                  type:YCLStatusToolBarButtonTypeComment]];
    [self.buttons
        addObject:[self buttoWithTitle:@"赞"
                                 image:@"timeline_icon_like_disable"
                                  type:YCLStatusToolBarButtonTypeLike]];
  }
  return self;
}

- (NSMutableArray *)buttons {
  if (!_buttons) {
    _buttons = [NSMutableArray array];
  }
  return _buttons;
}

- (UIButton *)buttoWithTitle:(NSString *)title
                       image:(NSString *)imageName
                        type:(YCLStatusToolBarButtonType)type {
  UIButton *button = [[UIButton alloc] init];
  //  button.backgroundColor = [UIColor lightGrayColor];
  button.titleLabel.font = [UIFont systemFontOfSize:12];
  //  button.imageView.contentMode = UIViewContentModeCenter;
  //  button.imageView.backgroundColor = [UIColor redColor];
  [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
  [button setTitle:title forState:UIControlStateNormal];
  [button setImage:[UIImage imageNamed:imageName]
          forState:UIControlStateNormal];
  button.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
  button.tag = type;
  [self addSubview:button];
  [self addSubview:button];
  return button;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  NSUInteger column = self.buttons.count;
  CGFloat buttonW = [UIScreen mainScreen].bounds.size.width / column;
  CGFloat buttonH = self.frame.size.height;
  for (int i = 0; i < column; i++) {
    CGFloat buttonY = 0;
    CGFloat buttonX = i * buttonW;
    UIButton *button = self.buttons[i];
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
  }
}

- (void)setStatusFrame:(YCLStatusFrame *)statusFrame {
  _statusFrame = statusFrame;

  YCLStatus *status = statusFrame.status;

  for (UIButton *button in self.buttons) {
    switch (button.tag) {
      case YCLStatusToolBarButtonTypeRetweeted:
        [button setTitle:status.reposts_count > 0
                             ? [NSString
                                   stringWithFormat:@"%d", status.reposts_count]
                             : @"转发"
                forState:UIControlStateNormal];
        break;
      case YCLStatusToolBarButtonTypeComment:
        [button setTitle:status.comments_count > 0
                             ? [NSString stringWithFormat:@"%d",
                                                          status.comments_count]
                             : @"评论"
                forState:UIControlStateNormal];
        break;

      case YCLStatusToolBarButtonTypeLike:
        [button
            setTitle:status.attitudes_count > 0
                         ? [NSString
                               stringWithFormat:@"%d", status.attitudes_count]
                         : @"赞"
            forState:UIControlStateNormal];
        break;
    }
  }
}

@end