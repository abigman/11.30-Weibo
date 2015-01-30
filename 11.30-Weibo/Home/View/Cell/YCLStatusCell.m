//
//  YCLStatusCellView.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusCell.h"
#import "YCLStatusCellDetail.h"
#import "YCLStatusCellToolBar.h"
#import "YCLStatusFrame.h"

@interface YCLStatusCell ()
/** 微博详情 */
@property(weak, nonatomic) YCLStatusCellDetail *statusDetail;
/** 微博工具条 */
@property(weak, nonatomic) YCLStatusCellToolBar *statusToolBar;
@end

@implementation YCLStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    //
    self.backgroundColor = [UIColor clearColor];

    // 添加 微博详情
    YCLStatusCellDetail *statusDetail = [[YCLStatusCellDetail alloc] init];
    [self.contentView addSubview:statusDetail];
    self.statusDetail = statusDetail;

    // 添加 工具条
    YCLStatusCellToolBar *statusToolBar = [[YCLStatusCellToolBar alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
  }
  return self;
}

- (void)setStatusFrame:(YCLStatusFrame *)statusFrame {
  _statusFrame = statusFrame;

  self.frame = _statusFrame.frame;
  self.statusDetail.detailFrame = _statusFrame.detailFrame;
  self.statusToolBar.frame = _statusFrame.toolBarFrame;
  self.statusToolBar.statusFrame = statusFrame;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
  static NSString *identifier = @"HomeCell";
  YCLStatusCell *cell =
      [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    NSLog(@"新建 ----");
    cell = [[YCLStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                reuseIdentifier:identifier];
  } else {
    NSLog(@"---- 缓存");
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

@end
